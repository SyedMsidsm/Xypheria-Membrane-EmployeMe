import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = ModalRoute.of(context)?.settings.arguments as String? ?? '99';
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Secure Payment', style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.navy,
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(children: [
          const Icon(Icons.lock_outline, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Completing your payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Amount to pay: ₹$amount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.navy)),
          const SizedBox(height: 40),
          _paymentOption('UPI (PhonePe, Google Pay)', Icons.account_balance_wallet, true),
          _paymentOption('Credit / Debit Card', Icons.credit_card, false),
          _paymentOption('Net Banking', Icons.account_balance, false),
          _paymentOption('Wallet', Icons.wallet, false),
        ]))),
        _bottomButton(context),
      ]),
    );
  }

  Widget _paymentOption(String title, IconData icon, bool selected) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 2 : 1)),
    child: Row(children: [
      Icon(icon, color: selected ? AppColors.primary : AppColors.textSecondary),
      const SizedBox(width: 16),
      Expanded(child: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.w500 : FontWeight.w500))),
      if (selected) const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
    ]),
  );

  Widget _bottomButton(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
    decoration: const BoxDecoration(color: AppColors.card, border: Border(top: BorderSide(color: AppColors.border))),
    child: SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Successful! Post boosted. 🎉')));
        Navigator.pop(context);
      },
      child: const Text('Pay Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))),
  );
}
