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
        child: Column(children: [
          // Header — matches React's white header with border-bottom
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            decoration: const BoxDecoration(
              color: AppColors.card,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 22),
                ),
                const Text('Step 2 of 3', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 12),
              // 3-segment progress bar matching React
              Row(children: [
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: const LinearGradient(colors: [AppColors.primary, AppColors.border], stops: [0.6, 0.6]),
                ))),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
              ]),
            ]),
          ),

          // Title section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('What can you do?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text)),
              const SizedBox(height: 4),
              const Text('ನೀವು ಏನು ಮಾಡಬಲ್ಲಿರಿ?', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 6),
              const Text('Tap all that apply — no degree needed!', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              const Text('ಡಿಗ್ರಿ ಬೇಡ, ನಿಮ್ಮ ಕೌಶಲ್ಯ ಸಾಕು', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              // Counter badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${state.selectedSkills.length} skills selected',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
            ]),
          ),

          // Skills Grid — 4 columns matching React
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              childAspectRatio: 0.85,
              children: DemoData.skills.map((skill) {
                final name = skill['name']!;
                final active = state.selectedSkills.contains(name);
                return TapScale(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    state.toggleSkill(name);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      // React: selected fills solid green, unselected is white
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
                        Text(skill['emoji']!, style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 3),
                        Text(name, style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          color: active ? Colors.white : AppColors.text,
                        ), textAlign: TextAlign.center),
                        Text(skill['kn']!, style: TextStyle(
                          fontSize: 9,
                          color: active ? Colors.white.withOpacity(0.8) : AppColors.caption,
                        )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ),
      // Bottom fixed bar
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () => _showCustomSkillDialog(context, state),
            child: const Text("Can't find your skill? Add it +",
              style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 56,
            child: ElevatedButton(
              onPressed: state.selectedSkills.isNotEmpty
                  ? () => Navigator.pushNamed(context, '/location')
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Continue / ಮುಂದುವರಿಯಿರಿ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
        content: TextField(
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), 
            child: Text(state.tr('cancel'), style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600))
          ),
          ElevatedButton(
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
            child: Text(state.tr('add'), style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
