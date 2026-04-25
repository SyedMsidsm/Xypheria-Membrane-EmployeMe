import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class QuickApply extends StatefulWidget {
  const QuickApply({super.key});
  @override
  State<QuickApply> createState() => _QuickApplyState();
}

class _QuickApplyState extends State<QuickApply> with SingleTickerProviderStateMixin {
  int _step = 0; // 0 = form, 1 = confirm, 2 = success
  String _availability = 'Today';
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
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _step == 2 ? _successView(state) : _formView(state),
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
            child: Text(_step == 0 ? state.tr('continue_party') : state.tr('submit_application')),
          ),
        ),
      ),
    );
  }

  Widget _formView(AppState state) => SingleChildScrollView(
    key: const ValueKey('form'),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Header matching React's centered job info
      Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        decoration: const BoxDecoration(color: AppColors.card, border: Border(bottom: BorderSide(color: AppColors.border))),
        child: Column(children: [
          Row(children: [
            GestureDetector(
              onTap: () { if (_step > 0) setState(() => _step--); else Navigator.pop(context); },
              child: const Icon(Icons.arrow_back, size: 22),
            ),
            Expanded(child: Column(children: [
              Text(state.tr('applying_for'), style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const Text('Shop Assistant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              Text(state.businessName, style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ])),
            const SizedBox(width: 22), // Balance the back button
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Text(state.tr('step_of', args: {'current': '${_step + 1}', 'total': '2'}), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(width: 8),
            Expanded(child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(value: (_step + 1) / 2, minHeight: 3, backgroundColor: AppColors.border, valueColor: const AlwaysStoppedAnimation(AppColors.primary)),
            )),
          ]),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_step == 0 ? state.tr('confirm_details') : state.tr('confirm_details'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(state.tr('share_with_employer'), style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          if (_step == 0) ..._formStep1(state),
          if (_step == 1) _formStep2(state),
        ]),
      ),
    ]),
  );

  List<Widget> _formStep1(AppState state) => [
    // Profile Summary Card matching React
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          Row(children: [
            Container(
              width: 52, height: 52,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
              alignment: Alignment.center,
              child: Text(state.userName[0], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(state.userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Wrap(spacing: 6, children: [
                Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.cleaning_services, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(state.tr('Cleaning'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary))]),
                Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.storefront, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(state.tr('Shop Helper'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary))])
              ].map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                child: s,
              )).toList()),
            ]),
          ]),
          Positioned(top: 0, right: 0, child: Text(state.tr('change'), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 10),
        Row(children: [const Icon(Icons.location_on, size: 14, color: AppColors.primary), const SizedBox(width: 4), const Text('Kodialbail — ', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)), const Icon(Icons.directions_walk, size: 14, color: AppColors.primary), const Text(' 6 min away', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))]),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: ['Phone Verified', 'Community Verified'].map((b) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(b, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary))]),
        )).toList()),
      ]),
    ),
    const SizedBox(height: 24),
    // When can you start?
    Text(state.tr('when_start'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    const SizedBox(height: 12),
    ...[state.tr('today'), state.tr('tomorrow'), state.tr('this_week'), state.tr('discuss')].map((opt) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TapScale(
        onTap: () => setState(() => _availability = opt),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _availability == opt ? AppColors.primaryLight : AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _availability == opt ? AppColors.primary : AppColors.border, width: _availability == opt ? 2 : 1.5),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (_availability == opt) ...[
              const Icon(Icons.check, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
            ],
            Text(opt, style: TextStyle(fontSize: 15, fontWeight: _availability == opt ? FontWeight.w500 : FontWeight.w500)),
          ]),
        ),
      ),
    )),
    // Optional message
    const SizedBox(height: 24),
    Text(state.tr('add_message'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    const SizedBox(height: 8),
    Container(
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          hintText: state.tr('msg_placeholder'),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(fontSize: 14, color: AppColors.caption),
          fillColor: Colors.transparent,
          filled: true,
        ),
        style: const TextStyle(fontSize: 14),
      ),
    ),
    const Align(alignment: Alignment.centerRight, child: Padding(
      padding: EdgeInsets.only(top: 4),
      child: Text('0/200', style: TextStyle(fontSize: 12, color: AppColors.caption)),
    )),
  ];

  Widget _formStep2(AppState state) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.md)),
          alignment: Alignment.center, child: const Icon(Icons.storefront, size: 24, color: AppColors.primaryDark)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Shop Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(state.businessName, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ])),
      ]),
      const Divider(height: 24),
      _detailRow(Icons.payments, 'Salary', '₹12,000/mo'),
      _detailRow(Icons.location_on, 'Location', 'Kodialbail (6 min walk)'),
      _detailRow(Icons.access_time, 'Start', _availability),
      _detailRow(Icons.schedule, 'Timing', _timing),
      _detailRow(Icons.shield, 'Trust Score', '87 / 100'),
    ]),
  );

  Widget _detailRow(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [Icon(icon, size: 16, color: AppColors.textSecondary), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary))]),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _successView(AppState state) => Center(
    key: const ValueKey('success'),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: _successScale,
          child: Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 3),
            ),
            child: const Icon(Icons.check_rounded, size: 40, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 20),
        Text(state.tr('application_sent'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.primary)),
        const SizedBox(height: 12),
        Text(state.tr('contact_soon', args: {'company': state.businessName}),
          style: const TextStyle(fontSize: 15, color: AppColors.textSecondary, height: 1.5),
          textAlign: TextAlign.center),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
          child: Text(state.tr('usually_within'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ),
        const SizedBox(height: 32),
        Row(children: [
          Expanded(child: SizedBox(height: 48, child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/my-jobs'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.border, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(state.tr('view_application'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
          ))),
          const SizedBox(width: 10),
          Expanded(child: SizedBox(height: 48, child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text(state.tr('find_more_jobs'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ))),
        ]),
        const SizedBox(height: 20),
        GestureDetector(
          child: Text(state.tr('share_friend'),
            style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
        ),
      ]),
    ),
  );
}
