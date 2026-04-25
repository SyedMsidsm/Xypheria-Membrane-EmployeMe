import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/localization_service.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final lang = appState.language;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          // Top Illustration Area — Clean Icon implementation
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD1FAE5), Color(0x33D1FAE5)],
              ),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Center(
              child: CustomPaint(
                size: const Size(200, 150),
                painter: _IllustrationPainter(),
              ),
            ),
          ),

          // Welcome text
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(children: [
              Text(LocalizationService.translate('welcome', lang), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: AppColors.text, letterSpacing: -0.5), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(LocalizationService.translate('welcome_desc', lang),
                style: const TextStyle(fontSize: 15, color: AppColors.textSecondary, fontWeight: FontWeight.w500, height: 1.5),
                textAlign: TextAlign.center),
            ]),
          ),

          // Role cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(children: [
                // Worker Card
                _RoleCard(
                  onTap: () {
                    context.read<AppState>().setRole('worker');
                    Navigator.pushNamed(context, '/phone');
                  },
                  iconWidget: Container(
                    width: 52, height: 52,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight),
                    child: const Center(child: Icon(Icons.person, size: 24, color: AppColors.primaryDark)),
                  ),
                  title: LocalizationService.translate('looking_for_work', lang),
                  subtitle: LocalizationService.translate('looking_for_work_desc', lang),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                      child: const Text('FREE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
                    ),
                    const SizedBox(width: 6),
                    const Text('➔', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                  ]),
                ),
                const SizedBox(height: 16),
                // Employer Card
                _RoleCard(
                  onTap: () {
                    context.read<AppState>().setRole('employer');
                    Navigator.pushNamed(context, '/employer');
                  },
                  iconWidget: Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.info.withOpacity(0.1)),
                    child: const Center(child: Icon(Icons.business_center, size: 24, color: AppColors.info)),
                  ),
                  title: LocalizationService.translate('im_hiring', lang),
                  subtitle: LocalizationService.translate('im_hiring_desc', lang),
                  trailing: const Text('➔', style: TextStyle(fontSize: 18, color: AppColors.caption)),
                ),
              ]),
            ),
          ),

          // Bottom
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(LocalizationService.translate('already_have_account', lang), style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/phone'),
                  child: Text(LocalizationService.translate('sign_in', lang), style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500)),
                ),
              ]),
              const SizedBox(height: 8),
              Text(LocalizationService.translate('terms_privacy', lang),
                style: const TextStyle(fontSize: 12, color: AppColors.caption, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget iconWidget;
  final String title;
  final String subtitle;
  final Widget trailing;

  const _RoleCard({
    required this.onTap,
    required this.iconWidget,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        child: Row(children: [
          iconWidget,
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.text)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          ])),
          trailing,
        ]),
      ),
    );
  }
}
class _IllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Background circles
    canvas.drawCircle(Offset(cx, cy), 60, Paint()..color = AppColors.primary.withOpacity(0.1));
    canvas.drawCircle(Offset(cx, cy), 40, Paint()..color = AppColors.primary.withOpacity(0.2));

    // Worker block
    final workerPaint = Paint()..color = AppColors.primary;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx - 40, cy - 20, 30, 40), const Radius.circular(6)), workerPaint);

    // Employer block
    final employerPaint = Paint()..color = AppColors.info;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(cx + 10, cy - 30, 30, 50), const Radius.circular(6)), employerPaint);

    // Dashed line connecting
    final dashPaint = Paint()..color = AppColors.text..strokeWidth = 3..strokeCap = StrokeCap.round;
    for (double x = cx - 10; x < cx + 10; x += 8) {
      canvas.drawLine(Offset(x, cy), Offset(x + 4, cy), dashPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
