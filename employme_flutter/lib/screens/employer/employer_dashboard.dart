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
            _postJobCTA(context),
            _quickActions(context),
            _activePostings(context),
            _recentApplicants(context),
          ],
        ),
      ),
      bottomNavigationBar: const EmployerNav(currentIndex: 0),
    );
  }

  // React-matching navy header
  Widget _header(AppState state) => Container(
    color: AppColors.navy,
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Top row
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Good morning, ${state.userName.split(' ')[0]}!',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        Row(children: [
          Icon(Icons.notifications_outlined, size: 20, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 12),
          Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
            alignment: Alignment.center,
            child: Text(state.userName[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
          ),
        ]),
      ]),
      const SizedBox(height: 16),
      // Business info
      Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
          child: const Icon(Icons.store, size: 24, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Sri Ganesh Provision Store', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
            child: const Text('Verified Business', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ])),
      ]),
      const SizedBox(height: 20),
      // Stats pills
      Row(children: [
        for (final s in ['3 Active Posts', '47 Applicants', '2 Hired']) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          if (s != '2 Hired') const SizedBox(width: 8),
        ],
      ]),
    ]),
  );

  // Find workers CTA — overlapping navy section
  Widget _postJobCTA(BuildContext context) => Transform.translate(
    offset: const Offset(0, -20),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TapScale(
        onTap: () => Navigator.pushNamed(context, '/post-job'),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppShadows.elevated,
          ),
          child: Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
              child: const Icon(Icons.add, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Find workers now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 4),
              Text('Post a job in 90 seconds!', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              child: const Text('FREE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, size: 20, color: Colors.white),
          ]),
        ),
      ),
    ),
  );

  // Quick Actions — 2x2 grid matching React
  Widget _quickActions(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.9,
      children: [
        _actionTile(Icons.add, 'Post New Job', AppColors.primary, Colors.white, onTap: () => Navigator.pushNamed(context, '/post-job')),
        _actionTile(Icons.people, 'Applicants', AppColors.navyLight, Colors.white, onTap: () => Navigator.pushNamed(context, '/applicants')),
        _actionTile(Icons.star, 'Reviews', AppColors.card, AppColors.navy, hasBorder: true),
        _actionTile(Icons.bar_chart, 'Analytics', AppColors.card, AppColors.navy, hasBorder: true),
      ],
    ),
  );

  Widget _actionTile(IconData icon, String label, Color bg, Color fg, {bool hasBorder = false, VoidCallback? onTap}) => TapScale(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: hasBorder ? Border.all(color: AppColors.border) : null,
        boxShadow: AppShadows.card,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 24, color: fg),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: fg)),
      ]),
    ),
  );

  // Active Postings — matching React's left-border cards
  Widget _activePostings(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Active Postings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        GestureDetector(child: const Text('View All (3)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
      ]),
      const SizedBox(height: 16),
      _activeCard('Shop Assistant', '3 days', 47, true),
      const SizedBox(height: 12),
      _activeCard('Delivery Partner', '7 days', 12, false),
    ]),
  );

  Widget _activeCard(String title, String expires, int applicants, bool highInterest) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16),
      border: const Border(left: BorderSide(color: AppColors.primary, width: 4)),
      boxShadow: AppShadows.card,
    ),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Row(children: [
            Icon(Icons.access_time, size: 14, color: highInterest ? AppColors.alert : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text('Expires in $expires', style: TextStyle(fontSize: 12, fontWeight: highInterest ? FontWeight.w600 : FontWeight.w500, color: highInterest ? AppColors.alert : AppColors.textSecondary)),
          ]),
        ]),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
          child: const Text('ACTIVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
        ),
      ]),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          const Icon(Icons.people, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text('$applicants applicants', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          if (highInterest) ...[
            const SizedBox(width: 12),
            const Icon(Icons.local_fire_department, size: 16, color: AppColors.alert),
            const SizedBox(width: 6),
            const Text('High Interest', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.alert)),
          ],
        ]),
      ),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: SizedBox(height: 44, child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('View Applicants ($applicants)', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.text)),
        ))),
        const SizedBox(width: 8),
        SizedBox(height: 44, child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Text('Boost', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
            SizedBox(width: 6),
            Icon(Icons.local_fire_department, size: 14),
          ]),
        )),
      ]),
    ]),
  );

  // Recent Applicants — matching React's list style
  Widget _recentApplicants(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Recent Applicants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          for (int i = 0; i < 3; i++) ...[
            _applicantRow(
              ['Raju K.', 'Suresh M.', 'Priya D.'][i],
              ['Shop • Clean', 'Delivery', 'Cook • Shop'][i],
              ['6 min', '12 min', '8 min'][i],
            ),
            if (i < 2) const Divider(height: 1, color: AppColors.border),
          ],
        ]),
      ),
    ]),
  );

  Widget _applicantRow(String name, String skills, String dist) => TapScale(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
          alignment: Alignment.center,
          child: Text(name[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(skills, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('🚶 $dist', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
            child: const Text('View', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ]),
      ]),
    ),
  );
}
