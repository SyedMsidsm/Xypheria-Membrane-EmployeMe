import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SkillChip extends StatelessWidget {
  final String emoji;
  final String name;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const SkillChip({
    super.key,
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 3),
            Text(
              name,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: selected ? Colors.white : AppColors.text),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 9, color: selected ? Colors.white.withOpacity(0.8) : AppColors.caption),
            ),
          ],
        ),
      ),
    );
  }
}
