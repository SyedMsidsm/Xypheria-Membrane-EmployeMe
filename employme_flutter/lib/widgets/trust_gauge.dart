import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../theme/app_theme.dart';

class TrustGauge extends StatelessWidget {
  final int score;
  final double radius;
  final double lineWidth;

  const TrustGauge({super.key, required this.score, this.radius = 40, this.lineWidth = 6});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: score / 100,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$score', style: TextStyle(fontSize: radius * 0.6, fontWeight: FontWeight.w500, color: AppColors.text)),
          Text('/100', style: TextStyle(fontSize: radius * 0.25, color: AppColors.textSecondary)),
        ],
      ),
      progressColor: AppColors.primary,
      backgroundColor: AppColors.border,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1000,
    );
  }
}
