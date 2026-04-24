import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class EmployerReviews extends StatelessWidget {
  const EmployerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(state.tr('reviews'), style: const TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.navy,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _ratingSummary(state),
          const SizedBox(height: 24),
          _reviewCard('Raju Kumar', 'Excellent employer! Very clear instructions and timely payment.', '5.0', '2 days ago'),
          _reviewCard('Aman Kumar', 'Good experience. Friendly staff and professional environment.', '4.8', '1 week ago'),
          _reviewCard('Priya Devi', 'Fair and honest. Would love to work here again.', '5.0', '2 weeks ago'),
          _reviewCard('Suresh Mallya', 'Reliable workplace. Highly recommended for part-time work.', '4.5', '1 month ago'),
        ],
      ),
    );
  }

  Widget _ratingSummary(AppState state) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Column(children: [
        const Text('4.8', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: AppColors.navy)),
        Text('out of 5', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ]),
      const SizedBox(width: 24),
      Expanded(child: Column(children: [
        _ratingBar(5, 0.8), _ratingBar(4, 0.15), _ratingBar(3, 0.05), _ratingBar(2, 0), _ratingBar(1, 0),
      ])),
    ]),
  );

  Widget _ratingBar(int star, double val) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(children: [
      Text('$star', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(width: 8),
      Expanded(child: LinearProgressIndicator(value: val, backgroundColor: AppColors.bg, color: Colors.amber, minHeight: 6)),
    ]),
  );

  Widget _reviewCard(String name, String text, String rating, String time) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(time, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        Text('⭐ $rating', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.amber)),
        const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
          child: const Text('Verified Worker', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primaryDark))),
      ]),
      const SizedBox(height: 12),
      Text(text, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
    ]),
  );
}
