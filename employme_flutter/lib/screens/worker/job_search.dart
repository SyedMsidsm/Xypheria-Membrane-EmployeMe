import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({super.key});
  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  String _distance = '2km';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        _header(), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 130), child: Column(children: [
          _searchInput(), _recentSearches(), _distanceFilter(), _jobTypeFilter(), _payFilter(), _availabilityToggle(),
        ]))),
      ])),
      bottomSheet: _bottom(),
      bottomNavigationBar: const WorkerNav(currentIndex: 1),
    );
  }

  Widget _header() => Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 0), child: Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)), child: const Icon(Icons.arrow_back, size: 20))),
    const Expanded(child: Column(children: [Text('Search Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)), Text('ಕೆಲಸ ಹುಡುಕಿ', style: TextStyle(fontSize: 12, color: AppColors.caption))])),
    const SizedBox(width: 42),
  ]));

  Widget _searchInput() => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), child: Container(height: 52, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(
    color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 16)]),
    child: const Row(children: [Icon(Icons.search, color: AppColors.primary), SizedBox(width: 10), Expanded(child: Text('What job are you looking for?', style: TextStyle(fontSize: 15, color: AppColors.caption))), Icon(Icons.close, size: 18, color: AppColors.caption)])));

  Widget _recentSearches() => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Recent searches', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)), const SizedBox(height: 10),
    Wrap(spacing: 8, children: ['Shop Helper', 'Cook', 'Delivery'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [Text(s, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), const SizedBox(width: 6), const Icon(Icons.close, size: 12, color: AppColors.caption)]))).toList()),
  ]));

  Widget _distanceFilter() => _filterCard('📍 Distance from you', 'ನಿಮ್ಮಿಂದ ದೂರ', Column(children: [
    const SizedBox(height: 8), SliderTheme(data: SliderThemeData(activeTrackColor: AppColors.primary, inactiveTrackColor: AppColors.border, thumbColor: AppColors.primary, overlayColor: AppColors.primary.withOpacity(0.1)),
      child: Slider(value: _distance == '500m' ? 0.05 : _distance == '1km' ? 0.1 : _distance == '2km' ? 0.2 : 0.5, onChanged: (_) {})),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('500m', style: TextStyle(fontSize: 11, color: AppColors.caption)), Text('10km', style: TextStyle(fontSize: 11, color: AppColors.caption))]),
    const SizedBox(height: 12),
    Row(children: ['500m', '1km', '2km', '5km'].map((d) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(onTap: () => setState(() => _distance = d),
      child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(
        color: _distance == d ? AppColors.primaryLight : AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: _distance == d ? AppColors.primary : AppColors.border)),
        alignment: Alignment.center, child: Text(d, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _distance == d ? AppColors.primaryDark : AppColors.textSecondary))))))).toList()),
  ]));

  Widget _jobTypeFilter() => _filterCard('💼 Job Type', 'ಕೆಲಸದ ಪ್ರಕಾರ', Wrap(spacing: 8, runSpacing: 8, children: ['Full Time', 'Part Time', 'Daily Wage', 'Weekend Only'].asMap().entries.map((e) =>
    Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(
      color: e.key < 2 ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: e.key < 2 ? AppColors.primary : AppColors.border)),
      child: Text('${e.key < 2 ? '✓ ' : ''}${e.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: e.key < 2 ? Colors.white : AppColors.text)))).toList()));

  Widget _payFilter() => _filterCard('💰 Pay Range', 'ಸಂಬಳ', Column(children: [
    Row(children: [_payBox('Min ₹', '300'), const SizedBox(width: 10), _payBox('Max ₹', '800')]),
    const SizedBox(height: 12),
    Container(decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(10)), child: Row(children:
      ['Day', 'Month', 'Hour'].asMap().entries.map((e) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: e.key == 0 ? AppColors.primary : AppColors.card, border: e.key < 2 ? const Border(right: BorderSide(color: AppColors.border)) : null),
        alignment: Alignment.center, child: Text('per ${e.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: e.key == 0 ? Colors.white : AppColors.textSecondary))))).toList())),
  ]));

  Widget _payBox(String l, String v) => Expanded(child: Container(height: 48, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(
    color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Row(children: [Text(l, style: const TextStyle(color: AppColors.caption)), const SizedBox(width: 4), Text(v, style: const TextStyle(fontWeight: FontWeight.w600))])));

  Widget _availabilityToggle() => _filterCard('📅 Match my availability', '', Row(children: [
    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Only show jobs on: Mon-Fri', style: TextStyle(fontSize: 13, color: AppColors.textSecondary))])),
    Switch(value: true, onChanged: (_) {}, activeColor: AppColors.primary),
  ]));

  Widget _filterCard(String title, String subtitle, Widget child) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      if (subtitle.isNotEmpty) ...[const SizedBox(height: 4), Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))],
      const SizedBox(height: 16), child,
    ]),
  ));

  Widget _bottom() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Reset Filters', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () {}, child: const Text('Show 47 Jobs'))),
    ]));
}
