import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';
import '../../models/job_posting.dart';

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
            _header(context, state),
            _postJobCTA(context, state),
            _quickActions(context, state),
            _activePostings(context, state),
            _recentApplicants(context, state),
          ],
        ),
      ),
      bottomNavigationBar: const EmployerNav(currentIndex: 0),
    );
  }

  Widget _header(BuildContext context, AppState state) {
    return Container(
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${state.tr('good_morning')}, ${state.userName.split(' ')[0]}!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          Row(children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/notifications'),
              child: Icon(Icons.notifications_outlined, size: 20, color: Colors.white.withOpacity(0.8))),
            const SizedBox(width: 12),
            TapScale(
              onTap: () => Navigator.pushNamed(context, '/employer-profile'),
              child: Container(
                width: 36, height: 36,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                alignment: Alignment.center,
                child: Text(state.userName[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
          ]),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
            child: const Icon(Icons.store, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/employer-profile'),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(state.businessName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                child: Text(state.tr('verified_business'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ]),
          )),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _statBadge(state.tr('active_posts_count', args: {'count': '${state.jobPostings.length}'})),
          const SizedBox(width: 8),
          _statBadge('${47} ${state.tr('applicants_label')}'),
          const SizedBox(width: 8),
          _statBadge(state.tr('hired_count', args: {'count': '2'})),
        ]),
      ]),
    );
  }

  Widget _statBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
  );

  Widget _postJobCTA(BuildContext context, AppState state) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TapScale(
          onTap: () => _showUrgentCandidates(context, state),
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
                Text(state.tr('find_workers_now'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                const SizedBox(height: 4),
                Text(state.tr('post_in_seconds'), style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: Text(state.tr('free'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 20, color: Colors.white),
            ]),
          ),
        ),
      ),
    );
  }

  void _showUrgentCandidates(BuildContext context, AppState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40, height: 4,
              decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Urgent Candidates', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('These workers are active near you and ready to join immediately.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: state.applicants.length,
                itemBuilder: (context, index) {
                  final w = state.applicants[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
                          alignment: Alignment.center,
                          child: Text(w['name'][0], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(w['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: AppColors.primary),
                                  const SizedBox(width: 4),
                                  Text(w['distance'], style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.star, size: 12, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  const Text('4.8', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/worker-profile', arguments: w['name']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            minimumSize: const Size(0, 36),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('View', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _quickActions(BuildContext context, AppState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.9,
        children: [
          _actionTile(Icons.add, state.tr('post_new_job'), AppColors.primary, Colors.white, onTap: () => Navigator.pushNamed(context, '/post-job')),
          _actionTile(Icons.people, state.tr('applicants_label'), AppColors.navyLight, Colors.white, onTap: () => Navigator.pushNamed(context, '/applicants')),
          _actionTile(Icons.star, state.tr('reviews'), AppColors.card, AppColors.navy, hasBorder: true, onTap: () => Navigator.pushNamed(context, '/reviews')),
          _actionTile(Icons.bar_chart, state.tr('analytics'), AppColors.card, AppColors.navy, hasBorder: true, onTap: () => Navigator.pushNamed(context, '/analytics')),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String label, Color bg, Color fg, {bool hasBorder = false, VoidCallback? onTap}) {
    return TapScale(
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
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: fg)),
        ]),
      ),
    );
  }

  Widget _activePostings(BuildContext context, AppState state) {
    final jobs = state.jobPostings;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(state.tr('active_postings'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/view-all-jobs'),
            child: Text(state.tr('view_all', args: {'count': '${jobs.length}'}), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
        ]),
        const SizedBox(height: 16),
        if (jobs.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            child: const Center(child: Text('No active postings. Post your first job!', style: TextStyle(color: AppColors.textSecondary))),
          )
        else
          ...jobs.take(2).map((job) => _activeCard(context, state, job)),
      ]),
    );
  }

  Widget _activeCard(BuildContext context, AppState state, JobPosting job) {
    final bool highInterest = job.isUrgent;
    final applicants = highInterest ? 47 : 12;
    final expires = highInterest ? '3' : '7';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0, top: 0, bottom: 0,
            child: Container(width: 4, color: AppColors.primary),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Row(children: [
                    Icon(Icons.access_time, size: 14, color: highInterest ? AppColors.alert : AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Text(state.tr('expires_in', args: {'days': '$expires ${state.tr('days')}'}), style: TextStyle(fontSize: 12, fontWeight: highInterest ? FontWeight.w600 : FontWeight.w500, color: highInterest ? AppColors.alert : AppColors.textSecondary)),
                  ]),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: Text(state.tr('active'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
                ),
              ]),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(Icons.people, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text('$applicants ${state.tr('applicants_label').toLowerCase()}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  if (highInterest) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.local_fire_department, size: 16, color: AppColors.alert),
                    const SizedBox(width: 6),
                    Text(state.tr('high_interest'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.alert)),
                  ],
                ]),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: SizedBox(height: 44, child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/applicants'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('${state.tr('view')} ${state.tr('applicants_label')} ($applicants)', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.text)),
                ))),
                const SizedBox(width: 8),
                SizedBox(height: 44, child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title: const Text('Boost Posting? 🚀'),
                        content: const Text('Reach 3x more workers by boosting this job. Cost: ₹99'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              Navigator.pushNamed(context, '/payment', arguments: '99');
                            },
                            child: const Text('Pay ₹99'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(state.tr('boost'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 6),
                    const Icon(Icons.local_fire_department, size: 14),
                  ]),
                )),
              ]),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _recentApplicants(BuildContext context, AppState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(state.tr('recent_applicants'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
                context,
                state,
                state.userName,
                state.tr('shop_clean'),
                '6 min',
              ),
              const Divider(height: 1, color: AppColors.border),
              _applicantRow(
                context,
                state,
                'Suresh Mallya',
                state.tr('delivery_partner'),
                '12 min',
              ),
              const Divider(height: 1, color: AppColors.border),
              _applicantRow(
                context,
                state,
                'Priya Devi',
                state.tr('cook_shop'),
                '8 min',
              ),
            ],
          ]),
        ),
      ]),
    );
  }

  Widget _applicantRow(BuildContext context, AppState state, String name, String skills, String dist) {
    return TapScale(
      onTap: () => Navigator.pushNamed(context, '/worker-profile', arguments: name),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
            alignment: Alignment.center,
            child: Text(name[0], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(skills, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('🚶 $dist', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/worker-profile', arguments: name),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                child: Text(state.tr('view'), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
