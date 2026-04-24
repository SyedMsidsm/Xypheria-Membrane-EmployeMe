import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/demo_data.dart';

class SkillsSelection extends StatelessWidget {
  const SkillsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border), boxShadow: AppShadows.soft),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
                child: Text('${state.selectedSkills.length} selected', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
              ),
            ]),
            const SizedBox(height: 24),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(value: 0.5, minHeight: 4, backgroundColor: AppColors.border, valueColor: AlwaysStoppedAnimation(AppColors.primary)),
            ),
            const SizedBox(height: 24),
            const Text('What can you do?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('ನೀವು ಏನು ಮಾಡಬಹುದು?', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            Text('Select your skills (${state.selectedSkills.length} selected)', style: const TextStyle(fontSize: 13, color: AppColors.caption)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.9,
                children: DemoData.skills.map((skill) {
                  final name = skill['name']!;
                  final active = state.selectedSkills.contains(name);
                  return TapScale(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      state.toggleSkill(name);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary.withOpacity(0.08) : AppColors.card,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: active ? AppColors.primary : AppColors.border, width: active ? 2 : 1),
                        boxShadow: active ? AppShadows.primaryGlow(0.08) : AppShadows.soft,
                      ),
                      child: Stack(children: [
                        Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(skill['emoji']!, style: const TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? AppColors.primaryDark : AppColors.text), textAlign: TextAlign.center),
                          Text(skill['kn']!, style: TextStyle(fontSize: 10, color: active ? AppColors.primaryDark.withOpacity(0.6) : AppColors.caption)),
                        ])),
                        if (active) Positioned(
                          top: 8, right: 8,
                          child: Container(
                            width: 18, height: 18,
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            child: const Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                onPressed: state.selectedSkills.isNotEmpty ? () => Navigator.pushNamed(context, '/location') : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.selectedSkills.isNotEmpty ? AppColors.primary : AppColors.border,
                  foregroundColor: state.selectedSkills.isNotEmpty ? Colors.white : AppColors.caption,
                ),
                child: Text('Continue with ${state.selectedSkills.length} skills'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
