import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LocationAvailability extends StatefulWidget {
  const LocationAvailability({super.key});
  @override
  State<LocationAvailability> createState() => _LocationAvailabilityState();
}

class _LocationAvailabilityState extends State<LocationAvailability> {
  String _travel = 'walk';
  String _timing = 'Morning';
  final Set<String> _days = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri'};
  bool _available = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _title(), _map(), _locationCard(), _travelSection(), _daysSection(), _timingSection(), _availableNow(),
            ]),
          )),
        ]),
      ),
      bottomNavigationBar: Container(
        color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/profile-setup'),
          child: const Text('Continue / ಮುಂದುವರಿಯಿರಿ 🎉'),
        )),
      ),
    );
  }

  Widget _header() => Container(
    color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 22)),
        const Text('Step 3 of 3', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
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

  Widget _title() => const Padding(padding: EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Where are you available?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
    SizedBox(height: 4), Text('ನೀವು ಎಲ್ಲಿ ಲಭ್ಯರಿದ್ದೀರಿ?', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    SizedBox(height: 4), Text('Jobs will be shown within walking distance', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)),
  ]));

  Widget _map() => Padding(padding: const EdgeInsets.all(20), child: Container(
    height: 180, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9), Color(0xFFA5D6A7)]), border: Border.all(color: AppColors.border)),
    child: Stack(alignment: Alignment.center, children: [
      Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.12), border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2))),
      Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary, border: Border.all(color: Colors.white, width: 3)),
        child: const Icon(Icons.location_pin, size: 14, color: Colors.white)),
    ]),
  ));

  Widget _locationCard() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary, width: 1.5)),
    child: Row(children: [
      Container(width: 40, height: 40, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), child: const Icon(Icons.location_on, size: 20, color: AppColors.primary)),
      const SizedBox(width: 12),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Kodialbail, Mangalore', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)), Text('Karnataka 575003', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ])),
      const Text('Change', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
    ]),
  ));

  Widget _travelSection() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('How far will you travel?', 'ಎಷ್ಟು ದೂರ ಹೋಗಬಲ್ಲಿರಿ?'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border, width: 1.5), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [_travelOpt('walk', '🚶', 'Walk', '500m'), _travelOpt('nearby', '🛺', 'Nearby', '2km'), _travelOpt('any', '🚌', 'Any', '5km+')]),
    )),
  ]);

  Widget _travelOpt(String id, String e, String l, String s) {
    final sel = _travel == id;
    return Expanded(child: GestureDetector(onTap: () => setState(() => _travel = id), child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10), color: sel ? AppColors.primary : AppColors.card,
      child: Column(children: [Text(e, style: const TextStyle(fontSize: 18)), Text(l, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.text)), Text(s, style: TextStyle(fontSize: 10, color: sel ? Colors.white70 : AppColors.caption))]),
    )));
  }

  Widget _daysSection() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('When are you available?', 'ಯಾವಾಗ ಲಭ್ಯರಿದ್ದೀರಿ?'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((d) {
      final sel = _days.contains(d);
      return GestureDetector(onTap: () => setState(() { if (sel) _days.remove(d); else _days.add(d); }),
        child: Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: sel ? AppColors.primary : AppColors.card, border: Border.all(color: sel ? AppColors.primary : AppColors.border)),
          alignment: Alignment.center, child: Text(d, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: sel ? Colors.white : AppColors.text))));
    }).toList())),
  ]);

  Widget _timingSection() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('Preferred timing', 'ಆದ್ಯತೆಯ ಸಮಯ'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Wrap(spacing: 8, children: [
      _chip('🌅', 'Morning'), _chip('☀️', 'Afternoon'), _chip('🌆', 'Evening'), _chip('🌙', 'Any Time'),
    ])),
  ]);

  Widget _chip(String e, String l) { final sel = _timing == l; return GestureDetector(onTap: () => setState(() => _timing = l), child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: sel ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: sel ? AppColors.primary : AppColors.border)),
    child: Text('$e $l', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.text)))); }

  Widget _availableNow() => Padding(padding: const EdgeInsets.all(20), child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Available Right Now?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        const Text('ಈಗ ಕೆಲಸಕ್ಕೆ ತಯಾರಿದ್ದೀರಾ?', style: TextStyle(fontSize: 12, color: AppColors.primary)),
        if (_available) Padding(padding: const EdgeInsets.only(top: 6), child: Row(children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)),
          const SizedBox(width: 6), const Text("Employers can see you're ready!", style: TextStyle(fontSize: 12, color: AppColors.primary)),
        ])),
      ])),
      Switch(value: _available, onChanged: (v) => setState(() => _available = v), activeColor: AppColors.primary),
    ]),
  ));

  Widget _label(String en, String kn) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(en, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)), const SizedBox(height: 2), Text(kn, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
  ]));
}
