import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 80), child: Column(children: [
          _hero(context), _headerCard(), _pills(), _stats(), _about(), _requirements(), _perks(), _employer(),
        ]))),
      ])),
      bottomNavigationBar: _bottom(context),
    );
  }

  Widget _hero(BuildContext ctx) => Container(height: 200, color: AppColors.primaryLight, child: Stack(children: [
    const Center(child: Text('🏪', style: TextStyle(fontSize: 64))),
    Positioned(top: 16, left: 16, right: 16, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _circleBtn(ctx, Icons.arrow_back, () => Navigator.pop(ctx)),
      Row(children: [_circleBtn(ctx, Icons.share, () {}), const SizedBox(width: 8), _circleBtn(ctx, Icons.bookmark_border, () {})]),
    ])),
  ]));

  Widget _circleBtn(BuildContext ctx, IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(
    width: 40, height: 40, decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
    child: Icon(icon, size: 20, color: AppColors.text)));

  Widget _headerCard() => Container(
    decoration: BoxDecoration(color: AppColors.card, borderRadius: const BorderRadius.vertical(top: Radius.circular(24)), border: const Border(bottom: BorderSide(color: AppColors.border))),
    transform: Matrix4.translationValues(0, -24, 0), padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Shop Assistant', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Row(children: [
        const Text('Sri Ganesh Provision Store', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.check_circle, size: 10, color: AppColors.primaryDark), SizedBox(width: 4), Text('Verified', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryDark))])),
      ]),
      const SizedBox(height: 6), const Text('📍 Kodialbail Main Road, Mangalore', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 20),
      const Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Text('₹12,000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)), Text('/month', style: TextStyle(fontSize: 16, color: AppColors.caption)),
      ]),
    ]));

  Widget _pills() => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: Wrap(spacing: 8, children:
    ['Full Time', 'Retail', 'Immediate Start'].map((p) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8)),
      child: Text(p, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)))).toList()));

  Widget _stats() => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: Row(children: [
    _stat(Icons.people, '2 Openings'), _stat(Icons.access_time, '9AM-6PM'), _stat(Icons.star, '4.8 Rating'),
  ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: w))).toList()));

  Widget _stat(IconData icon, String label) => Container(padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Column(children: [Icon(icon, size: 20, color: AppColors.primary), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary))]));

  Widget _about() => const Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('About this Job', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), SizedBox(height: 12),
    Text('Help manage a busy provision store in the heart of Kodialbail. Responsibilities include assisting customers, organizing shelves, handling billing, and maintaining cleanliness.', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
  ]));

  Widget _requirements() => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Requirements', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), const SizedBox(height: 16),
    ...['No degree or certificate required', 'Basic Kannada or Hindi communication', 'Honest, punctual, hardworking', 'Can lift boxes (up to 10kg)'].map((r) =>
      Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.check_circle, size: 16, color: AppColors.primary), const SizedBox(width: 12), Expanded(child: Text(r, style: const TextStyle(fontSize: 14)))]))),
  ]));

  Widget _perks() => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('What you get', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)), const SizedBox(height: 16),
    Wrap(spacing: 8, runSpacing: 8, children: ['Free Lunch', 'Weekly Pay', 'Salary Hike', 'Bonus'].map((p) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Text(p, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)))).toList()),
  ]));

  Widget _employer() => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center, child: const Text('SG', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
      const SizedBox(width: 16),
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Sri Ganesh Provision Store', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        SizedBox(height: 4), Text('47 hired • Since 2022', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ]),
    ])));

  Widget _bottom(BuildContext ctx) => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    child: Row(children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: const Icon(Icons.bookmark_border, size: 24, color: AppColors.textSecondary)),
      const SizedBox(width: 12),
      Expanded(child: SizedBox(height: 56, child: ElevatedButton(onPressed: () => Navigator.pushNamed(ctx, '/apply'), child: const Text('Apply Now')))),
    ]));
}
