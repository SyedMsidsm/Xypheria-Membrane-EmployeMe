import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class JobCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String company;
  final String type;
  final String location;
  final String salary;
  final String period;
  final String? distance;
  final bool verified;
  final bool bookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onApply;
  final VoidCallback? onBookmark;

  const JobCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.company,
    this.type = '',
    this.location = '',
    required this.salary,
    required this.period,
    this.distance,
    this.verified = false,
    this.bookmarked = false,
    this.onTap,
    this.onApply,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.card,
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Emoji icon
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text))),
                  if (onBookmark != null)
                    GestureDetector(
                      onTap: onBookmark,
                      child: Icon(
                        bookmarked ? Icons.bookmark : Icons.bookmark_border,
                        size: 20,
                        color: bookmarked ? AppColors.primary : AppColors.caption,
                      ),
                    ),
                ]),
                const SizedBox(height: 2),
                Row(children: [
                  Text(company, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  if (verified) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)),
                      child: const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.check_circle, size: 10, color: AppColors.primaryDark),
                        SizedBox(width: 3),
                        Text('Verified', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
                      ]),
                    ),
                  ],
                ]),
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 4, children: [
                  if (type.isNotEmpty) _tag(type),
                  if (location.isNotEmpty) _tag(location),
                  if (distance != null) _distanceTag(distance!),
                ]),
              ])),
            ]),
          ),
          // Divider + salary row
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                Text(salary, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.text)),
                Text(period, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
              ]),
              if (onApply != null)
                TapScale(
                  onTap: onApply,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Text('Apply', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                  ),
                ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _tag(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.xs)),
    child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
  );

  Widget _distanceTag(String dist) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xs)),
    child: Text('🚶 $dist', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
  );
}
