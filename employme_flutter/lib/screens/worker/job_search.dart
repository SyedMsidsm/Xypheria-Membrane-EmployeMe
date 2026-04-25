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

  Widget _searchInput(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), child: Container(height: 52, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(
    color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 16)]),
    child: Row(children: [const Icon(Icons.search, color: AppColors.primary), const SizedBox(width: 10), Expanded(child: Text(state.tr('what_job_looking'), style: const TextStyle(fontSize: 15, color: AppColors.caption))), const Icon(Icons.close, size: 18, color: AppColors.caption)])));

  Widget _recentSearches(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(state.tr('recent_searches'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)), const SizedBox(height: 10),
    Wrap(spacing: 8, children: ['shop_cat', 'cooking_cat', 'delivery_cat'].map((key) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Text(state.tr(key), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), const SizedBox(width: 6), const Icon(Icons.close, size: 12, color: AppColors.caption)]))).toList()),
  ]));

  Widget _distanceFilter(AppState state) => _filterCard(Icons.location_on, state.tr('distance_from_you'), Column(children: [
    const SizedBox(height: 8), SliderTheme(data: SliderThemeData(activeTrackColor: AppColors.primary, inactiveTrackColor: AppColors.border, thumbColor: AppColors.primary, overlayColor: AppColors.primary.withOpacity(0.1)),
      child: Slider(value: _distance == '500m' ? 0.05 : _distance == '1km' ? 0.1 : _distance == '2km' ? 0.2 : 0.5, onChanged: (v) {
        setState(() {
          if (v < 0.08) _distance = '500m';
          else if (v < 0.15) _distance = '1km';
          else if (v < 0.3) _distance = '2km';
          else _distance = '5km';
        });
      })),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('500m', style: TextStyle(fontSize: 11, color: AppColors.caption)), Text('10km', style: TextStyle(fontSize: 11, color: AppColors.caption))]),
    const SizedBox(height: 12),
    Row(children: ['500m', '1km', '2km', '5km'].map((d) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(onTap: () => setState(() => _distance = d),
      child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(
        color: _distance == d ? AppColors.primaryLight : AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: _distance == d ? AppColors.primary : AppColors.border)),
        alignment: Alignment.center, child: Text(d, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _distance == d ? AppColors.primaryDark : AppColors.textSecondary))))))).toList()),
  ]));

  Widget _jobTypeFilter(AppState state) {
    final types = [state.tr('full_time'), state.tr('part_time'), state.tr('daily_wage'), state.tr('weekend_only')];
    return _filterCard(Icons.work, state.tr('job_type_label'), Wrap(spacing: 8, runSpacing: 8, children: types.asMap().entries.map((e) =>
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(
        color: e.key < 2 ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: e.key < 2 ? AppColors.primary : AppColors.border)),
        child: Text('${e.key < 2 ? '✓ ' : ''}${e.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: e.key < 2 ? Colors.white : AppColors.text)))).toList()));
  }

  Widget _payFilter(AppState state) => _filterCard(Icons.payments, state.tr('pay_range'), Column(children: [
    Row(children: [_payBox('Min ₹', '300'), const SizedBox(width: 10), _payBox('Max ₹', '800')]),
    const SizedBox(height: 12),
    Container(decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(10)), child: Row(children:
      [state.tr('per_day'), state.tr('per_month'), state.tr('per_hour')].asMap().entries.map((e) => Expanded(child: GestureDetector(
        onTap: () => setState(() {}), // Demo toggle
        child: Container(padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: e.key == 0 ? AppColors.primary : AppColors.card, border: e.key < 2 ? const Border(right: BorderSide(color: AppColors.border)) : null),
          alignment: Alignment.center, child: Text(e.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: e.key == 0 ? Colors.white : AppColors.textSecondary))),
      ))).toList())),
  ]));

  Widget _payBox(String l, String v) => Expanded(child: Container(height: 48, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(
    color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Row(children: [Text(l, style: const TextStyle(color: AppColors.caption)), const SizedBox(width: 4), Text(v, style: const TextStyle(fontWeight: FontWeight.w600))])));

  Widget _availabilityToggle(AppState state) => _filterCard(Icons.calendar_month, state.tr('match_availability'), Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(state.tr('show_jobs_on'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))])),
    Switch(value: state.availableNow, onChanged: (v) => state.setAvailableNow(v), activeColor: AppColors.primary),
  ]));

  Widget _filterCard(IconData icon, String title, Widget child) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Container(
    padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border),
      boxShadow: AppShadows.card),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ]),
      const SizedBox(height: 16), child,
    ]),
  ));

  Widget _bottom(AppState state) => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
        onTap: () => setState(() { _distance = '2km'; }),
        child: Text(state.tr('reset_filters'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(state.tr('show_n_jobs', args: {'count': '47'})))),
    ]));
}
