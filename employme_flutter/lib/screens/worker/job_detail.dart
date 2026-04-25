import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final job = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Use a default map if no job is passed (e.g. initial dev state)
    final j = job ?? {
      'emoji': '🏪',
      'title': state.tr('shop_assistant'),
      'company': 'Sri Ganesh Provision Store',
      'location': 'Kodialbail Main Road, Mangalore',
      'salary': '₹12,000',
      'period': '/${state.tr('month')}',
      'type': state.tr('full_time'),
      'description': 'Help manage a busy provision store in the heart of Kodialbail. Responsibilities include assisting customers, organizing shelves, handling billing, and maintaining cleanliness.',
      'requirements': [state.tr('no_degree'), state.tr('basic_comm'), state.tr('honest_punctual'), state.tr('lifting')],
      'timing': '9AM-6PM',
      'peopleNeeded': 2,
      'verified': true,
    };

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 80), child: Column(children: [
          _hero(context, j), _headerCard(state, j), _pills(state, j), _stats(state, j), _about(state, j), _requirements(state, j), _perks(state), _employer(state, j),
        ]))),
      ])),
      bottomNavigationBar: _bottom(context, state),
    );
  }

  Widget _hero(BuildContext ctx, Map<String, dynamic> j) => Container(height: 200, color: AppColors.primaryLight, child: Stack(children: [
    Center(child: Text(j['emoji'] ?? '🏪', style: const TextStyle(fontSize: 64))),
    Positioned(top: 16, left: 16, right: 16, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _circleBtn(ctx, Icons.arrow_back, () => Navigator.pop(ctx)),
      Row(children: [_circleBtn(ctx, Icons.share, () {}), const SizedBox(width: 8), _circleBtn(ctx, Icons.bookmark_border, () {})]),
    ])),
  ]));

  Widget _circleBtn(BuildContext ctx, IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(
    width: 40, height: 40, decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
    child: Icon(icon, size: 20, color: AppColors.text)));

  Widget _headerCard(AppState state, Map<String, dynamic> j) => Container(
    decoration: BoxDecoration(color: AppColors.card, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), border: const Border(bottom: BorderSide(color: AppColors.border))),
    transform: Matrix4.translationValues(0, -24, 0), padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(j['title'] ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8),
      Row(children: [
        Text(j['company'] ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(width: 8),
        if (j['verified'] == true)
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 10, color: AppColors.primaryDark), const SizedBox(width: 4), Text(state.tr('verified'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.primaryDark))])),
      ]),
      const SizedBox(height: 6), Text('📍 ${j['location'] ?? ''}', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 20),
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Text(j['salary'] ?? '', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)), Text(j['period'] ?? '', style: const TextStyle(fontSize: 16, color: AppColors.caption)),
      ]),
    ]));

  Widget _pills(AppState state, Map<String, dynamic> j) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: Wrap(spacing: 8, children:
    [(j['type'] ?? ''), state.tr('immediate_start')].map((p) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8)),
      child: Text(p, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)))).toList()));

  Widget _stats(AppState state, Map<String, dynamic> j) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: Row(children: [
    _stat(Icons.people, state.tr('openings', args: {'count': '${j['peopleNeeded'] ?? 1}'})), _stat(Icons.access_time, j['timing'] ?? '9AM-6PM'), _stat(Icons.star, state.tr('rating', args: {'count': '4.8'})),
  ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList()));

  Widget _stat(IconData icon, String label) => Container(padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Column(children: [Icon(icon, size: 20, color: AppColors.primary), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))]));

  Widget _about(AppState state, Map<String, dynamic> j) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('about_job'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(height: 12),
    Text(j['description'] ?? 'Help manage a busy provision store in the heart of Kodialbail. Responsibilities include assisting customers, organizing shelves, handling billing, and maintaining cleanliness.', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
  ]));

  Widget _requirements(AppState state, Map<String, dynamic> j) {
    final reqs = j['requirements'] as List<dynamic>? ?? [state.tr('no_degree'), state.tr('basic_comm'), state.tr('honest_punctual'), state.tr('lifting')];
    return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(state.tr('requirements'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(height: 16),
      ...reqs.map((r) =>
        Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.check_circle, size: 16, color: AppColors.primary), const SizedBox(width: 12), Expanded(child: Text(r.toString(), style: const TextStyle(fontSize: 14)))]))),
    ]));
  }

  Widget _perks(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('what_you_get'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(height: 16),
    Wrap(spacing: 8, runSpacing: 8, children: [state.tr('free_lunch'), state.tr('weekly_pay'), state.tr('hike'), state.tr('bonus')].map((p) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Text(p, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)))).toList()),
  ]));

  Widget _employer(AppState state, Map<String, dynamic> j) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center, child: Text((j['company'] ?? 'S')[0], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(j['company'] ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4), Text('${state.tr('hired', args: {'count': '47'})} • ${state.tr('since', args: {'year': '2022'})}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ])),
    ])));

  Widget _bottom(BuildContext ctx, AppState state) => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    child: Row(children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: const Icon(Icons.bookmark_border, size: 24, color: AppColors.textSecondary)),
      const SizedBox(width: 12),
      Expanded(child: SizedBox(height: 56, child: ElevatedButton(onPressed: () => Navigator.pushNamed(ctx, '/apply'), child: Text(state.tr('apply_now'))))),
    ]));
}
