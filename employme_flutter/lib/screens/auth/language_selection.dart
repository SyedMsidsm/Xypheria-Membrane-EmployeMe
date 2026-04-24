import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/demo_data.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});
  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> with SingleTickerProviderStateMixin {
  String _selected = 'en';
  late AnimationController _ctrl;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeIn = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Progress
              Row(children: [
                Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: 0.25, minHeight: 4, backgroundColor: AppColors.border, valueColor: const AlwaysStoppedAnimation(AppColors.primary)))),
                const SizedBox(width: 12),
                const Text('1/4', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.caption)),
              ]),
              const SizedBox(height: 32),
              const Text('Choose your language', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text)),
              const SizedBox(height: 4),
              const Text('ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: DemoData.languages.map((lang) {
                    final active = _selected == lang['code'];
                    return TapScale(
                      onTap: () => setState(() => _selected = lang['code']!),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary.withOpacity(0.05) : AppColors.card,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(color: active ? AppColors.primary : AppColors.border, width: active ? 2 : 1.5),
                          boxShadow: active ? AppShadows.primaryGlow(0.08) : AppShadows.soft,
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(lang['script']!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: active ? AppColors.primary : AppColors.text)),
                          const SizedBox(height: 4),
                          Text(lang['name']!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: active ? AppColors.primaryDark : AppColors.textSecondary)),
                        ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AppState>().setLanguage(_selected);
                    Navigator.pushNamed(context, '/role');
                  },
                  child: const Text('Continue / ಮುಂದುವರಿಯಿರಿ'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
