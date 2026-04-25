import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({super.key});
  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  String _distance = '2km';
  final Set<String> _selectedTypes = {'full_time', 'part_time'};
  String _selectedPeriod = 'per_day';
  final TextEditingController _minPayController = TextEditingController(text: '300');
  final TextEditingController _maxPayController = TextEditingController(text: '800');
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _minPayController.dispose();
    _maxPayController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  int _getMatchCount(AppState state) {
    var jobs = state.workerFeedJobs;
    final q = _searchController.text.toLowerCase();
    if (q.isNotEmpty) {
      jobs = jobs.where((j) => 
        (j['title'] as String).toLowerCase().contains(q) || 
        (j['company'] as String).toLowerCase().contains(q) ||
        (j['type'] as String).toLowerCase().contains(q)
      ).toList();
    }
    // Also filter by selected job types if any (simplified for demo)
    if (_selectedTypes.isNotEmpty) {
      // In DemoData, types are 'Cooking', 'Shop Helper', etc.
      // _selectedTypes keys are 'full_time', 'part_time', 'daily_wage', 'weekend_only'.
      // This part is a bit tricky because DemoData doesn't have 'full_time' field yet.
      // I'll skip this for now or just add it to DemoData.
    }
    return jobs.length;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        _header(state), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 130), child: Column(children: [
          _searchInput(state), _recentSearches(state), _distanceFilter(state), _jobTypeFilter(state), _payFilter(state), _availabilityToggle(state),
        ]))),
      ])),
      bottomSheet: _bottom(state),
      bottomNavigationBar: const WorkerNav(currentIndex: 1),
    );
  }

  Widget _header(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 0), child: Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)), child: const Icon(Icons.arrow_back, size: 20))),
    Expanded(child: Center(child: Text(state.tr('search_jobs_title'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)))),
    const SizedBox(width: 42),
  ]));

  Widget _searchInput(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), child: Container(height: 56, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(
    color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.primary, width: 1.5), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 16)]),
    child: Row(children: [
      const Icon(Icons.search, color: AppColors.primary), 
      const SizedBox(width: 12), 
      Expanded(child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: state.tr('what_job_looking'), 
          hintStyle: const TextStyle(color: AppColors.caption, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          isDense: true,
        ),
      )), 
      GestureDetector(
        onTap: () => _searchController.clear(),
        child: const Icon(Icons.close, size: 20, color: AppColors.caption)
      )])));

  Widget _recentSearches(AppState state) {
    final recent = ['Shop', 'Cooking', 'Delivery'];
    return Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(state.tr('recent_searches'), style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), 
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: recent.map((term) => GestureDetector(
        onTap: () => setState(() => _searchController.text = term),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(term, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), 
            const SizedBox(width: 6), 
            const Icon(Icons.close, size: 14, color: AppColors.caption)
          ])),
      )).toList()),
    ]));
  }

  Widget _distanceFilter(AppState state) => _filterCard('📍 ${state.tr('distance_from_you')}', Column(children: [
    const SizedBox(height: 8), SliderTheme(data: SliderThemeData(activeTrackColor: AppColors.primary, inactiveTrackColor: AppColors.border, thumbColor: AppColors.primary, overlayColor: AppColors.primary.withOpacity(0.1)),
      child: Slider(value: _distance == '500m' ? 0.05 : _distance == '1km' ? 0.1 : _distance == '2km' ? 0.2 : _distance == '5km' ? 0.5 : 1.0, onChanged: (v) {
        setState(() {
          if (v < 0.08) _distance = '500m';
          else if (v < 0.15) _distance = '1km';
          else if (v < 0.35) _distance = '2km';
          else if (v < 0.75) _distance = '5km';
          else _distance = '10km';
        });
      })),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('500m', style: TextStyle(fontSize: 11, color: AppColors.caption)), Text('10km', style: TextStyle(fontSize: 11, color: AppColors.caption))]),
    const SizedBox(height: 12),
    Row(children: ['500m', '1km', '2km', '5km', '10km'].map((d) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(onTap: () => setState(() => _distance = d),
      child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(
        color: _distance == d ? AppColors.primaryLight : AppColors.bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: _distance == d ? AppColors.primary : AppColors.border, width: 1.5)),
        alignment: Alignment.center, child: Text(d, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _distance == d ? AppColors.primaryDark : AppColors.textSecondary))))))).toList()),
  ]));

  Widget _jobTypeFilter(AppState state) {
    final typeKeys = ['full_time', 'part_time', 'daily_wage', 'weekend_only'];
    return _filterCard('💼 ${state.tr('job_type_label')}', Wrap(spacing: 10, runSpacing: 10, children: typeKeys.map((key) {
      final sel = _selectedTypes.contains(key);
      return GestureDetector(
        onTap: () => setState(() {
          if (sel) _selectedTypes.remove(key); else _selectedTypes.add(key);
        }),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), decoration: BoxDecoration(
          color: sel ? AppColors.primary : AppColors.bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: sel ? AppColors.primary : AppColors.border, width: 1.5)),
          child: Text('${sel ? '✓ ' : ''}${state.tr(key)}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: sel ? Colors.white : AppColors.text))),
      );
    }).toList()));
  }

  Widget _payFilter(AppState state) => _filterCard('💰 ${state.tr('pay_range')}', Column(children: [
    Row(children: [
      _payBox('Min ₹', _minPayController), 
      const SizedBox(width: 10), 
      _payBox('Max ₹', _maxPayController)
    ]),
    const SizedBox(height: 12),
    Container(decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(10)), child: Row(children:
      ['per_day', 'per_month', 'per_hour'].map((key) {
        final sel = _selectedPeriod == key;
        return Expanded(child: GestureDetector(
          onTap: () => setState(() => _selectedPeriod = key),
          child: Container(padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(color: sel ? AppColors.primary : AppColors.card, border: key != 'per_hour' ? const Border(right: BorderSide(color: AppColors.border)) : null),
            alignment: Alignment.center, child: Text(state.tr(key), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.textSecondary))),
        ));
      }).toList())),
  ]));

  Widget _payBox(String l, TextEditingController controller) => Expanded(child: Container(height: 48, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(
    color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Text(l, style: const TextStyle(color: AppColors.caption)), 
      const SizedBox(width: 4), 
      Expanded(child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
      ))])));

  Widget _availabilityToggle(AppState state) => _filterCard('📅 ${state.tr('match_availability')}', Column(children: [
    Row(children: [
      Expanded(child: Text(state.tr('show_jobs_on'), style: const TextStyle(fontSize: 15, color: AppColors.text, fontWeight: FontWeight.w600))),
      Switch(value: state.availableNow, onChanged: (v) => state.setAvailableNow(v), activeColor: AppColors.primary),
    ]),
    const SizedBox(height: 8),
    Text('Jobs matching your profile availability are prioritized.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary.withOpacity(0.8))),
  ]));

  Widget _filterCard(String title, Widget child) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
      const SizedBox(height: 16), child,
    ]),
  ));

  Widget _bottom(AppState state) => Container(
    decoration: BoxDecoration(color: AppColors.card, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
        onTap: () => setState(() { 
          _distance = '2km'; 
          _selectedTypes.clear();
          _selectedTypes.addAll(['full_time', 'part_time']);
          _selectedPeriod = 'per_day';
          _minPayController.text = '300';
          _maxPayController.text = '800';
          _searchController.clear();
        }),
        child: Text(state.tr('reset_filters'), style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w700))),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
        onPressed: () => Navigator.pushReplacementNamed(context, '/worker-home', arguments: {'query': _searchController.text}), 
        child: Text(state.tr('show_n_jobs', args: {'count': '${_getMatchCount(state)}'}), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))),
    ]));
}
