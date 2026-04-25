import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../providers/app_state.dart';

class EarningsWallet extends StatefulWidget {
  const EarningsWallet({super.key});
  @override
  State<EarningsWallet> createState() => _EarningsWalletState();
}

class _EarningsWalletState extends State<EarningsWallet> {
  String _period = '';

  final _transactions = [
    {'type': 'credit', 'title': 'Sri Ganesh Store', 'desc': 'Shop Assistant — 6 days', 'amount': '+ ₹3,600', 'date': 'Aug 12', 'icon': '🏪'},
    {'type': 'credit', 'title': 'Hotel Udupi Delights', 'desc': 'Kitchen Helper — 3 days', 'amount': '+ ₹1,500', 'date': 'Aug 10', 'icon': '🍳'},
    {'type': 'withdraw', 'title': 'UPI Transfer', 'desc': 'To SBI ••4521', 'amount': '- ₹4,000', 'date': 'Aug 8', 'icon': '🏧'},
    {'type': 'credit', 'title': 'QuickMart Grocery', 'desc': 'Delivery — 5 deliveries', 'amount': '+ ₹3,000', 'date': 'Aug 5', 'icon': '🚚'},
    {'type': 'bonus', 'title': 'Reliability Bonus', 'desc': '100% show-up rate reward', 'amount': '+ ₹500', 'date': 'Aug 1', 'icon': '🎉'},
    {'type': 'withdraw', 'title': 'UPI Transfer', 'desc': 'To SBI ••4521', 'amount': '- ₹5,000', 'date': 'Jul 28', 'icon': '🏧'},
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (_period.isEmpty) _period = state.tr('this_month');
    
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [_header(state), _balanceCard(state), _quickActions(state), _periodSelector(state), _earningsChart(state), _transactionList(state)],
      )),
      bottomNavigationBar: const WorkerNav(currentIndex: 2),
    );
  }

  Widget _header(AppState state) => Container(
    color: AppColors.card,
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(state.tr('earnings'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        Text(state.tr('earnings_wallet'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      ]),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: AppColors.moneyGreenLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.trending_up, size: 14, color: AppColors.moneyGreenDark),
          SizedBox(width: 4),
          Text('+23%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.moneyGreenDark)),
        ]),
      ),
    ]),
  );

  Widget _balanceCard(AppState state) => Container(
    margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E3A5F), Color(0xFF2D5986), Color(0xFF1E293B)]),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      boxShadow: [BoxShadow(color: const Color(0xFF1E3A5F).withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 8))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(state.tr('available_balance'), style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: AppColors.moneyGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.account_balance_wallet, size: 12, color: AppColors.moneyGreen),
            const SizedBox(width: 4),
            Text(state.tr('profile'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.moneyGreen)),
          ]),
        ),
      ]),
      const SizedBox(height: 8),
      const Text('₹18,400', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: -1)),
      const SizedBox(height: 4),
      Text(state.tr('total_earned_month'), style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
      const SizedBox(height: 20),
      // Withdraw button
      TapScale(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: AppColors.moneyGreen, borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: [BoxShadow(color: AppColors.moneyGreen.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))]),
          alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.account_balance, size: 16, color: Colors.white),
            const SizedBox(width: 8),
            Text(state.tr('withdraw'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
          ]),
        ),
      ),
    ]),
  );

  Widget _quickActions(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Row(children: [
      _action('💰', state.tr('pending'), '₹3,600', AppColors.warning),
      const SizedBox(width: 10),
      _action('📊', state.tr('this_week'), '₹5,100', AppColors.moneyGreen),
      const SizedBox(width: 10),
      _action('🏆', state.tr('show_up'), '₹500', AppColors.info),
    ]),
  );

  Widget _action(String emoji, String label, String value, Color accent) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border), boxShadow: AppShadows.soft),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: accent)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.caption)),
      ]),
    ),
  );

  Widget _periodSelector(AppState state) {
    final periods = [state.tr('this_week'), state.tr('this_month'), state.tr('all_time')];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(children: periods.map((p) {
        final active = _period == p;
        return Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: TapScale(
          onTap: () => setState(() => _period = p),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: active ? AppColors.moneyGreen : AppColors.card,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: active ? AppColors.moneyGreen : AppColors.border),
            ),
            alignment: Alignment.center,
            child: Text(p, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.textSecondary)),
          ),
        )));
      }).toList()),
    );
  }

  Widget _earningsChart(AppState state) => Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(state.tr('earnings_trend'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      const SizedBox(height: 16),
      SizedBox(height: 120, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        ...['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].asMap().entries.map((e) {
          final heights = [0.4, 0.6, 0.3, 0.8, 1.0, 0.5, 0.0];
          final isToday = e.key == 4;
          return Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 3), child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (isToday) Text('₹600', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.moneyGreen)),
            const SizedBox(height: 4),
            Container(
              height: 80 * heights[e.key],
              decoration: BoxDecoration(
                color: isToday ? AppColors.moneyGreen : AppColors.moneyGreen.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Text(e.value, style: TextStyle(fontSize: 10, fontWeight: isToday ? FontWeight.w500 : FontWeight.w500, color: isToday ? AppColors.moneyGreen : AppColors.caption)),
          ])));
        }),
      ])),
    ]),
  );

  Widget _transactionList(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(state.tr('transactions'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        GestureDetector(child: Text(state.tr('see_all'), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.moneyGreen))),
      ]),
      const SizedBox(height: 12),
      ..._transactions.map((t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
          child: Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: t['type'] == 'withdraw' ? AppColors.alert.withOpacity(0.1) : (t['type'] == 'bonus' ? AppColors.warning.withOpacity(0.1) : AppColors.moneyGreenLight),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              alignment: Alignment.center,
              child: Text(t['icon'] as String, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(t['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(t['amount'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                color: t['type'] == 'withdraw' ? AppColors.alert : AppColors.moneyGreen)),
              Text(t['date'] as String, style: const TextStyle(fontSize: 11, color: AppColors.caption)),
            ]),
          ]),
        ),
      )),
    ]),
  );
}
