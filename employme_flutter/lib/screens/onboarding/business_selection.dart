import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class BusinessSelection extends StatefulWidget {
  const BusinessSelection({super.key});

  @override
  State<BusinessSelection> createState() => _BusinessSelectionState();
}

class _BusinessSelectionState extends State<BusinessSelection> {
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Construction', 'icon': Icons.architecture},
    {'name': 'Restaurant', 'icon': Icons.restaurant},
    {'name': 'Retail & Shop', 'icon': Icons.storefront},
    {'name': 'Logistics', 'icon': Icons.local_shipping},
    {'name': 'Manufacturing', 'icon': Icons.precision_manufacturing},
    {'name': 'Agency', 'icon': Icons.business},
    {'name': 'Healthcare', 'icon': Icons.local_hospital},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
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
              const Text('What is your business type?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.text)),
              const SizedBox(height: 6),
              const Text('Select the category that best describes your business.', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final active = _selectedCategory == cat['name'];
                  return TapScale(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() => _selectedCategory = cat['name']);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: active ? AppColors.primary : AppColors.border,
                          width: active ? 2 : 1.5,
                        ),
                        boxShadow: active ? AppShadows.primaryGlow(0.2) : AppShadows.soft,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'] as IconData, size: 32, color: active ? Colors.white : AppColors.primary),
                          const SizedBox(height: 12),
                          Text(cat['name'] as String, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: active ? Colors.white : AppColors.text,
                          ), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: _selectedCategory != null
                ? () {
                    // Navigate to Verification screen, passing the selected category
                    Navigator.pushNamed(context, '/employer-verification', arguments: _selectedCategory);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(state.tr('continue'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
