import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class SMSFallback extends StatelessWidget {
  const SMSFallback({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 20), child: Column(children: [
        _header(state), _pyramid(), _impactStatement(), _phoneComparison(), _tagline(state),
      ]))));
  }

  Widget _header(AppState state) => Padding(padding: const EdgeInsets.all(20), child: Center(child: Text(state.tr('sms_works_everyone'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500))));

  Widget _pyramid() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(children: [
    // Tier 1 - Full App
    FractionallySizedBox(widthFactor: 0.7, child: Container(padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF16A34A)]), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: Column(children: [const Text('📱', style: TextStyle(fontSize: 24)),
        const Text('Full App Users', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
        Text('Smartphone + Internet', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        Text('Flutter App — Full Features', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6))),
      ]))),
    // Tier 2 - WhatsApp
    FractionallySizedBox(widthFactor: 0.85, child: Container(padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF25D366), Color(0xFF128C7E)])),
      child: Column(children: [const Text('💬', style: TextStyle(fontSize: 24)),
        const Text('WhatsApp Users', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
        Text('Basic smartphone', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        Text("Message 'JOBS' to get listings", style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6))),
        const SizedBox(height: 10),
        // Mock WhatsApp
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFECE5DD), borderRadius: BorderRadius.circular(10)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFDCF8C6), borderRadius: BorderRadius.circular(8)),
              child: const Text('JOBS KODIALBAIL COOK', style: TextStyle(fontSize: 11))),
            const SizedBox(height: 6),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('Found 3 cooking jobs near you:\n1. Hotel Udupi — ₹500/day — 8 min\nReply 1, 2, or 3 to apply', style: TextStyle(fontSize: 11, height: 1.5))),
          ])),
      ]))),
    // Tier 3 - SMS
    Container(padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)]), borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
      child: Column(children: [const Text('📨', style: TextStyle(fontSize: 24)),
        const Text('Feature Phone Users', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
        Text('Any phone, any network', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        Text("SMS 'WORK' to 56789", style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.6))),
        const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Send: WORK KODIALBAIL', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7))),
            const SizedBox(height: 4), const Text('Receive: 3 jobs near you.\n1.Shop Asst Rs500/day\nReply 1 to apply', style: TextStyle(fontSize: 11, color: Colors.white, height: 1.5)),
          ])),
      ])),
  ]));

  Widget _impactStatement() => Padding(padding: const EdgeInsets.all(20), child: Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary)),
    child: const Text('This means EmployMe reaches users that NO other job app can', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary), textAlign: TextAlign.center)));

  Widget _phoneComparison() => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
    Expanded(child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
      child: Column(children: [Container(width: 50, height: 80, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(8)),
        child: Center(child: Container(width: 30, height: 40, decoration: BoxDecoration(color: const Color(0xFF94A3B8), borderRadius: BorderRadius.circular(4))))),
        const SizedBox(height: 8), const Text('₹500 Phone', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4), const Text('✅ Can use EmployMe via SMS', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
      ]))),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center, child: const Text('E', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white)))),
    Expanded(child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
      child: Column(children: [Container(width: 50, height: 80, decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF374151), width: 2)),
        child: Center(child: Container(width: 36, height: 60, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.3), borderRadius: BorderRadius.circular(4))))),
        const SizedBox(height: 8), const Text('Smartphone', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4), const Text('✅ Full EmployMe app', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
      ]))),
  ]));

  Widget _tagline(AppState state) => Padding(padding: const EdgeInsets.all(24), child: Center(child: Text(state.tr('dont_leave_behind'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))));
}
