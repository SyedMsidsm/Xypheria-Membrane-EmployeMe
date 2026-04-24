import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class LocationAvailability extends StatefulWidget {
  const LocationAvailability({super.key});
  @override
  State<LocationAvailability> createState() => _LocationAvailabilityState();
}

class _LocationAvailabilityState extends State<LocationAvailability> {
  String _travel = 'walk';
  final Set<String> _timings = {'Morning'};
  final Set<String> _days = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri'};
  bool _available = true;

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
          _header(state),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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

  Widget _header(AppState state) => Container(
    color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 22)),
        Text('${state.tr('step')} 3 ${state.tr('of')} 3', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        _bar(AppColors.primary), const SizedBox(width: 4),
        _bar(AppColors.primary), const SizedBox(width: 4),
        Expanded(child: Container(height: 4, decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
          gradient: const LinearGradient(colors: [AppColors.primary, AppColors.border], stops: [0.7, 0.7])))),
      ]),
    ]),
  );

  Widget _bar(Color c) => Expanded(child: Container(height: 4, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(2))));

  Widget _title(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('location_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
    const SizedBox(height: 8), 
    Text(state.tr('location_subtitle'), style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)),
  ]));

  Widget _map() => Padding(padding: const EdgeInsets.all(20), child: Container(
    width: double.infinity,
    height: 180, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)]), border: Border.all(color: AppColors.border)),
    child: Stack(alignment: Alignment.center, children: [
      Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.12), border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2))),
      Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary, border: Border.all(color: Colors.white, width: 3)),
        child: const Icon(Icons.location_pin, size: 14, color: Colors.white)),
    ]),
  ));

  Widget _locationCard(AppState state) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary, width: 1.5)),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.location_on, size: 20, color: AppColors.primary)),
      const SizedBox(width: 12),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Kodialbail, Mangalore', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)), Text('Karnataka 575003', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ])),
      Text(state.tr('change'), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
    ]),
  ));

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
      _chip('🌅', 'Morning', state), _chip('☀️', 'Afternoon', state), _chip('🌆', 'Evening', state), _chip('🌙', 'Any Time', state),
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
