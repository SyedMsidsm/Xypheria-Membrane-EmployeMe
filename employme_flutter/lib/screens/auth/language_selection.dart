import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/demo_data.dart';
import '../../services/localization_service.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});
  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> with SingleTickerProviderStateMixin {
  String _selected = 'kn'; // React defaults to Kannada
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
          child: Column(children: [
            // Header with logo + progress dots
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(children: [
                // Logo row
                Row(children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.handshake_rounded, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text('EmployMe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text)),
                ]),
                // Progress dots
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 2), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.border)),
                  const SizedBox(width: 8),
                  Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 2), decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.border)),
                ]),
              ]),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
              child: Column(children: [
                Text(LocalizationService.translate('choose_language', _selected), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.text), textAlign: TextAlign.center),
                const SizedBox(height: 6),
                Text(LocalizationService.translate('choose_language_subtitle', _selected), style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
              ]),
            ),

            // Language Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                childAspectRatio: 1.8,
                children: DemoData.languages.map((lang) {
                  final active = _selected == lang['code'];
                  return TapScale(
                    onTap: () => setState(() => _selected = lang['code']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primaryLight : AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: active ? AppColors.primary : AppColors.border, width: active ? 2 : 1),
                      ),
                      child: Stack(children: [
                        Center(child: Text(lang['script']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: active ? AppColors.primaryDark : AppColors.text))),
                        // Checkmark in top-right
                        Positioned(top: 8, right: 8, child: Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active ? AppColors.primary : Colors.transparent,
                            border: Border.all(color: active ? AppColors.primary : AppColors.border, width: 2),
                          ),
                          child: active ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                        )),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(children: [
                Text(LocalizationService.translate('more_coming_soon', _selected), style: const TextStyle(fontSize: 13, color: AppColors.caption, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AppState>().setLanguage(_selected);
                      Navigator.pushNamed(context, '/role');
                    },
                    child: Text(LocalizationService.translate('continue', _selected), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
