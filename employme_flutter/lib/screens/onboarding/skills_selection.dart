import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/demo_data.dart';
import '../../services/localization_service.dart';

class SkillsSelection extends StatelessWidget {
  const SkillsSelection({super.key});

  IconData _getIconForSkill(String name) {
    switch (name) {
      case 'Cooking': return Icons.restaurant;
      case 'Cleaning': return Icons.cleaning_services;
      case 'Delivery': return Icons.local_shipping;
      case 'Shop Helper': return Icons.storefront;
      case 'Labour': return Icons.engineering;
      case 'Farming': return Icons.agriculture;
      case 'Childcare': return Icons.child_care;
      case 'Elder Care': return Icons.elderly;
      case 'Repair': return Icons.build;
      case 'Driving': return Icons.directions_car;
      case 'Beauty': return Icons.face_retouching_natural;
      case 'Packing': return Icons.inventory_2;
      case 'Security': return Icons.security;
      case 'Data Entry': return Icons.smartphone;
      case 'Painting': return Icons.format_paint;
      case 'Tailoring': return Icons.content_cut;
      case 'Other': return Icons.more_horiz;
      default: return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final lang = state.language;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back, size: 20, color: AppColors.text),
                ),
              ),
              const SizedBox(height: 20),
              Text(LocalizationService.translate('skills_title', lang), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
              const SizedBox(height: 6),
              Text(LocalizationService.translate('skills_subtitle', lang), style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              // Counter badge row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(LocalizationService.translate('skills_selected', lang, args: {'count': state.selectedSkills.where((s) => s != 'Other').length.toString()}),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ),
                  Text(LocalizationService.translate('max_skills', lang),
                    style: const TextStyle(fontSize: 12, color: AppColors.caption, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 24),

              // Skills Grid
              Builder(builder: (context) {
                    final allSkills = List<Map<String, String>>.from(DemoData.skills);
                    for (var skill in state.selectedSkills) {
                      if (skill == 'Other') continue;
                      if (!allSkills.any((s) => s['name'] == skill)) {
                        allSkills.add({'name': skill, 'kn': skill});
                      }
                    }

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      childAspectRatio: 0.85,
                      children: allSkills.map((skill) {
                        final nameKey = skill['name']!;
                        final active = state.selectedSkills.contains(nameKey);
                        return TapScale(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            state.toggleSkill(nameKey);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: active ? AppColors.primary : AppColors.card,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: active ? AppColors.primary : AppColors.border,
                                width: active ? 2 : 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_getIconForSkill(nameKey), size: 28, color: active ? Colors.white : AppColors.primary),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text(LocalizationService.translate(nameKey, lang), style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w700,
                                    color: active ? Colors.white : AppColors.text,
                                  ), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
      ),
      // Bottom fixed bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () => _showCustomSkillDialog(context, state),
            child: Text(LocalizationService.translate('cant_find_skill', lang),
              style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 56,
            child: ElevatedButton(
              onPressed: state.selectedSkills.where((s) => s != 'Other').isNotEmpty
                  ? () => Navigator.pushNamed(context, '/location')
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(LocalizationService.translate('continue', lang), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    );
  }

  void _showCustomSkillDialog(BuildContext context, AppState state) {
    final TextEditingController ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
        title: Text(state.tr('enter_custom_skill'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ctrl,
              decoration: InputDecoration(
                hintText: 'e.g. Carpentry',
                hintStyle: const TextStyle(color: AppColors.caption),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: const BorderSide(color: AppColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: const BorderSide(color: AppColors.primary)),
                filled: true,
                fillColor: AppColors.bg,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (ctrl.text.trim().isNotEmpty) {
                    state.toggleSkill(ctrl.text.trim());
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
                ),
                child: Text(state.tr('add'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(ctx), 
              child: Text(state.tr('cancel'), style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 15))
            ),
          ],
        ),
      ),
    );
  }
}
