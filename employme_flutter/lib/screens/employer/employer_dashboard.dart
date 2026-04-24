import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';

class EmployerDashboard extends StatelessWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _header(state),
            _quickActions(context),
            _activePostings(context),
            _recentApplicants(context),
          ],
        ),
      ),
      bottomNavigationBar: const EmployerNav(currentIndex: 0),
    );
  }

  Widget _header(AppState state) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)]),
    ),
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: const Text('🏢', style: TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Hi, ${state.userName.split(' ')[0]}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          Text('Employer Dashboard', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7))),
        ])),
        TapScale(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.settings, size: 20, color: Colors.white),
          ),
        ),
      ]),
      const SizedBox(height: 20),
      // Stats row
      Row(children: [
        _stat('3', 'Active Posts', Icons.work_rounded),
        const SizedBox(width: 12),
        _stat('12', 'Applicants', Icons.people_rounded),
        const SizedBox(width: 12),
        _stat('87%', 'Fill Rate', Icons.trending_up_rounded),
      ]),
    ]),
  );

  Widget _stat(String value, String label, IconData icon) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Column(children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7))),
      ]),
    ),
  );

  Widget _quickActions(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: TapScale(
          onTap: () => Navigator.pushNamed(context, '/post-job'),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.primaryGlow(0.2),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(AppRadius.md)),
                child: const Icon(Icons.add, color: Colors.white)),
              const SizedBox(height: 12),
              const Text('Post Job', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
              Text('ಕೆಲಸ ಪೋಸ್ಟ್ ಮಾಡಿ', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7))),
            ]),
          ),
        )),
        const SizedBox(width: 12),
        Expanded(child: TapScale(
          onTap: () => Navigator.pushNamed(context, '/applicants'),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
              boxShadow: AppShadows.card,
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.md)),
                child: const Icon(Icons.people, color: AppColors.primaryDark)),
              const SizedBox(height: 12),
              const Text('Applicants', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const Text('ಅರ್ಜಿದಾರರು', style: TextStyle(fontSize: 11, color: AppColors.caption)),
            ]),
          ),
        )),
      ]),
    ]),
  );

  Widget _activePostings(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Active Postings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        GestureDetector(child: const Text('See All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
      ]),
      const SizedBox(height: 12),
      _postingCard('🏪', 'Shop Assistant', '₹12,000/mo', '5 applicants', AppColors.primary),
      const SizedBox(height: 10),
      _postingCard('🍳', 'Kitchen Helper', '₹500/day', '3 applicants', AppColors.info),
    ]),
  );

  Widget _postingCard(String emoji, String title, String salary, String apps, Color accent) => TapScale(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md)),
          alignment: Alignment.center, child: Text(emoji, style: const TextStyle(fontSize: 22))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(salary, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: Text(apps, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: accent)),
        ),
      ]),
    ),
  );

  Widget _recentApplicants(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Recent Applicants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/applicants'),
          child: const Text('View All', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ),
      ]),
      const SizedBox(height: 12),
      ...['Raju Kumar', 'Suresh Mallya', 'Priya Devi'].asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TapScale(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border), boxShadow: AppShadows.soft),
            child: Row(children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(e.value[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(e.value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(['Shop Assistant', 'Kitchen Helper', 'Delivery'][e.key], style: const TextStyle(fontSize: 12, color: AppColors.caption)),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: e.key == 0 ? AppColors.primaryLight : AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.xs)),
                child: Text(e.key == 0 ? '⭐ Best Match' : '${[87, 72, 65][e.key]} Trust', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: e.key == 0 ? AppColors.primaryDark : AppColors.textSecondary)),
              ),
            ]),
          ),
        ),
      )),
    ]),
  );
}
