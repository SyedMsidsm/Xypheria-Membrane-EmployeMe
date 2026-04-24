import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../services/demo_data.dart';
import '../../providers/app_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [_header(context.watch<AppState>()), Expanded(child: ListView(padding: const EdgeInsets.only(bottom: 16), children: [
        _groupLabel('Today'),
        ...DemoData.notifications.where((n) => n['group'] == 'Today').map(_notifCard),
        _groupLabel('Yesterday'),
        ...DemoData.notifications.where((n) => n['group'] == 'Yesterday').map(_notifCard),
        Padding(padding: const EdgeInsets.all(16), child: Center(child: Text(context.watch<AppState>().tr('more_coming_soon'), style: const TextStyle(fontSize: 13, color: AppColors.caption)))),
      ]))])),
      bottomNavigationBar: const WorkerNav(currentIndex: 0),
    );
  }

  Widget _header(AppState state) => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(state.tr('notifications'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      GestureDetector(onTap: () => state.markAllRead(), child: Text(state.tr('mark_all_read'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))),
    ]),
    const SizedBox(height: 12),
    SizedBox(height: 32, child: ListView(scrollDirection: Axis.horizontal, children: ['All', 'Jobs', 'Messages', 'System'].map((f) => Padding(padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(onTap: () => setState(() => _filter = f), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(
        color: _filter == f ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(20), border: _filter == f ? null : Border.all(color: AppColors.border)),
        child: Text(f, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _filter == f ? Colors.white : AppColors.textSecondary)))))).toList())),
  ]));

  Widget _groupLabel(String label) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
    child: Text(label.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.caption, letterSpacing: 1)));

  Widget _notifCard(Map<String, dynamic> n) {
    Color bg = AppColors.card; Color? borderColor;
    if (n['type'] == 'urgent') { bg = AppColors.primaryLight; borderColor = AppColors.alert; }
    else if (n['type'] == 'offer') bg = AppColors.primaryLight;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: borderColor == null ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)] : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (borderColor != null)
            Positioned(
              left: 0, top: 0, bottom: 0,
              child: Container(width: 4, color: borderColor),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.bg.withOpacity(0.5)), alignment: Alignment.center, child: Text(n['icon'] as String, style: const TextStyle(fontSize: 16))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(n['title'] as String, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: n['type'] == 'urgent' ? AppColors.alert : (n['type'] == 'offer' ? AppColors.primary : AppColors.text))),
                const SizedBox(height: 4), Text(n['body'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                const SizedBox(height: 4), Text(n['time'] as String, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
              ])),
            ])),
        ],
      ),
    );
  }
}
