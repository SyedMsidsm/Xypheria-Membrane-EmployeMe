import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/ola_maps_service.dart';

class LocationAvailability extends StatefulWidget {
  const LocationAvailability({super.key});
  @override
  State<LocationAvailability> createState() => _LocationAvailabilityState();
}

class _LocationAvailabilityState extends State<LocationAvailability> {
  String _currentLocationName = 'Detecting location...';
  String _currentLocationSub = 'Please wait';
  double _currentLat = 12.8732;
  double _currentLng = 74.8436;
  String _travel = 'walk';
  final Set<String> _timings = {'Morning'};
  final Set<String> _days = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri'};
  bool _available = true;

  @override
  void initState() {
    super.initState();
    _detectCurrentLocation();
  }

  Future<void> _detectCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Fall back to default and reverse geocode it
        await _reverseGeocodeAndUpdate(_currentLat, _currentLng);
        return;
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await _reverseGeocodeAndUpdate(_currentLat, _currentLng);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        await _reverseGeocodeAndUpdate(_currentLat, _currentLng);
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      setState(() {
        _currentLat = position.latitude;
        _currentLng = position.longitude;
      });
      await _reverseGeocodeAndUpdate(position.latitude, position.longitude);
    } catch (e) {
      print('Location detection error: $e');
      // Fall back to default location
      await _reverseGeocodeAndUpdate(_currentLat, _currentLng);
    }
  }

  Future<void> _reverseGeocodeAndUpdate(double lat, double lng) async {
    final res = await OlaMapsService.reverseGeocode(lat, lng);
    if (res != null && mounted) {
      setState(() {
        _currentLocationName = res['name'] ?? 'Selected Location';
        _currentLocationSub = res['formatted_address'] ?? '';
      });
    } else if (mounted) {
      setState(() {
        _currentLocationName = 'Mangalore';
        _currentLocationSub = 'Karnataka, India';
      });
    }
  }

  void _toggleTiming(String logicKey) {
    setState(() {
      if (logicKey == 'Any Time') {
        _timings.clear();
        _timings.add('Any Time');
      } else {
        _timings.remove('Any Time');
        if (_timings.contains(logicKey)) {
          _timings.remove(logicKey);
          if (_timings.isEmpty) _timings.add('Any Time'); // Default back to Any Time
        } else {
          _timings.add(logicKey);
          if (_timings.contains('Morning') && 
              _timings.contains('Afternoon') && 
              _timings.contains('Evening') && 
              _timings.contains('Midnight')) {
            _timings.clear();
            _timings.add('Any Time');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                    child: const Icon(Icons.arrow_back, size: 20, color: AppColors.text),
                  ),
                ),
              ),
              _title(state), _map(), _locationCard(state), _travelSection(state), _daysSection(state), _timingSection(state), _availableNow(state),
            ]),
          )),
          Container(
            color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/profile-setup'),
              child: Text(state.tr('continue_party'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            )),
          ),
        ]),
      ),
    );
  }



  Widget _title(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('location_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
    const SizedBox(height: 8), 
    Text(state.tr('location_subtitle'), style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)),
  ]));

  Widget _map() => Padding(padding: const EdgeInsets.all(20), child: Container(
    width: double.infinity,
    height: 180, 
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(color: AppColors.primary.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
      ]
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(_currentLat, _currentLng),
            initialZoom: 15.0,
            interactionOptions: const InteractionOptions(flags: InteractiveFlag.none), // Static preview
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.xypheria.employeme',
            ),
          ],
        ),
        // Overlay a gradient to make it look a bit stylized and match the theme
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [AppColors.primary.withOpacity(0.1), AppColors.primary.withOpacity(0.3)],
              center: Alignment.center,
              radius: 0.8,
            ),
          ),
        ),
        // Center Pin
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              color: AppColors.primary, 
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 8, spreadRadius: 2)],
            ),
            child: const Center(child: Icon(Icons.location_pin, color: Colors.white, size: 24)),
          ),
        ),
        // Worker pins scattered around the real map

      ],
    ),
  ));

  Widget _floatingPin(double? top, double? bottom, double? right, double? left, String emoji, String label) {
    return Positioned(
      top: top, bottom: bottom, right: right, left: left,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)],
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          )
        ],
      ),
    );
  }

  Widget _locationCard(AppState state) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary, width: 1.5)),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Center(child: Icon(Icons.location_on, color: AppColors.primary, size: 20))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(_currentLocationName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)), 
        Text(_currentLocationSub, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ])),
      GestureDetector(
        onTap: _showMapPicker,
        child: Text(state.tr('change'), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
      ),
    ]),
  ));

  void _showMapPicker() {
    Timer? _debounce;
    List<Map<String, dynamic>> _searchResults = [];
    bool _isLoading = false;
    final String initialName = _currentLocationName;
    final String initialSub = _currentLocationSub;

    // Pending location - only committed on Confirm
    String _pendingName = _currentLocationName;
    String _pendingSub = _currentLocationSub;

    final MapController mapController = MapController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                ),
                const Text('Select Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                // Search field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Search area, street, city...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _isLoading ? const Padding(padding: EdgeInsets.all(12.0), child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))) : null,
                      filled: true,
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                    onChanged: (val) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () async {
                        if (val.trim().isEmpty) {
                          setModalState(() { _searchResults = []; _isLoading = false; });
                          return;
                        }
                        setModalState(() { _isLoading = true; });
                        final results = await OlaMapsService.getAutocomplete(val);
                        setModalState(() { _searchResults = results; _isLoading = false; });
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Map or search results
                if (_searchResults.isEmpty)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Stack(
                        children: [
                          FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: LatLng(_currentLat, _currentLng),
                              initialZoom: 14.0,
                              onMapEvent: (MapEvent event) {
                                if (event is MapEventMoveEnd) {
                                  final center = event.camera.center;
                                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                                  _debounce = Timer(const Duration(milliseconds: 800), () async {
                                    setModalState(() { _isLoading = true; });
                                    final res = await OlaMapsService.reverseGeocode(center.latitude, center.longitude);
                                    if (res != null) {
                                      setModalState(() {
                                        _pendingName = res['name'] ?? 'Selected Location';
                                        _pendingSub = res['formatted_address'] ?? '';
                                        _isLoading = false;
                                      });
                                    } else {
                                      setModalState(() { _isLoading = false; });
                                    }
                                  });
                                }
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.xypheria.employeme',
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 40.0),
                              child: Icon(Icons.location_on, size: 48, color: AppColors.primary),
                            ),
                          ),
                          // Bottom overlay showing current pin location
                          Positioned(
                            bottom: 16,
                            left: 16, right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on, color: AppColors.primary, size: 22),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: _isLoading
                                      ? const Text('Fetching address...', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontStyle: FontStyle.italic))
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(_pendingName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                                            if (_pendingSub.isNotEmpty)
                                              Text(_pendingSub, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                                          ],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        final mainText = item['structured_formatting']?['main_text'] ?? item['description'] ?? '';
                        final subText = item['structured_formatting']?['secondary_text'] ?? '';
                        return ListTile(
                          leading: const Icon(Icons.location_on, color: AppColors.primary),
                          title: Text(mainText, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: subText.isNotEmpty ? Text(subText, maxLines: 2, overflow: TextOverflow.ellipsis) : null,
                          onTap: () {
                            // Update pending location and move the map
                            final lat = double.tryParse(item['lat']?.toString() ?? '');
                            final lon = double.tryParse(item['lon']?.toString() ?? '');
                            setModalState(() {
                              _pendingName = mainText;
                              _pendingSub = subText;
                              _searchResults = [];
                            });
                            if (lat != null && lon != null) {
                              try {
                                mapController.move(LatLng(lat, lon), 16.0);
                              } catch (_) {}
                            }
                          },
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                // Cancel / Confirm buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              // Revert to original
                              setState(() {
                                _currentLocationName = initialName;
                                _currentLocationSub = initialSub;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              // Commit the pending location
                              setState(() {
                                _currentLocationName = _pendingName;
                                _currentLocationSub = _pendingSub;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _travelSection(AppState state) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label(state.tr('travel_distance_title')),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [
        _travelOpt('walk', '🚶', state.tr('walk'), '500m'), 
        _travelOpt('nearby', '🛺', state.tr('nearby_dist'), '2km'), 
        _travelOpt('any', '🚌', state.tr('any_dist'), '5km+')
      ]),
    )),
  ]);

  Widget _travelOpt(String id, String e, String l, String s) {
    final sel = _travel == id;
    return Expanded(child: GestureDetector(onTap: () => setState(() => _travel = id), child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10), color: sel ? AppColors.primary : AppColors.card,
      child: Column(children: [Text(e, style: const TextStyle(fontSize: 18)), Text(l, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.text)), Text(s, style: TextStyle(fontSize: 10, color: sel ? Colors.white70 : AppColors.caption))]),
    )));
  }

  Widget _daysSection(AppState state) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label(state.tr('days_available_title')),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d) {
      final sel = _days.contains(d);
      return GestureDetector(onTap: () => setState(() { if (sel) _days.remove(d); else _days.add(d); }),
        child: Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: sel ? AppColors.primary : AppColors.card, border: Border.all(color: sel ? AppColors.primary : AppColors.border)),
          alignment: Alignment.center, child: Text(state.tr(d.toLowerCase()), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: sel ? Colors.white : AppColors.text))));
    }).toList())),
  ]);

  Widget _timingSection(AppState state) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label(state.tr('preferred_timing_title')),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Wrap(spacing: 12, runSpacing: 12, children: [
      _chip('🌅', 'Morning', state), _chip('☀️', 'Afternoon', state), _chip('🌆', 'Evening', state), _chip('🌃', 'Midnight', state), _chip('🌙', 'Any Time', state),
    ])),
  ]);

  Widget _chip(String e, String logicKey, AppState state) { 
    final sel = _timings.contains(logicKey); 
    String displayKey = logicKey.toLowerCase().replaceAll(' ', '_');
    return GestureDetector(onTap: () => _toggleTiming(logicKey), child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: sel ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(24), border: Border.all(color: sel ? AppColors.primary : AppColors.border)),
    child: Text('$e ${state.tr(displayKey)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.text)))); 
  }

  Widget _availableNow(AppState state) => Padding(padding: const EdgeInsets.all(20), child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(state.tr('available_right_now'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        if (_available) Padding(padding: const EdgeInsets.only(top: 6), child: Row(children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)),
          const SizedBox(width: 6), Expanded(child: Text(state.tr('employers_see_ready'), style: const TextStyle(fontSize: 12, color: AppColors.primary))),
        ])),
      ])),
      Switch(value: _available, onChanged: (v) => setState(() => _available = v)),
    ]),
  ));

  Widget _label(String text) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 10), child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)));
}
