import 'dart:async';
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
  double _radiusKm = 2.5; // default 2.5 km = 2500m

  // Nearby notification state
  Map<String, dynamic>? _nearbyNotification;
  Timer? _notifTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic> && args.containsKey('query')) {
        setState(() => _searchController.text = args['query'] ?? '');
      }
      // Simulate a nearby job notification after 3 seconds
      _scheduleNearbyNotification();
    });
  }

  void _scheduleNearbyNotification() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final state = context.read<AppState>();
      final urgentJobs = state.workerFeedJobs
          .where((j) => j['isUrgent'] == true)
          .toList();
      if (urgentJobs.isNotEmpty) {
        setState(() => _nearbyNotification = urgentJobs.first);
        _notifTimer = Timer(const Duration(seconds: 6), () {
          if (mounted) setState(() => _nearbyNotification = null);
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _notifTimer?.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredJobs(AppState state) {
    // Exclude featured jobs from the main list (they show in carousel)
    var jobs = state.workerFeedJobs
        .where((j) => !(j['isFeatured'] == true))
        .toList();

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
      jobs = jobs.where((j) =>
        (j['type'] as String).toLowerCase().contains(filterVal.toLowerCase()) ||
        (j['title'] as String).toLowerCase().contains(filterVal.toLowerCase())
      ).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      jobs = jobs.where((j) =>
        (j['title'] as String).toLowerCase().contains(q) ||
        (j['company'] as String).toLowerCase().contains(q) ||
        (j['type'] as String).toLowerCase().contains(q)
      ).toList();
    }
    // Filter by radius — parse distance string like '6 min walk' / '1.2 km'
    jobs = jobs.where((j) {
      final distStr = (j['distance'] as String? ?? '').toLowerCase();
      // Estimate: 1 min walk ≈ 80m
      if (distStr.contains('min walk')) {
        final mins = double.tryParse(distStr.split(' ')[0]) ?? 99;
        final estimatedKm = mins * 80 / 1000;
        return estimatedKm <= _radiusKm;
      } else if (distStr.contains('km')) {
        final km = double.tryParse(distStr.split(' ')[0]) ?? 99;
        return km <= _radiusKm;
      }
      return true; // show if distance unknown
    }).toList();

    return jobs;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final filteredJobs = _getFilteredJobs(state);
    final featuredJobs = state.workerFeedJobs
        .where((j) => j['isFeatured'] == true)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(children: [
              _appBar(context, state),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    _searchBar(state),
                    _urgentBanner(state),
                    // Featured Jobs Carousel
                    if (featuredJobs.isNotEmpty) ...[
                      _featuredHeader(state),
                      _featuredCarousel(context, state, featuredJobs),
                      const SizedBox(height: 8),
                    ],
                    _categories(context, state),
                    _radiusSlider(state),
                    _sectionHeader(state, filteredJobs.length),
                    ...filteredJobs.map((j) => Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      child: JobCard(
                        icon: j['icon'] as IconData?,
                        emoji: j['emoji'] as String?,
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
                          const Icon(Icons.search_off_rounded, size: 48, color: AppColors.caption),
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
            // Nearby Job Notification Banner (overlaid at top)
            if (_nearbyNotification != null)
              Positioned(
                top: 0, left: 0, right: 0,
                child: _NearbyNotificationBanner(
                  job: _nearbyNotification!,
                  onDismiss: () {
                    _notifTimer?.cancel();
                    setState(() => _nearbyNotification = null);
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const WorkerNav(currentIndex: 0),
    );
  }

  Widget _featuredHeader(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.star_rounded, size: 18, color: Colors.amber.shade700),
      ),
      const SizedBox(width: 10),
      const Text('Featured Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const Spacer(),
      Text('Premium', style: TextStyle(fontSize: 12, color: Colors.amber.shade700, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _featuredCarousel(BuildContext context, AppState state, List<Map<String, dynamic>> featured) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final j = featured[index];
          return _FeaturedJobCard(
            job: j,
            state: state,
            onTap: () => Navigator.pushNamed(context, '/job-detail', arguments: j),
            onApply: () => Navigator.pushNamed(context, '/apply'),
          );
        },
      ),
    );
  }

  Widget _appBar(BuildContext context, AppState state) => Container(
    color: AppColors.card,
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
    child: Row(children: [
      TapScale(
        onTap: () => Navigator.pushNamed(context, '/worker-profile'),
        child: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(state.userName.isNotEmpty ? state.userName[0] : 'U', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
          ),
          const SizedBox(width: 10),
          Text('${state.tr('hi')}, ${state.userName.split(' ')[0]}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
              child: Text('${state.unreadNotifications}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)),
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
              child: const Center(child: Icon(Icons.local_fire_department, size: 20, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(state.tr('urgent_hiring'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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

  Widget _radiusSlider(AppState state) {
    final int radiusM = (_radiusKm * 1000).round();
    final String label = radiusM >= 1000
        ? '${(radiusM / 1000).toStringAsFixed(1)} km'
        : '${radiusM}m';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.soft,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              const Icon(Icons.radar, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              const Text('Nearby Radius', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
            ),
          ]),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.15),
            ),
            child: Slider(
              min: 0.5,
              max: 5.0,
              divisions: 9, // steps: 0.5, 1.0, 1.5 ... 5.0 (each = 500m)
              value: _radiusKm,
              onChanged: (v) => setState(() => _radiusKm = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('500m', style: TextStyle(fontSize: 10, color: AppColors.caption)),
              Text('1.5km', style: TextStyle(fontSize: 10, color: AppColors.caption)),
              Text('2.5km', style: TextStyle(fontSize: 10, color: AppColors.caption)),
              Text('3.5km', style: TextStyle(fontSize: 10, color: AppColors.caption)),
              Text('5km', style: TextStyle(fontSize: 10, color: AppColors.caption)),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _sectionHeader(AppState state, int count) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(state.tr('recommended'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      GestureDetector(child: Text(state.tr('view_all', args: {'count': '$count'}), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
    ]),
  );
}

// ── Featured Job Card ──────────────────────────────────────────────────────────

class _FeaturedJobCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final AppState state;
  final VoidCallback onTap;
  final VoidCallback onApply;

  const _FeaturedJobCard({
    required this.job,
    required this.state,
    required this.onTap,
    required this.onApply,
  });

  static const List<List<Color>> _gradients = [
    [Color(0xFF667eea), Color(0xFF764ba2)],
    [Color(0xFF11998e), Color(0xFF38ef7d)],
    [Color(0xFFf7971e), Color(0xFFffd200)],
  ];

  @override
  Widget build(BuildContext context) {
    final idx = (job['title'] as String).length % _gradients.length;
    final colors = _gradients[idx];
    final title = state.language == 'kn' ? (job['title_kn'] ?? job['title']) : job['title'] as String;
    final location = state.language == 'kn' ? (job['location_kn'] ?? job['location']) : job['location'] as String;

    return TapScale(
      onTap: onTap,
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
          boxShadow: [BoxShadow(color: colors[0].withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Stack(
          children: [
            // Decorative circle
            Positioned(
              top: -20, right: -20,
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.star_rounded, size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        const Text('FEATURED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                      ]),
                    ),
                    if (job['verified'] == true) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified_rounded, size: 14, color: Colors.white),
                    ],
                  ]),
                  const SizedBox(height: 8),
                  // Emoji
                  Text(job['emoji'] as String? ?? '💼', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 4),
                  // Title
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(job['company'] as String, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  // Salary
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      '${job['salary']}${job['period']}',
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Location & Apply
                  Row(children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.white70),
                    const SizedBox(width: 3),
                    Expanded(child: Text(location, style: const TextStyle(color: Colors.white70, fontSize: 11), overflow: TextOverflow.ellipsis)),
                    GestureDetector(
                      onTap: onApply,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Text('Apply', style: TextStyle(color: colors[0], fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Nearby Notification Banner ─────────────────────────────────────────────────

class _NearbyNotificationBanner extends StatelessWidget {
  final Map<String, dynamic> job;
  final VoidCallback onDismiss;

  const _NearbyNotificationBanner({required this.job, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)]),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 4))],
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('🔥 New Job Nearby!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            const SizedBox(height: 2),
            Text(
              '${job['title']} · ${job['company']} · ${job['location']}',
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ])),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.8), size: 18),
          ),
        ]),
      ),
    );
  }
}
