import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';

class MyJobs extends StatefulWidget {
  const MyJobs({super.key});
  @override
  State<MyJobs> createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() { _tabCtrl.dispose(); super.dispose(); }

  List<Map<String, String>> _filteredJobs(AppState state) {
    final tab = ['all', 'pending', 'active', 'completed'][_tabCtrl.index];
    if (tab == 'all') return state.jobs;
    return state.jobs.where((j) => j['status'] == tab).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'active': return AppColors.primary;
      case 'pending': return AppColors.warning;
      case 'completed': return AppColors.info;
      default: return AppColors.caption;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(state),
          _earningsCard(state),
          _tabs(state),
          Expanded(child: _jobsList(state)),
        ]),
      ),
      bottomNavigationBar: const WorkerNav(currentIndex: 2),
    );
  }

  Widget _header(AppState state) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
    color: AppColors.card,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(state.tr('my_jobs'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      TapScale(child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.sm)),
        child: const Icon(Icons.filter_list, size: 20, color: AppColors.textSecondary),
      )),
    ]),
  );

  Widget _earningsCard(AppState state) => Container(
    margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      boxShadow: AppShadows.primaryGlow(0.2),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(children: [
        const Text('₹18,400', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(state.tr('total_earned'), style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
      ]),
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.3)),
      Column(children: [
        const Text('12', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(state.tr('jobs_done_label'), style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
      ]),
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.3)),
      Column(children: [
        const Text('100%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(state.tr('show_up'), style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
      ]),
    ]),
  );

  Widget _tabs(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Container(
      height: 40,
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
      child: TabBar(
        controller: _tabCtrl,
        onTap: (_) => setState(() {}),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        indicator: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppRadius.sm)),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [Tab(text: state.tr('all')), Tab(text: state.tr('pending')), Tab(text: state.tr('active')), Tab(text: state.tr('done'))],
      ),
    ),
  );

  Widget _jobsList(AppState state) {
    final jobs = _filteredJobs(state);
    return ListView.builder(
    padding: const EdgeInsets.all(20),
    itemCount: jobs.length,
    itemBuilder: (_, i) {
      final job = jobs[i];
      final status = job['status']!;
      final color = _statusColor(status);
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TapScale(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.border),
              boxShadow: AppShadows.card,
            ),
            child: IntrinsicHeight(child: Row(children: [
              Container(width: 4, decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppRadius.lg), bottomLeft: Radius.circular(AppRadius.lg)))),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md)),
                    alignment: Alignment.center, child: Text(job['emoji']!, style: const TextStyle(fontSize: 22))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(job['title']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(job['company']!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text(job['started']!, style: const TextStyle(fontSize: 11, color: AppColors.caption)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(job['salary']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(AppRadius.xs)),
                      child: Text(status[0].toUpperCase() + status.substring(1), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
                    ),
                  ]),
                ]),
              )),
            ])),
          ),
        ),
      );
    },
  );
  }
}
