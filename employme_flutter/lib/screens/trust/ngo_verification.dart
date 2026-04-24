import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class NGOVerification extends StatelessWidget {
  const NGOVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        _header(context, state),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 100), child: Column(children: [_hero(state), _steps(state), _trustStatement(state), _ngoPartners(state), _consent(state)]))),
      ])),
      bottomNavigationBar: Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () {}, child: Text(state.tr('request_verification'))))),
    );
  }

  Widget _header(BuildContext ctx, AppState state) => Container(color: AppColors.card, padding: const EdgeInsets.all(16), child: Row(children: [
    GestureDetector(onTap: () => Navigator.pop(ctx), child: const Icon(Icons.arrow_back, size: 22)),
    const SizedBox(width: 8), Text(state.tr('get_verified'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))]));

  Widget _hero(AppState state) => Container(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)]), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('🛡️', style: TextStyle(fontSize: 28)),
      const SizedBox(height: 8), Text(state.tr('become_ngo_verified'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 6), Text(state.tr('ngo_3x_text'), style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
    ]));

  Widget _steps(AppState state) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('three_simple_steps'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 16),
    ...[
      {'num': '1', 'icon': '📋', 'title': state.tr('submit_details_step'), 'desc': state.tr('submit_details_desc')},
      {'num': '2', 'icon': '📞', 'title': state.tr('ngo_contacts_step'), 'desc': state.tr('ngo_contacts_desc')},
      {'num': '3', 'icon': '🏠', 'title': state.tr('quick_meet_step'), 'desc': state.tr('quick_meet_desc')},
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

  Widget _trustStatement(AppState state) => Container(margin: const EdgeInsets.fromLTRB(20, 0, 20, 16), padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary)),
    child: Column(children: [
      Text(state.tr('free_takes_days'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary), textAlign: TextAlign.center),
      const SizedBox(height: 4), Text(state.tr('aadhaar_text'), style: const TextStyle(fontSize: 12, color: AppColors.primary), textAlign: TextAlign.center),
    ]));

  Widget _ngoPartners(AppState state) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('verified_ngo_partners'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 12),
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
          child: Text(state.tr('select_this_ngo')))),
      ]))),
  ]));

  Widget _consent(AppState state) => Padding(padding: const EdgeInsets.all(20), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 22, height: 22, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
      child: const Icon(Icons.check, size: 14, color: Colors.white)),
    const SizedBox(width: 10),
    Expanded(child: Text(state.tr('agree_verification'), style: const TextStyle(fontSize: 14, height: 1.5))),
  ]));
}
