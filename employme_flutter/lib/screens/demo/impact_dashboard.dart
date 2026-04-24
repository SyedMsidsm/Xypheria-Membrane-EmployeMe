import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ImpactDashboard extends StatelessWidget {
  const ImpactDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.navy,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 20), child: Column(children: [
        _header(context), _heroMetric(), _statsGrid(), _mapPlaceholder(), _impactCategories(), _sdgCards(), _quote(),
      ]))));
  }

  Widget _header(BuildContext ctx) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(onTap: () => Navigator.pop(ctx), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.arrow_back, size: 20, color: Colors.white))),
      Column(children: [const Text('Impact Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
        Text('ಪರಿಣಾಮ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)))]),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)), const SizedBox(width: 4),
          const Text('Live', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white))])),
    ]));

  Widget _heroMetric() => Padding(padding: const EdgeInsets.symmetric(vertical: 32),
    child: Column(children: [
      const Text('2,847', style: TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Colors.white, height: 1)),
      const SizedBox(height: 4), Text('Workers Empowered', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7))),
      const SizedBox(height: 4), Text('ಸಬಲೀಕರಣಗೊಂಡ ಕೆಲಸಗಾರರು', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5))),
    ]));

  Widget _statsGrid() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5, children: [
    _statCard('1,247', 'Jobs Connected', '↑ 23%', AppColors.primary),
    _statCard('₹38L', 'Wages Enabled', '↑ 15%', AppColors.info),
    _statCard('847', 'Verified Workers', '↑ 31%', const Color(0xFFF97316)),
    _statCard('96%', 'Show-Up Rate', '↑ 8%', AppColors.primaryDark),
  ]));

  Widget _statCard(String num, String label, String trend, Color accent) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(num, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: accent)),
      const SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6))),
      const Spacer(), Text(trend, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: accent)),
    ]));

  Widget _mapPlaceholder() => Container(
    height: 200, margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withOpacity(0.05), border: Border.all(color: Colors.white.withOpacity(0.1))),
    child: Stack(alignment: Alignment.center, children: [
      Icon(Icons.map, size: 80, color: Colors.white.withOpacity(0.1)),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Live Activity Map', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.4))),
        Text('Mangalore Region', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3))),
      ]),
      ...List.generate(5, (i) => Positioned(
        left: 40.0 + i * 50, top: 60.0 + (i % 3) * 30,
        child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary, boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8)])))),
    ]));

  Widget _impactCategories() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Impact by Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
    const SizedBox(height: 12),
    ...[{'icon': '🏪', 'label': 'Retail & Shop', 'count': '412', 'pct': 0.6}, {'icon': '🍳', 'label': 'Food & Kitchen', 'count': '287', 'pct': 0.4}, {'icon': '🚚', 'label': 'Delivery', 'count': '198', 'pct': 0.3}]
      .map((c) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
        Text(c['icon'] as String, style: const TextStyle(fontSize: 20)), const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(c['label'] as String, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7))), Text(c['count'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary))]),
          const SizedBox(height: 4), Container(height: 4, decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.white.withOpacity(0.1)),
            child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: c['pct'] as double, child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.primary)))),
        ])),
      ]))),
  ]));

  Widget _sdgCards() => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('UN SDG Alignment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
    const SizedBox(height: 12),
    Row(children: [
      _sdg('🎯', '8: Decent Work', AppColors.primary), const SizedBox(width: 12),
      _sdg('🏘️', '11: Sustainable Cities', AppColors.info),
    ]),
  ]));

  Widget _sdg(String e, String l, Color c) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Text(e, style: const TextStyle(fontSize: 20)), const SizedBox(height: 4), Text(l, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c), textAlign: TextAlign.center)])));

  Widget _quote() => Container(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
    child: Column(children: [
      Text('"EmployMe changed my life. I found my first job within 2 hours of signing up."', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.8), height: 1.5), textAlign: TextAlign.center),
      const SizedBox(height: 8), const Text('— Lakshmi, Kitchen Helper', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
    ]));
}
