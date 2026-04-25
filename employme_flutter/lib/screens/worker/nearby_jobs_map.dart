import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';

class NearbyJobsMap extends StatefulWidget {
  const NearbyJobsMap({super.key});
  @override
  State<NearbyJobsMap> createState() => _NearbyJobsMapState();
}

class _NearbyJobsMapState extends State<NearbyJobsMap> {
  String _filter = 'All';
  final DraggableScrollableController _sheetCtrl = DraggableScrollableController();
  
  final MapController _mapCtrl = MapController();
  LatLng? _currentLocation;
  bool _isLoadingLocation = true;
  bool _showAlert = false;
  // TODO: Add Ola Maps API Key here. If empty, falls back to OpenStreetMap.
  final String _olaMapsApiKey = ''; 

  List<Map<String, dynamic>> _dynamicJobs = [];

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        final pos = await Geolocator.getCurrentPosition();
        _setLocation(LatLng(pos.latitude, pos.longitude));
      } else {
        _setLocation(const LatLng(12.8716, 74.8436));
      }
    } catch (e) {
      _setLocation(const LatLng(12.8716, 74.8436));
    }
  }

  void _setLocation(LatLng loc) {
    if (!mounted) return;
    final state = context.read<AppState>();

    setState(() {
      _currentLocation = loc;
      _isLoadingLocation = false;
      
      final source = state.workerFeedJobs.map((j) => {
              'emoji': j['emoji'],
              'title': j['title'],
              'company': j['company'],
              'salary': '${j['salary']}${j['period']}',
              'urgent': j['isUrgent'],
              'verified': j['verified'],
              'description': j['description'],
              'requirements': j['requirements'],
              'timing': j['timing'],
              'peopleNeeded': j['peopleNeeded'],
              'location': j['location'],
              'type': j['type'],
              'period': j['period'],
            }).toList();

      _dynamicJobs = source.asMap().entries.map((e) {
        final i = e.key;
        final j = e.value;
        // Deterministic offsets based on title hash or index to keep positions stable
        final dLat = (i % 2 == 0 ? 1 : -1) * (0.003 + (i * 0.002));
        final dLng = (i % 3 == 0 ? 1 : -1) * (0.003 + (i * 0.002));
        final jLat = loc.latitude + dLat;
        final jLng = loc.longitude + dLng;
        
        final distMeters = const Distance().as(LengthUnit.Meter, loc, LatLng(jLat, jLng));
        final walkMins = (distMeters / 80).ceil();
        final transitMins = (distMeters / 300).ceil() + 5; 
        final useWalk = walkMins <= 15;
        final time = useWalk ? walkMins : transitMins;
        
        return {
          ...j,
          'lat': jLat,
          'lng': jLng,
          'time': time,
          'mode': useWalk ? 'walk' : 'transit',
          'score': 100 - time,
        };
      }).toList();
      _dynamicJobs.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
    });

    // Trigger geofenced alert after map loads
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showAlert = true);
    });
  }

  List<Map<String, dynamic>> get _filteredJobs {
    if (_filter == 'All') return _dynamicJobs;
    return _dynamicJobs.where((j) {
      if (_filter == 'Urgent') return j['urgent'] == true;
      if (_filter == 'Verified') return j['verified'] == true;
      if (_filter == 'Walking') return j['mode'] == 'walk';
      if (_filter == '<') {
        final s = j['salary'].toString();
        return s.contains('500') || s.contains('400') || s.contains('300') || s.contains('200');
      }
      if (_filter == '₹500+/day') {
        final s = j['salary'].toString();
        return !s.contains('500') && !s.contains('400') && !s.contains('300') && !s.contains('200') && s.contains('day');
      }
      return true;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0E8),
      body: Stack(children: [
        // Map background
        _mapView(),
        // Top bar
        SafeArea(child: Column(children: [_topBar(), _filterChips()])),
        // Radius control
        Positioned(right: 16, bottom: MediaQuery.of(context).size.height * 0.45, child: _mapControls()),
        // Draggable bottom sheet
        DraggableScrollableSheet(
          controller: _sheetCtrl,
          initialChildSize: 0.38,
          minChildSize: 0.12,
          maxChildSize: 0.85,
          builder: (_, scrollCtrl) => _bottomSheet(scrollCtrl),
        ),
        // Geofenced Alert
        if (_showAlert && !context.read<AppState>().isEmployer) _buildZoneAlert(),
      ]),
      bottomNavigationBar: context.watch<AppState>().isEmployer 
          ? const EmployerNav(currentIndex: 1) 
          : const WorkerNav(currentIndex: 1),
    );
  }

  String get _tileUrl {
    if (_olaMapsApiKey.isNotEmpty) {
      return 'https://api.olamaps.io/tiles/vector/v1/styles/default/rendered/{z}/{x}/{y}.png?api_key=$_olaMapsApiKey';
    }
    return 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'; // Fallback to OSM
  }

  Widget _mapView() {
    if (_isLoadingLocation || _currentLocation == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }
    return FlutterMap(
      mapController: _mapCtrl,
      options: MapOptions(
        initialCenter: _currentLocation!,
        initialZoom: 14.5,
        interactionOptions: const InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
      ),
      children: [
        TileLayer(
          urlTemplate: _tileUrl,
          userAgentPackageName: 'com.example.employme',
        ),
        // Isochrone Opportunity Rings
        CircleLayer(
          circles: [
            CircleMarker( // 20 min radius (~1600m)
              point: _currentLocation!,
              color: AppColors.primary.withOpacity(0.04),
              borderColor: AppColors.primary.withOpacity(0.1),
              borderStrokeWidth: 1,
              radius: 1600,
              useRadiusInMeter: true,
            ),
            CircleMarker( // 10 min radius (~800m)
              point: _currentLocation!,
              color: AppColors.primary.withOpacity(0.06),
              borderColor: AppColors.primary.withOpacity(0.15),
              borderStrokeWidth: 1,
              radius: 800,
              useRadiusInMeter: true,
            ),
            CircleMarker( // 5 min radius (~400m)
              point: _currentLocation!,
              color: AppColors.primary.withOpacity(0.1),
              borderColor: AppColors.primary.withOpacity(0.3),
              borderStrokeWidth: 1.5,
              radius: 400,
              useRadiusInMeter: true,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            // User Location Pin
            Marker(
              point: _currentLocation!,
              width: 24, height: 24,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12)]),
              ),
            ),
            // Job/Worker Pins
            ..._filteredJobs.map((j) => Marker(
              point: LatLng(j['lat'] as double, j['lng'] as double),
              width: 80, height: 80,
              alignment: Alignment.topCenter,
              child: _itemPin(j),
            )),
          ],
        ),
      ],
    );
  }

  Widget _itemPin(Map<String, dynamic> item) {
    final state = context.read<AppState>();
    final isEmployer = state.isEmployer;
    final bool isUrgent = (item['urgent'] ?? false) as bool;

    return TapScale(
      onTap: () => Navigator.pushNamed(context, isEmployer ? '/worker-profile' : '/job-detail', arguments: isEmployer ? item['title'] : item),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: isUrgent ? AppColors.alert : AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            boxShadow: AppShadows.elevated,
            border: Border.all(color: isUrgent ? AppColors.alert : AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item['mode'] == 'walk' ? Icons.directions_walk : Icons.directions_bus, size: 10, color: isUrgent ? Colors.white : AppColors.text),
              const SizedBox(width: 2),
              Text('${item['time']}m', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: isUrgent ? Colors.white : AppColors.text)),
            ],
          ),
        ),
        CustomPaint(size: const Size(8, 5), painter: _TrianglePainter(color: isUrgent ? AppColors.alert : AppColors.card)),
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: AppColors.card, shape: BoxShape.circle,
            boxShadow: AppShadows.card,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          alignment: Alignment.center,
          child: Text(item['emoji'] ?? '👷', style: const TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }

  Widget _topBar() {
    final state = context.watch<AppState>();
    final isEmployer = state.isEmployer;
    final count = _filteredJobs.length;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), boxShadow: AppShadows.elevated),
      child: Row(children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(isEmployer ? 'Your Job Locations' : 'Nearby Jobs', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(isEmployer ? '$count active postings on map' : '$count opportunities in commute zone', style: const TextStyle(fontSize: 12, color: AppColors.caption)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            const Text('Live', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
          ]),
        ),
      ]),
    );
  }

  Widget _filterChips() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
    child: SizedBox(height: 34, child: ListView(scrollDirection: Axis.horizontal, children: [
      'All', 'Urgent', 'Verified', 'Walking', '< ₹500/day', '₹500+/day',
    ].map((f) {
      final active = _filter == f.split(' ')[0];
      return Padding(padding: const EdgeInsets.only(right: 8), child: TapScale(
        onTap: () => setState(() => _filter = f.split(' ')[0]),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            boxShadow: AppShadows.soft,
          ),
          child: Text(f, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.text)),
        ),
      ));
    }).toList())),
  );

  Widget _mapControls() => Column(children: [
    _controlBtn(Icons.add, () {
      _mapCtrl.move(_mapCtrl.camera.center, _mapCtrl.camera.zoom + 0.5);
    }),
    const SizedBox(height: 8),
    _controlBtn(Icons.remove, () {
      _mapCtrl.move(_mapCtrl.camera.center, _mapCtrl.camera.zoom - 0.5);
    }),
    const SizedBox(height: 8),
    _controlBtn(Icons.my_location, () {
      HapticFeedback.lightImpact();
      if (_currentLocation != null) {
        _mapCtrl.move(_currentLocation!, 14.5);
      }
    }),
  ]);

  Widget _controlBtn(IconData icon, VoidCallback onTap) => TapScale(
    onTap: onTap,
    child: Container(
      width: 40, height: 40,
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.sm), boxShadow: AppShadows.card),
      child: Icon(icon, size: 18, color: AppColors.text),
    ),
  );

  Widget _bottomSheet(ScrollController scrollCtrl) => Container(
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -4))],
    ),
    child: Column(children: [
      // Handle
      Container(margin: const EdgeInsets.only(top: 10, bottom: 6), width: 36, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
      // Header
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(context.read<AppState>().isEmployer ? 'Your Postings' : '${_filteredJobs.length} jobs nearby', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.sm)),
            child: const Text('Sort: Nearest', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          ),
        ]),
      ),
      // Job list
      Expanded(child: ListView.separated(
        controller: scrollCtrl,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        itemCount: _filteredJobs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _sheetJobCard(_filteredJobs[i]),
      )),
    ]),
  );

  Widget _sheetJobCard(Map<String, dynamic> item) {
    final state = context.read<AppState>();
    final isEmployer = state.isEmployer;
    final bool isUrgent = (item['urgent'] ?? false) as bool;

    return TapScale(
      onTap: () => Navigator.pushNamed(context, isEmployer ? '/worker-profile' : '/job-detail', arguments: isEmployer ? item['title'] : item),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
        child: Column(
          children: [
            Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.sm)),
                alignment: Alignment.center,
                child: Text(item['emoji'] ?? '👷', style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(item['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  if (isUrgent) ...[const SizedBox(width: 6),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: AppColors.alert.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(isEmployer ? 'READY' : 'URGENT', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: AppColors.alert)))],
                ]),
                const SizedBox(height: 2),
                Text((item['company'] ?? (isEmployer ? 'Trusted Worker' : 'Local Business')) as String, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
              ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text((item['salary'] ?? '₹500/day') as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.primaryLight.withOpacity(0.5), borderRadius: BorderRadius.circular(4)),
                  child: Text('AI Match: ${item['score']}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
                ),
              ]),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Icon(item['mode'] == 'walk' ? Icons.directions_walk : Icons.directions_bus, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text('${item['time']} min ${item['mode']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              const Spacer(),
              Text(isEmployer ? 'View Stats' : 'View Route', style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildZoneAlert() => Positioned(
    top: 130, left: 16, right: 16,
    child: TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: -50, end: 0),
      curve: Curves.easeOutBack,
      builder: (context, val, child) => Transform.translate(
        offset: Offset(0, val),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            boxShadow: AppShadows.elevated,
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
              child: const Icon(Icons.radar, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('High Demand Zone Entered', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
              SizedBox(height: 2),
              Text('3 urgent shifts nearby offering ₹600+/day. Apply now!', style: TextStyle(fontSize: 11, color: AppColors.text)),
            ])),
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => setState(() => _showAlert = false),
            )
          ]),
        ),
      ),
    ),
  );
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, 0)..lineTo(size.width / 2, size.height)..lineTo(size.width, 0)..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
