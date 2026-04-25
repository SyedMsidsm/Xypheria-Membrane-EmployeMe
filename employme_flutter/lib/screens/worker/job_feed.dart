import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/job_card.dart';
import '../../providers/app_state.dart';

class JobFeed extends StatefulWidget {
  const JobFeed({super.key});
  @override
  State<JobFeed> createState() => _JobFeedState();
}

class _JobFeedState extends State<JobFeed> {
  final _searchController = TextEditingController();
  String _activeCategoryKey = 'all_jobs_cat';
  bool _showOnlyUrgent = false;

  List<Map<String, dynamic>> _getFilteredJobs(AppState state) {
    var jobs = state.workerFeedJobs;
    
    if (_showOnlyUrgent) {
      jobs = jobs.where((j) => (j['isUrgent'] ?? false) == true).toList();
    }

    if (_activeCategoryKey != 'all_jobs_cat') {
      final filterMap = {
        'cooking_cat': 'Cooking',
        'delivery_cat': 'Delivery',
        'cleaning_cat': 'Cleaning',
        'shop_cat': 'Shop',
        'labour_cat': 'Labour',
        'repair_cat': 'Repair',
      };
      final filterVal = filterMap[_activeCategoryKey] ?? '';
      jobs = jobs.where((j) => (j['type'] as String).toLowerCase().contains(filterVal.toLowerCase()) || (j['title'] as String).toLowerCase().contains(filterVal.toLowerCase())).toList();
    }
    
    if (_searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      jobs = jobs.where((j) => (j['title'] as String).toLowerCase().contains(q) || (j['company'] as String).toLowerCase().contains(q)).toList();
    }
    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final filteredJobs = _getFilteredJobs(state);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _appBar(context, state),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _searchBar(state),
                if (!state.isEmployer) _urgentBanner(state),
                if (!state.isEmployer) _categories(context, state),
                _sectionHeader(state, filteredJobs.length),
                ...filteredJobs.map((j) => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: JobCard(
                    emoji: j['emoji'] as String,
                    title: state.language == 'kn' ? (j['title_kn'] ?? j['title']) : j['title'] as String,
                    company: j['company'] as String,
                    type: state.language == 'kn' ? (j['type_kn'] ?? j['type']) : j['type'] as String,
                    location: state.language == 'kn' ? (j['location_kn'] ?? j['location']) : j['location'] as String,
                    salary: j['salary'] as String,
                    period: state.language == 'kn' ? (j['period_kn'] ?? j['period']) : j['period'] as String,
                    distance: j['distance'] as String?,
                    verified: j['verified'] as bool? ?? false,
                    bookmarked: state.isBookmarked(j['title'] as String),
                    onTap: () => Navigator.pushNamed(context, '/job-detail', arguments: j),
                    onApply: () => Navigator.pushNamed(context, '/apply'),
                    onBookmark: () => state.toggleBookmark(j['title'] as String),
                  ),
                )),
                if (filteredJobs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(children: [
                      const Text('🔍', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 12),
                      Text(state.tr('no_jobs_found'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text(state.tr('try_different'), style: const TextStyle(fontSize: 13, color: AppColors.caption)),
                    ]),
                  ),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: TapScale(
        onTap: () {},
        child: Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
            shape: BoxShape.circle,
            boxShadow: AppShadows.primaryGlow(0.3),
          ),
          child: const Icon(Icons.auto_awesome, size: 22, color: Colors.white),
        ),
      ),
      bottomNavigationBar: state.isEmployer 
          ? const EmployerNav(currentIndex: 0) 
          : const WorkerNav(currentIndex: 0),
    );
  }

  Widget _appBar(BuildContext context, AppState state) => Container(
    color: AppColors.card,
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
    child: Row(children: [
      TapScale(
        onTap: () => Navigator.pushNamed(context, state.isEmployer ? '/employer-profile' : '/worker-profile'),
        child: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(state.userName.isNotEmpty ? state.userName[0] : 'U', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
          ),
          const SizedBox(width: 10),
          Text('${state.tr('hi')}, ${state.userName.split(' ')[0]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ]),
      ),
      const Spacer(),
      TapScale(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.xl)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(state.location.split(',')[0], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ]),
        ),
      ),
      const SizedBox(width: 12),
      TapScale(
        onTap: () => Navigator.pushNamed(context, '/notifications'),
        child: Stack(children: [
          const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.notifications_outlined, size: 22)),
          if (state.unreadNotifications > 0) Positioned(
            top: 0, right: 0,
            child: Container(
              width: 18, height: 18,
              decoration: BoxDecoration(color: AppColors.alert, shape: BoxShape.circle, border: Border.all(color: AppColors.card, width: 2)),
              alignment: Alignment.center,
              child: Text('${state.unreadNotifications}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
        ]),
      ),
    ]),
  );

  Widget _searchBar(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Row(children: [
      Expanded(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
            boxShadow: AppShadows.soft,
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: state.tr('search_jobs'),
              prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.caption),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              fillColor: Colors.transparent,
              filled: true,
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
      const SizedBox(width: 8),
      TapScale(
        onTap: () => Navigator.pushNamed(context, '/search'),
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppRadius.md), boxShadow: AppShadows.primaryGlow(0.2)),
          child: const Icon(Icons.tune, size: 18, color: Colors.white),
        ),
      ),
    ]),
  );

  Widget _urgentBanner(AppState state) {
    final urgentCount = state.workerFeedJobs.where((j) => j['isUrgent'] == true).length;
    if (urgentCount == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: TapScale(
        onTap: () => setState(() => _showOnlyUrgent = !_showOnlyUrgent),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _showOnlyUrgent ? AppColors.primaryDark : AppColors.navy,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.elevated,
            border: _showOnlyUrgent ? Border.all(color: AppColors.primary, width: 2) : null,
          ),
          child: Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              child: const Center(child: Text('🔥', style: TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(state.tr('urgent_hiring'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 2),
              Text(state.tr('jobs_near_you', args: {'count': '$urgentCount'}), style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7))),
            ])),
            if (_showOnlyUrgent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: const Text('Clear', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
              )
            else
              Icon(Icons.chevron_right, size: 20, color: Colors.white.withOpacity(0.5)),
          ]),
        ),
      ),
    );
  }

  Widget _categories(BuildContext context, AppState state) {
    final catKeys = ['all_jobs_cat', 'cooking_cat', 'delivery_cat', 'cleaning_cat', 'shop_cat', 'labour_cat', 'repair_cat'];
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: SizedBox(
        height: 36,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: catKeys.map((key) {
            final active = _activeCategoryKey == key;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TapScale(
                onTap: () => setState(() => _activeCategoryKey = key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    border: Border.all(color: active ? AppColors.primary : AppColors.border),
                    boxShadow: active ? AppShadows.primaryGlow(0.15) : null,
                  ),
                  child: Text(state.tr(key), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.text)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _sectionHeader(AppState state, int count) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(state.isEmployer ? 'Your Postings' : state.tr('recommended'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      GestureDetector(child: Text(state.tr('view_all', args: {'count': '$count'}), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
    ]),
  );
}
