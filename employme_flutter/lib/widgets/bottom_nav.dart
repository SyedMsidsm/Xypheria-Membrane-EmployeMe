import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/app_state.dart';

class WorkerNav extends StatelessWidget {
  final int currentIndex;
  const WorkerNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = [
      {'icon': Icons.home_rounded, 'activeIcon': Icons.home_rounded, 'label': state.tr('home'), 'route': '/home'},
      {'icon': Icons.map_outlined, 'activeIcon': Icons.map_rounded, 'label': state.tr('map'), 'route': '/map'},
      {'icon': Icons.work_outline_rounded, 'activeIcon': Icons.work_rounded, 'label': state.tr('my_jobs'), 'route': '/my-jobs'},
      {'icon': Icons.chat_outlined, 'activeIcon': Icons.chat_rounded, 'label': state.tr('chat'), 'route': '/messages'},
      {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': state.tr('profile'), 'route': '/worker-profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (i) {
            final item = items[i];
            final active = i == currentIndex;
            return _NavItem(
              icon: (active ? item['activeIcon'] : item['icon']) as IconData,
              label: item['label'] as String,
              active: active,
              badge: i == 3 ? 2 : 0,
              onTap: () {
                final currentRoute = ModalRoute.of(context)?.settings.name;
                if (currentRoute != item['route']) {
                  HapticFeedback.selectionClick();
                  Navigator.pushReplacementNamed(context, item['route'] as String);
                }
              },
            );
          })),
        ),
      ),
    );
  }
}

class EmployerNav extends StatelessWidget {
  final int currentIndex;
  const EmployerNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = [
      {'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard_rounded, 'label': state.tr('home'), 'route': '/employer'},
      {'icon': Icons.map_outlined, 'activeIcon': Icons.map_rounded, 'label': state.tr('workers'), 'route': '/map'},
      {'icon': Icons.add_circle_outline, 'activeIcon': Icons.add_circle_rounded, 'label': state.tr('post_job'), 'route': '/post-job'},
      {'icon': Icons.people_outline_rounded, 'activeIcon': Icons.people_rounded, 'label': state.tr('applicants'), 'route': '/applicants'},
      {'icon': Icons.person_outline_rounded, 'activeIcon': Icons.person_rounded, 'label': state.tr('profile'), 'route': '/worker-profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (i) {
            final item = items[i];
            final active = i == currentIndex;
            return _NavItem(
              icon: (active ? item['activeIcon'] : item['icon']) as IconData,
              label: item['label'] as String,
              active: active,
              onTap: () {
                final currentRoute = ModalRoute.of(context)?.settings.name;
                if (currentRoute != item['route']) {
                  HapticFeedback.selectionClick();
                  Navigator.pushReplacementNamed(context, item['route'] as String);
                }
              },
            );
          })),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final int badge;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.badge = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Thin line indicator above active tab
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: active ? 24 : 0,
            height: 2.5,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
              boxShadow: active ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 1))] : null,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 24, color: active ? AppColors.primary : AppColors.caption),
              if (badge > 0) Positioned(
                top: -4, right: -4,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColors.alert,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.card, width: 2),
                    boxShadow: [BoxShadow(color: AppColors.alert.withOpacity(0.4), blurRadius: 4)],
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  alignment: Alignment.center,
                  child: Text('$badge', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white, height: 1)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(
            fontSize: 10,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? AppColors.primary : AppColors.caption,
            letterSpacing: 0.2,
          )),
        ]),
      ),
    );
  }
}
