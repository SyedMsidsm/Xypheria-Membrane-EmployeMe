import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/trust_gauge.dart';

class WorkerProfilePage extends StatelessWidget {
  const WorkerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 16), child: Column(children: [
        _profileHeader(), _trustCard(context), _statsRow(context), _skillsSection(), _availabilitySection(), _reviewsSection(), _actions(context),
      ]))),
      bottomNavigationBar: const WorkerNav(currentIndex: 4),
    );
  }

  Widget _profileHeader() => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)])),
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
    child: Column(children: [
      Align(alignment: Alignment.topRight, child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: const Icon(Icons.edit, size: 16, color: Colors.white))),
      Container(width: 88, height: 88, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary, border: Border.all(color: Colors.white, width: 3)),
        alignment: Alignment.center, child: const Text('R', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white))),
      const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
        child: const Text('Available Now', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))),
      const SizedBox(height: 8), const Text('Raju Kumar', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 2), Text('📍 Kodialbail, Mangalore', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
      Text('Member since April 2025', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
    ]));

  Widget _trustCard(BuildContext context) => Transform.translate(offset: const Offset(0, -20), child: GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/trust'),
    child: Container(margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)]),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Trust Score 🛡️', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        GestureDetector(onTap: () => Navigator.pushNamed(context, '/trust'), child: const Text('What is this?', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        const TrustGauge(score: 87),
        const SizedBox(width: 20),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Good', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
          SizedBox(height: 8), Text('✅ Phone Verified', style: TextStyle(fontSize: 12, color: AppColors.primary)),
          SizedBox(height: 4), Text('✅ Community Verified', style: TextStyle(fontSize: 12, color: AppColors.primary)),
          SizedBox(height: 4), Text('⏳ NGO Verified — Get verified →', style: TextStyle(fontSize: 12, color: Color(0xFFF97316))),
        ])),
      ]),
    ]))));

  Widget _statsRow(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), child: Row(children: [
    _statBox('12', 'Jobs Done', () => Navigator.pushNamed(context, '/my-jobs')),
    _statBox('₹18,400', 'Earned', () => Navigator.pushNamed(context, '/earnings')),
    _statBox('100%', 'Show-up', () => Navigator.pushNamed(context, '/trust')),
  ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: w))).toList()));

  Widget _statBox(String n, String l, [VoidCallback? onTap]) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]),
    child: Column(children: [Text(n, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)), const SizedBox(height: 2), Text(l, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))])));

  Widget _skillsSection() => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('My Skills / ನನ್ನ ಕೌಶಲ್ಯಗಳು', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const Text('Edit', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))]),
    const SizedBox(height: 10),
    Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
      ...['🍳 Cooking', '🧹 Cleaning', '🚚 Delivery', '🏪 Shop Helper'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
        child: Text(s, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)))),
      const Text('+ 2 more', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    ]),
  ]));

  Widget _availabilitySection() => Container(margin: const EdgeInsets.fromLTRB(20, 16, 20, 0), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('My Availability / ಲಭ್ಯತೆ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 10),
      Row(children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(right: 6),
        child: Container(width: 36, height: 36, decoration: BoxDecoration(shape: BoxShape.circle, color: e.key < 5 ? AppColors.primary : AppColors.border),
          alignment: Alignment.center, child: Text(e.value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: e.key < 5 ? Colors.white : AppColors.caption))))).toList()),
      const SizedBox(height: 10),
      Wrap(spacing: 8, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
        child: const Text('🌅 Morning', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary))),
        const Text('Available: Immediately', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))]),
    ]));

  Widget _reviewsSection() => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Work History ⭐ 4.8 (12 reviews)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    const SizedBox(height: 12), _reviewCard('🏪', 'Sri Ganesh Store', 'Aug 2025', 5, 'Excellent worker, very punctual and honest', ['On Time', 'Honest', 'Hardworking']),
    const SizedBox(height: 10), _reviewCard('🍳', 'Hotel Udupi', 'Jul 2025', 4, 'Good worker, reliable and quick to learn', ['Reliable', 'Would Rehire']),
    const SizedBox(height: 12), const Center(child: Text('View all 12 reviews', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
  ]));

  Widget _reviewCard(String emoji, String name, String date, int stars, String text, List<String> badges) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight), alignment: Alignment.center, child: Text(emoji, style: const TextStyle(fontSize: 14))), const SizedBox(width: 10), Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700))]), Text(date, style: const TextStyle(fontSize: 12, color: AppColors.caption))]),
      const SizedBox(height: 6), Text('⭐' * stars, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 6), Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
      const SizedBox(height: 8), Wrap(spacing: 6, children: badges.map((b) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
        child: Text('✅ $b', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)))).toList()),
    ]));

  Widget _actions(BuildContext ctx) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Row(children: [
    Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('📤 Share'))),
    const SizedBox(width: 10),
    Expanded(child: SizedBox(height: 48, child: ElevatedButton(onPressed: () => Navigator.pushNamed(ctx, '/trust'), child: const Text('🛡️ Trust Score')))),
  ]));
}
