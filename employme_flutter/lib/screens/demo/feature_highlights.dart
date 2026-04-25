import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class FeatureHighlights extends StatelessWidget {
  const FeatureHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 20), child: Column(children: [
        _header(state), _gpsCard(state), _resumeCard(state), _trustCard(state), _techStack(), _algorithm(),
      ]))));
  }

  Widget _header(AppState state) => Padding(padding: const EdgeInsets.all(20), child: Center(child: Text(state.tr('different_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500))));

  Widget _gpsCard(AppState state) => Container(margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)]), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const Text('📍', style: TextStyle(fontSize: 28)), const SizedBox(width: 8), Text(state.tr('gps_title'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))]),
      const SizedBox(height: 12),
      ...['Jobs sorted by walking distance', "Shows '8 min walk' not '0.6km'", 'Walk-to-work = ₹100/day saved'].map((b) =>
        Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('✓ $b', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85))))),
      const SizedBox(height: 12), Align(alignment: Alignment.centerRight, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
        child: const Text('3-4x higher conversion ↗', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)))),
    ]));

  Widget _resumeCard(AppState state) => Container(margin: const EdgeInsets.fromLTRB(20, 14, 20, 0), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF16A34A)]), borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const Text('👤', style: TextStyle(fontSize: 28)), const SizedBox(width: 8), Text(state.tr('apply_no_resume'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))]),
      const SizedBox(height: 12),
      ...['Select skills with icons only', '2-minute onboarding', 'Opens access to 400M excluded workers'].map((b) =>
        Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('✓ $b', style: const TextStyle(fontSize: 13, color: Colors.white)))),
      const SizedBox(height: 12), const Text('12-18 month head start vs competitors', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
    ]));

  Widget _trustCard(AppState state) => Container(margin: const EdgeInsets.fromLTRB(20, 14, 20, 0), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const Text('🛡️', style: TextStyle(fontSize: 28)), const SizedBox(width: 8), Text(state.tr('dual_verification'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))]),
      const SizedBox(height: 12),
      Row(children: [Text('Layer 1: Aadhaar + AI fraud detection', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85))), const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.info, borderRadius: BorderRadius.circular(6)), child: const Text('Auto', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)))]),
      const SizedBox(height: 8),
      Row(children: [Text('Layer 2: NGO in-person verification', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85))), const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)), child: const Text('Human', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)))]),
      const SizedBox(height: 12), const Text('Target: 95% trust score', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)),
    ]));

  Widget _techStack() => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Powered By', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600)),
    const SizedBox(height: 8),
    Wrap(spacing: 6, runSpacing: 6, children: ['Flutter', 'Firebase', 'Node.js', 'Twilio', 'Geohashing ML'].map((t) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(8)),
      child: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))))).toList()),
  ]));

  Widget _algorithm() => Container(margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(12)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Our Matching Algorithm:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
      const SizedBox(height: 8),
      Text('Score =\n  Distance    × 0.40\n+ Skill Match × 0.30\n+ Urgency     × 0.20\n+ Trust Score × 0.10', style: TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.8, color: Colors.white.withOpacity(0.9))),
      const SizedBox(height: 8), const Text('Sub-100ms response on 3G', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
    ]));
}
