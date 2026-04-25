import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class EmployerAnalytics extends StatelessWidget {
  const EmployerAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(state.tr('analytics'), style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.navy,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _summaryGrid(),
          const SizedBox(height: 24),
          _chartPlaceholder('Profile Views', '842 this week', Colors.blue),
          const SizedBox(height: 16),
          _chartPlaceholder('Applications', '47 new this week', Colors.green),
          const SizedBox(height: 16),
          _chartPlaceholder('Worker Retention', '92% satisfaction', Colors.orange),
        ],
      ),
    );
  }

  Widget _summaryGrid() => GridView.count(
    crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.6,
    children: [
      _summaryBox('1,240', 'Total Views', Icons.remove_red_eye),
      _summaryBox('47', 'Applications', Icons.description),
      _summaryBox('89%', 'Response Rate', Icons.speed),
      _summaryBox('₹0', 'Spent on Ads', Icons.payments),
    ],
  );

  Widget _summaryBox(String val, String label, IconData icon) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const Text('+12%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.green)),
      ]),
      const Spacer(),
      Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    ]),
  );

  Widget _chartPlaceholder(String title, String sub, Color color) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      Text(sub, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      const SizedBox(height: 24),
      Container(height: 100, decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(7, (i) => Container(
          width: 20, height: (20 + i * 10).toDouble(), decoration: BoxDecoration(color: color.withOpacity(0.4), borderRadius: const BorderRadius.vertical(top: Radius.circular(4))),
        ))),
      ),
    ]),
  );
}
