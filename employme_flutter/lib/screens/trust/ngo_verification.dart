import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NGOVerification extends StatelessWidget {
  const NGOVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        _header(context),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 100), child: Column(children: [_hero(), _steps(), _trustStatement(), _ngoPartners(), _consent()]))),
      ])),
      bottomNavigationBar: Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () {}, child: const Text('Request Verification / ಪರಿಶೀಲನೆ ಕೋರಿ')))),
    );
  }

  Widget _header(BuildContext ctx) => Container(color: AppColors.card, padding: const EdgeInsets.all(16), child: Row(children: [
    GestureDetector(onTap: () => Navigator.pop(ctx), child: const Icon(Icons.arrow_back, size: 22)),
    const SizedBox(width: 8), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Get Verified', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), Text('ಪರಿಶೀಲನೆ ಪಡೆಯಿರಿ', style: TextStyle(fontSize: 13, color: AppColors.textSecondary))])]));

  Widget _hero() => Container(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)]), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('🛡️', style: TextStyle(fontSize: 28)),
      const SizedBox(height: 8), const Text('Become NGO Verified', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 6), Text('Workers with NGO verification get 3x more job offers', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
    ]));

  Widget _steps() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('3 Simple Steps', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 16),
    ...[
      {'num': '1', 'icon': '📋', 'title': 'Submit your details', 'desc': 'We share your info securely with a trusted NGO near you'},
      {'num': '2', 'icon': '📞', 'title': 'NGO contacts you', 'desc': 'An NGO volunteer calls you within 2 working days'},
      {'num': '3', 'icon': '🏠', 'title': 'Quick in-person meet', 'desc': 'Brief 10-min meeting at a nearby community center'},
    ].map((s) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 36, height: 36, decoration: const BoxDecoration(color: AppColors.info, shape: BoxShape.circle),
        alignment: Alignment.center, child: Text(s['num']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white))),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${s['icon']} ${s['title']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4), Text(s['desc']!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
      ])),
    ]))),
  ]));

  Widget _trustStatement() => Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 16), padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary)),
    child: const Column(children: [
      Text('100% Free • Takes 2-3 days', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary), textAlign: TextAlign.center),
      SizedBox(height: 4), Text('Your Aadhaar is never stored by EmployMe', style: TextStyle(fontSize: 12, color: AppColors.primary), textAlign: TextAlign.center),
    ]));

  Widget _ngoPartners() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Verified NGO Partners Near You', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 12),
    ...[
      {'name': 'Kodialbail Community Trust', 'dist': '0.8 km', 'rating': '4.9', 'verified': '230'},
      {'name': 'Mangalore Seva Samithi', 'dist': '1.2 km', 'rating': '4.7', 'verified': '180'},
    ].map((n) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
      child: Column(children: [
        Row(children: [
          Container(width: 48, height: 48, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEFF6FF)), alignment: Alignment.center, child: const Text('🏛️', style: TextStyle(fontSize: 20))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n['name']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4), Wrap(spacing: 8, children: [
              Text('📍 ${n['dist']} from you', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
              Text('⭐ ${n['rating']}', style: const TextStyle(fontSize: 12, color: Color(0xFFD97706))),
              Text('${n['verified']} verified', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
          ])),
        ]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 40, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: const Text('Select This NGO'))),
      ]))),
  ]));

  Widget _consent() => Padding(padding: const EdgeInsets.all(20), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 22, height: 22, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
      child: const Icon(Icons.check, size: 14, color: Colors.white)),
    const SizedBox(width: 10),
    const Expanded(child: Text('I agree to an in-person verification meeting with the selected NGO', style: TextStyle(fontSize: 14, height: 1.5))),
  ]));
}
