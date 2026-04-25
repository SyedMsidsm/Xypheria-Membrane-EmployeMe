import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class PhoneEntry extends StatefulWidget {
  const PhoneEntry({super.key});
  @override
  State<PhoneEntry> createState() => _PhoneEntryState();
}

class _PhoneEntryState extends State<PhoneEntry> {
  final _phoneCtrl = TextEditingController();
  bool _showOtp = false;
  final List<TextEditingController> _otpCtrls = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocus = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    _phoneCtrl.dispose();
    for (var c in _otpCtrls) c.dispose();
    for (var f in _otpFocus) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                onTap: () {
                  if (_showOtp) {
                    setState(() => _showOtp = false);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.card, shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                    boxShadow: AppShadows.soft,
                  ),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
              ),
              Text('${context.watch<AppState>().tr('step')} ${_showOtp ? 2 : 1} ${context.watch<AppState>().tr('of')} 2', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            ]),
            const SizedBox(height: 12),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _showOtp ? 1.0 : 0.5,
                minHeight: 4,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
            // Content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showOtp ? _otpView() : _phoneView(),
            ),
            const Spacer(),
            // Button
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showOtp ? _otpButton() : _phoneButton(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _phoneView() => Column(
    key: const ValueKey('phone'),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(context.watch<AppState>().tr('enter_phone'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
      const SizedBox(height: 24),
      // Phone input
      Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.soft,
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColors.border))),
            child: const Center(child: Text('+91 🇮🇳', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          ),
          Expanded(
            child: TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1),
              decoration: InputDecoration(
                hintText: context.watch<AppState>().tr('phone_hint'),
                counterText: '',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                fillColor: Colors.transparent,
                filled: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ]),
      ),
      const SizedBox(height: 12),
      Text(context.watch<AppState>().tr('otp_message'), style: const TextStyle(fontSize: 13, color: AppColors.caption)),
    ],
  );

  Widget _phoneButton() => SizedBox(
    key: const ValueKey('phone_btn'),
    width: double.infinity, height: 56,
    child: ElevatedButton(
      onPressed: _phoneCtrl.text.length == 10
          ? () => setState(() => _showOtp = true)
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _phoneCtrl.text.length == 10 ? AppColors.primary : AppColors.border,
        foregroundColor: _phoneCtrl.text.length == 10 ? Colors.white : AppColors.caption,
      ),
      child: Text(context.watch<AppState>().tr('send_otp')),
    ),
  );

  Widget _otpView() => Column(
    key: const ValueKey('otp'),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(context.watch<AppState>().tr('verify_otp'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      Text('${context.watch<AppState>().tr('sent_to')} +91 ${_phoneCtrl.text}', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      const SizedBox(height: 32),
      // OTP boxes
      Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (i) => Container(
        width: 56, height: 64,
        margin: EdgeInsets.only(right: i < 3 ? 12 : 0),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: _otpCtrls[i].text.isNotEmpty ? AppColors.primary : AppColors.border,
            width: _otpCtrls[i].text.isNotEmpty ? 2 : 1.5,
          ),
          boxShadow: AppShadows.soft,
        ),
        child: TextField(
          controller: _otpCtrls[i],
          focusNode: _otpFocus[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            fillColor: Colors.transparent,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (v) {
            setState(() {});
            if (v.isNotEmpty && i < 3) _otpFocus[i + 1].requestFocus();
            if (v.isEmpty && i > 0) _otpFocus[i - 1].requestFocus();
          },
        ),
      ))),
      const SizedBox(height: 16),
      // Resend
      Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("${context.watch<AppState>().tr('didnt_receive')} ", style: const TextStyle(fontSize: 13, color: AppColors.caption)),
          GestureDetector(
            onTap: () {},
            child: Text(context.watch<AppState>().tr('resend_otp'), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
      const SizedBox(height: 8),
      // Demo hint
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: Text(context.watch<AppState>().tr('demo_hint'), style: const TextStyle(fontSize: 12, color: AppColors.caption)),
        ),
      ),
    ],
  );

  Widget _otpButton() => SizedBox(
    key: const ValueKey('otp_btn'),
    width: double.infinity, height: 56,
    child: ElevatedButton(
      onPressed: _otpCtrls.every((c) => c.text.isNotEmpty)
          ? () {
              final state = context.read<AppState>();
              state.login(_phoneCtrl.text);
              if (state.role == 'worker') {
                Navigator.pushReplacementNamed(context, '/skills');
              } else {
                Navigator.pushReplacementNamed(context, '/employer');
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _otpCtrls.every((c) => c.text.isNotEmpty) ? AppColors.primary : AppColors.border,
        foregroundColor: _otpCtrls.every((c) => c.text.isNotEmpty) ? Colors.white : AppColors.caption,
      ),
      child: Text(context.watch<AppState>().tr('verify')),
    ),
  );
}
