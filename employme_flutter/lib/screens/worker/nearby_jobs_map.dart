import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';

class NearbyJobsMap extends StatefulWidget {
  const NearbyJobsMap({super.key});
  @override
  State<NearbyJobsMap> createState() => _NearbyJobsMapState();
}

class _NearbyJobsMapState extends State<NearbyJobsMap> {
  double _radius = 2.0;
  String _filter = 'All';
  final DraggableScrollableController _sheetCtrl = DraggableScrollableController();

  final _nearbyJobs = [
    {'emoji': '🏪', 'title': 'Shop Assistant', 'company': 'Sri Ganesh Store', 'salary': '₹12,000/mo', 'dist': '6 min', 'urgent': true, 'verified': true, 'lat': 0.3, 'lng': 0.4},
    {'emoji': '🍳', 'title': 'Kitchen Helper', 'company': 'Hotel Udupi', 'salary': '₹500/day', 'dist': '12 min', 'urgent': false, 'verified': true, 'lat': 0.6, 'lng': 0.3},
    {'emoji': '🚚', 'title': 'Delivery Partner', 'company': 'QuickMart', 'salary': '₹600/day', 'dist': '18 min', 'urgent': false, 'verified': false, 'lat': 0.7, 'lng': 0.7},
    {'emoji': '🧹', 'title': 'House Cleaner', 'company': 'CleanHome Services', 'salary': '₹400/day', 'dist': '8 min', 'urgent': true, 'verified': true, 'lat': 0.2, 'lng': 0.6},
    {'emoji': '👷', 'title': 'Construction Helper', 'company': 'BuildRight', 'salary': '₹700/day', 'dist': '22 min', 'urgent': false, 'verified': false, 'lat': 0.8, 'lng': 0.2},
  ];

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
      ]),
      bottomNavigationBar: const WorkerNav(currentIndex: 1),
    );
  }

  Widget _mapView() => SizedBox.expand(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFB2DFDB)]),
      ),
      child: Stack(children: [
        // Grid lines for map feel
        ...List.generate(8, (i) => Positioned(left: 0, right: 0, top: (i + 1) * MediaQuery.of(context).size.height / 9,
          child: Container(height: 0.5, color: Colors.black.withOpacity(0.04)))),
        ...List.generate(6, (i) => Positioned(top: 0, bottom: 0, left: (i + 1) * MediaQuery.of(context).size.width / 7,
          child: Container(width: 0.5, color: Colors.black.withOpacity(0.04)))),
        // Radius circle
        Center(child: Container(
          width: _radius * 60, height: _radius * 60,
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.08),
            border: Border.all(color: AppColors.primary.withOpacity(0.25), width: 1.5)),
        )),
        // User pin (center)
        Center(child: Container(
          width: 20, height: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12)]),
        )),
        // Job pins
        ..._nearbyJobs.asMap().entries.map((e) {
          final j = e.value;
          final cx = MediaQuery.of(context).size.width * (j['lng'] as double);
          final cy = MediaQuery.of(context).size.height * (j['lat'] as double) * 0.5 + 80;
          return Positioned(left: cx - 28, top: cy - 16, child: _jobPin(j));
        }),
      ]),
    ),
  );

  Widget _jobPin(Map<String, dynamic> job) => TapScale(
    onTap: () => Navigator.pushNamed(context, '/job-detail'),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: (job['urgent'] as bool) ? AppColors.alert : AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          boxShadow: AppShadows.elevated,
          border: Border.all(color: (job['urgent'] as bool) ? AppColors.alert : AppColors.border),
        ),
        child: Text(job['salary'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: (job['urgent'] as bool) ? Colors.white : AppColors.text)),
      ),
      CustomPaint(size: const Size(10, 6), painter: _TrianglePainter(color: (job['urgent'] as bool) ? AppColors.alert : AppColors.card)),
      Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: AppColors.card, shape: BoxShape.circle,
          boxShadow: AppShadows.card,
          border: Border.all(color: (job['verified'] as bool) ? AppColors.primary : AppColors.border, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(job['emoji'] as String, style: const TextStyle(fontSize: 16)),
      ),
    ]),
  );

  Widget _topBar() => Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), boxShadow: AppShadows.elevated),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 20)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Nearby Jobs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        Text('${_nearbyJobs.length} jobs within ${_radius.toStringAsFixed(0)} km', style: const TextStyle(fontSize: 12, color: AppColors.caption)),
      ])),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          const Text('Live', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
        ]),
      ),
    ]),
  );

  Widget _filterChips() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
    child: SizedBox(height: 34, child: ListView(scrollDirection: Axis.horizontal, children: [
      'All', 'Urgent 🔥', 'Verified ✓', 'Walking', '< ₹500/day', '₹500+/day',
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
    _controlBtn(Icons.add, () => setState(() { if (_radius < 5) _radius += 0.5; })),
    const SizedBox(height: 8),
    _controlBtn(Icons.remove, () => setState(() { if (_radius > 0.5) _radius -= 0.5; })),
    const SizedBox(height: 8),
    _controlBtn(Icons.my_location, () { HapticFeedback.lightImpact(); }),
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
          Text('${_nearbyJobs.length} jobs nearby', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
        itemCount: _nearbyJobs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _sheetJobCard(_nearbyJobs[i]),
      )),
    ]),
  );

  Widget _sheetJobCard(Map<String, dynamic> job) => TapScale(
    onTap: () => Navigator.pushNamed(context, '/job-detail'),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.sm)),
          alignment: Alignment.center,
          child: Text(job['emoji'] as String, style: const TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(job['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            if (job['urgent'] as bool) ...[const SizedBox(width: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), decoration: BoxDecoration(color: AppColors.alert.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: const Text('URGENT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.alert)))],
          ]),
          const SizedBox(height: 2),
          Text(job['company'] as String, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(job['salary'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary)),
          const SizedBox(height: 2),
          Text('🚶 ${job['dist']}', style: const TextStyle(fontSize: 11, color: AppColors.primaryDark, fontWeight: FontWeight.w600)),
        ]),
      ]),
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
