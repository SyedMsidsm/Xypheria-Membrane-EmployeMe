import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../models/job_posting.dart';
import '../../widgets/bottom_nav.dart';

class ViewAllJobs extends StatelessWidget {
  const ViewAllJobs({super.key});

  // Fallback demo posts so the screen is never empty
  static final List<JobPosting> _demoJobs = [
    JobPosting(
      emoji: '🏪', company: 'Sri Ganesh Provision Store',
      title: 'Shop Assistant', category: 'Shop Helper',
      pay: '12,000', payPeriod: 'per month', timing: '9 AM – 6 PM',
      peopleNeeded: 2, type: 'Full-time',
      description: 'Assist customers, manage inventory, and maintain store cleanliness.',
      requirements: ['Basic communication', 'Physical stamina'],
      isUrgent: true, postedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    JobPosting(
      emoji: '🍳', company: 'Hotel Udupi Delights',
      title: 'Kitchen Helper', category: 'Cooking',
      pay: '500', payPeriod: 'per day', timing: '7 AM – 3 PM',
      peopleNeeded: 1, type: 'Part-time',
      description: 'Help in kitchen prep, dishwashing and maintaining hygiene.',
      requirements: ['Cooking basics', 'Hygiene awareness'],
      isUrgent: false, postedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    JobPosting(
      emoji: '🚚', company: 'QuickMart Grocery',
      title: 'Delivery Partner', category: 'Delivery',
      pay: '600', payPeriod: 'per day', timing: '10 AM – 8 PM',
      peopleNeeded: 3, type: 'Full-time',
      description: 'Deliver groceries to nearby localities on bicycle or scooter.',
      requirements: ['Own vehicle preferred', 'Know local routes'],
      isUrgent: true, postedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final postedJobs = state.jobPostings;
    // Merge posted jobs first, then demo jobs
    final allJobs = [...postedJobs, ..._demoJobs];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(context, state, allJobs.length),
          _statsRow(allJobs),
          Expanded(
            child: allJobs.isEmpty
              ? _emptyState(context)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  itemCount: allJobs.length,
                  itemBuilder: (_, i) => _jobCard(context, state, allJobs[i], i),
                ),
          ),
        ]),
      ),
      bottomNavigationBar: const EmployerNav(currentIndex: 1),
    );
  }

  Widget _header(BuildContext context, AppState state, int count) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
    color: AppColors.card,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('My Posts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text('$count active job postings', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ]),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text('$count Active', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
        ]),
      ),
    ]),
  );

  Widget _statsRow(List<JobPosting> jobs) {
    final urgent = jobs.where((j) => j.isUrgent).length;
    final totalApplicants = jobs.length * 12; // simulated
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        _stat(Icons.article_rounded, '${jobs.length}', 'Total Posts', AppColors.primary),
        _divider(),
        _stat(Icons.bolt_rounded, '$urgent', 'Urgent', AppColors.alert),
        _divider(),
        _stat(Icons.people_rounded, '$totalApplicants', 'Applicants', AppColors.info),
      ]),
    );
  }

  Widget _stat(IconData icon, String val, String label, Color color) => Expanded(
    child: Column(children: [
      Icon(icon, size: 20, color: color),
      const SizedBox(height: 6),
      Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 11, color: AppColors.caption)),
    ]),
  );

  Widget _divider() => Container(width: 1, height: 40, color: AppColors.border);

  Widget _emptyState(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 80, height: 80,
        decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
        child: const Icon(Icons.post_add_rounded, size: 40, color: AppColors.primary),
      ),
      const SizedBox(height: 20),
      const Text('No posts yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      const Text('Post your first job to start\nreceiving applicants', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 24),
      SizedBox(
        height: 48,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/post-job'),
          icon: const Icon(Icons.add, size: 20),
          label: const Text('Post a Job'),
          style: ElevatedButton.styleFrom(minimumSize: const Size(180, 48)),
        ),
      ),
    ]),
  );

  Widget _jobCard(BuildContext context, AppState state, JobPosting job, int index) {
    final bool isUrgent = job.isUrgent;
    final applicants = isUrgent ? 47 : 12 + index * 5;
    final postedAgo = _timeAgo(job.postedAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        // Left accent bar
        Positioned(left: 0, top: 0, bottom: 0,
          child: Container(width: 4, color: isUrgent ? AppColors.alert : AppColors.primary),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Title row
            Row(children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: isUrgent ? AppColors.alert.withOpacity(0.1) : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _iconForCategory(job.category),
                  size: 20,
                  color: isUrgent ? AppColors.alert : AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(job.company, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isUrgent ? AppColors.alert.withOpacity(0.1) : AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isUrgent ? 'URGENT' : 'ACTIVE',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: isUrgent ? AppColors.alert : AppColors.primaryDark, letterSpacing: 0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(postedAgo, style: const TextStyle(fontSize: 10, color: AppColors.caption)),
              ]),
            ]),
            const SizedBox(height: 12),
            // Details chips
            Wrap(spacing: 8, runSpacing: 6, children: [
              _chip(Icons.payments_outlined, '₹${job.pay}/${job.payPeriod == 'per day' ? 'day' : 'mo'}'),
              _chip(Icons.schedule_outlined, job.timing),
              _chip(Icons.people_outline, '${job.peopleNeeded} needed'),
              _chip(Icons.work_outline, job.type),
            ]),
            const SizedBox(height: 12),
            // Description preview
            Text(
              job.description,
              maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 12),
            // Bottom stats bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                const Icon(Icons.people, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Text('$applicants applicants', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/applicants'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                    child: const Text('View', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _chip(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: AppColors.caption),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
    ]),
  );

  IconData _iconForCategory(String cat) {
    if (cat.contains('Shop') || cat.contains('Retail')) return Icons.storefront;
    if (cat.contains('Cook') || cat.contains('Kitchen')) return Icons.restaurant;
    if (cat.contains('Delivery')) return Icons.local_shipping;
    if (cat.contains('Clean')) return Icons.cleaning_services;
    if (cat.contains('Labour')) return Icons.engineering;
    if (cat.contains('Elder') || cat.contains('Care')) return Icons.elderly;
    return Icons.work;
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
