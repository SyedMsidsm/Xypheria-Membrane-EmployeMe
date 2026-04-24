import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';

class QuickApply extends StatefulWidget {
  const QuickApply({super.key});
  @override
  State<QuickApply> createState() => _QuickApplyState();
}

class _QuickApplyState extends State<QuickApply> with SingleTickerProviderStateMixin {
  int _step = 0; // 0 = form, 1 = confirm, 2 = success
  String _availability = 'Immediately';
  String _timing = 'Morning (6 AM - 12 PM)';
  late AnimationController _successCtrl;
  late Animation<double> _successScale;

  @override
  void initState() {
    super.initState();
    _successCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _successScale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _successCtrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() { _successCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _step == 2 ? _successView() : _formView(),
        ),
      ),
      bottomNavigationBar: _step == 2 ? null : Container(
        color: AppColors.card,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: () {
              if (_step == 0) {
                setState(() => _step = 1);
              } else {
                HapticFeedback.mediumImpact();
                setState(() => _step = 2);
                _successCtrl.forward();
              }
            },
            child: Text(_step == 0 ? 'Continue' : 'Submit Application ✓'),
          ),
        ),
      ),
    );
  }

  Widget _formView() => SingleChildScrollView(
    key: const ValueKey('form'),
    padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        GestureDetector(
          onTap: () { if (_step > 0) setState(() => _step--); else Navigator.pop(context); },
          child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)), child: const Icon(Icons.arrow_back, size: 20)),
        ),
        const Spacer(),
        Text('Step ${_step + 1} of 2', style: const TextStyle(fontSize: 13, color: AppColors.caption, fontWeight: FontWeight.w500)),
      ]),
      const SizedBox(height: 8),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(value: (_step + 1) / 2, minHeight: 4, backgroundColor: AppColors.border, valueColor: const AlwaysStoppedAnimation(AppColors.primary)),
      ),
      const SizedBox(height: 24),
      Text(_step == 0 ? 'Quick Apply' : 'Confirm Details', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(_step == 0 ? 'ತ್ವರಿತ ಅರ್ಜಿ' : 'ವಿವರಗಳನ್ನು ಖಚಿತಪಡಿಸಿ', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      const SizedBox(height: 24),
      if (_step == 0) ..._formStep1(),
      if (_step == 1) _formStep2(),
    ]),
  );

  List<Widget> _formStep1() => [
    const Text('When can you start?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    const SizedBox(height: 10),
    ...['Immediately', 'Tomorrow', 'This Week', 'Next Week'].map((opt) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TapScale(
        onTap: () => setState(() => _availability = opt),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _availability == opt ? AppColors.primary.withOpacity(0.05) : AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: _availability == opt ? AppColors.primary : AppColors.border, width: _availability == opt ? 2 : 1),
            boxShadow: AppShadows.soft,
          ),
          child: Row(children: [
            Text(opt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _availability == opt ? AppColors.primaryDark : AppColors.text)),
            const Spacer(),
            if (_availability == opt) const Icon(Icons.check_circle, size: 18, color: AppColors.primary),
          ]),
        ),
      ),
    )),
    const SizedBox(height: 16),
    const Text('Preferred Timing', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    const SizedBox(height: 10),
    ...['Morning (6 AM - 12 PM)', 'Afternoon (12 PM - 6 PM)', 'Evening (6 PM - 10 PM)', 'Flexible'].map((opt) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TapScale(
        onTap: () => setState(() => _timing = opt),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _timing == opt ? AppColors.primary.withOpacity(0.05) : AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: _timing == opt ? AppColors.primary : AppColors.border, width: _timing == opt ? 2 : 1),
            boxShadow: AppShadows.soft,
          ),
          child: Row(children: [
            Text(opt, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _timing == opt ? AppColors.primaryDark : AppColors.text)),
            const Spacer(),
            if (_timing == opt) const Icon(Icons.check_circle, size: 18, color: AppColors.primary),
          ]),
        ),
      ),
    )),
  ];

  Widget _formStep2() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md)),
          alignment: Alignment.center, child: const Text('🏪', style: TextStyle(fontSize: 24))),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Shop Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          Text('Sri Ganesh Provision Store', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ])),
      ]),
      const Divider(height: 24),
      _detailRow('💰 Salary', '₹12,000/mo'),
      _detailRow('📍 Location', 'Kodialbail (6 min walk)'),
      _detailRow('🕐 Start', _availability),
      _detailRow('⏰ Timing', _timing),
      _detailRow('🛡️ Trust Score', '87 / 100'),
    ]),
  );

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _successView() => Center(
    key: const ValueKey('success'),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ScaleTransition(
        scale: _successScale,
        child: Container(
          width: 100, height: 100,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            boxShadow: AppShadows.primaryGlow(0.2),
          ),
          child: const Icon(Icons.check_rounded, size: 56, color: AppColors.primary),
        ),
      ),
      const SizedBox(height: 24),
      const Text('Application Sent! 🎉', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('ಅರ್ಜಿ ಕಳುಹಿಸಲಾಗಿದೆ!', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 4),
      const Text('The employer will review your profile', style: TextStyle(fontSize: 14, color: AppColors.caption)),
      const SizedBox(height: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            child: const Text('Back to Jobs'),
          ),
        ),
      ),
      const SizedBox(height: 12),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, '/my-jobs'),
        child: const Text('View My Applications →', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
      ),
    ]),
  );
}
