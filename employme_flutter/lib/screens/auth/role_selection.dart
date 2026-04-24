import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({super.key});
  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
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
              const Text('Step 1 of 4', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
            ]),
            const SizedBox(height: 32),
            const Text('I am a...', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text)),
            const SizedBox(height: 4),
            const Text('ನಾನು ಒಬ್ಬ...', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            _roleCard(
              id: 'worker',
              emoji: '👷',
              title: 'Worker',
              subtitle: 'ಕೆಲಸಗಾರ',
              desc: 'I want to find jobs near me',
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            _roleCard(
              id: 'employer',
              emoji: '🏢',
              title: 'Employer',
              subtitle: 'ಉದ್ಯೋಗದಾತ',
              desc: 'I want to hire workers',
              color: AppColors.info,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selected != null ? () {
                  context.read<AppState>().setRole(_selected!);
                  Navigator.pushNamed(context, '/phone');
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selected != null ? AppColors.primary : AppColors.border,
                  foregroundColor: _selected != null ? Colors.white : AppColors.caption,
                  elevation: 0,
                ),
                child: const Text('Continue / ಮುಂದುವರಿಯಿರಿ'),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _roleCard({required String id, required String emoji, required String title, required String subtitle, required String desc, required Color color}) {
    final isSelected = _selected == id;
    return TapScale(
      onTap: () => setState(() => _selected = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.05) : AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: isSelected ? color : AppColors.border, width: isSelected ? 2 : 1.5),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 4))] : AppShadows.soft,
        ),
        child: Row(children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              gradient: isSelected ? LinearGradient(colors: [color.withOpacity(0.15), color.withOpacity(0.05)]) : null,
              color: isSelected ? null : AppColors.bg,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: isSelected ? color : AppColors.text)),
              const SizedBox(width: 6),
              Text(subtitle, style: TextStyle(fontSize: 13, color: isSelected ? color.withOpacity(0.7) : AppColors.caption)),
            ]),
            const SizedBox(height: 4),
            Text(desc, style: TextStyle(fontSize: 14, color: isSelected ? color.withOpacity(0.8) : AppColors.textSecondary)),
          ])),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24, height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? color : Colors.transparent,
              border: Border.all(color: isSelected ? color : AppColors.border, width: 2),
            ),
            child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
          ),
        ]),
      ),
    );
  }
}
