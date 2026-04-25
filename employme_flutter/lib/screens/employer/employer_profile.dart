import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../widgets/bottom_nav.dart';

class EmployerProfile extends StatelessWidget {
  const EmployerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context, state),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _statsRow(state),
                    const SizedBox(height: 24),
                    _infoSection(context, state),
                    const SizedBox(height: 24),
                    _aboutSection(state),
                    const SizedBox(height: 32),
                    _logoutButton(context, state),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const EmployerNav(currentIndex: 4), // Assuming 4 is profile in EmployerNav
    );
  }

  Widget _header(BuildContext context, AppState state) => Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1E293B), Color(0xFF334155)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: const Icon(Icons.store, size: 50, color: Colors.white),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(state.tr('business_name'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: const Text('Verified Business', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );

  Widget _statsRow(AppState state) => Row(
    children: [
      _statItem('Jobs Posted', '${state.jobPostings.length}'),
      _statItem('Workers Hired', '12'),
      _statItem('Rating', '4.9 ★'),
    ],
  );

  Widget _statItem(String label, String value) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ]),
    ),
  );

  Widget _infoSection(BuildContext context, AppState state) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16),
      boxShadow: AppShadows.card,
      border: Border.all(color: AppColors.border),
    ),
    child: Column(children: [
      _infoRow(Icons.location_on_outlined, 'Location', 'Kodialbail, Mangalore'),
      const Divider(height: 32),
      _infoRow(Icons.phone_outlined, 'Phone', '+91 98765 43210'),
      const Divider(height: 32),
      _infoRow(Icons.email_outlined, 'Email', 'contact@xypheria.com'),
    ]),
  );

  Widget _infoRow(IconData icon, String label, String value) => Row(children: [
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, size: 20, color: AppColors.textSecondary),
    ),
    const SizedBox(width: 16),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
    ])),
  ]);

  Widget _aboutSection(AppState state) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('About the Business', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: const Text(
          'Xypheria Retail is a leading local business in Mangalore specializing in high-quality retail services and delivery. We pride ourselves on creating a great work environment for our helpers.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
        ),
      ),
    ],
  );

  Widget _logoutButton(BuildContext context, AppState state) => SizedBox(
    width: double.infinity,
    child: TextButton.icon(
      onPressed: () => Navigator.pushReplacementNamed(context, '/role-selection'),
      icon: const Icon(Icons.logout, size: 20, color: AppColors.alert),
      label: const Text('Logout Business Account', style: TextStyle(color: AppColors.alert, fontWeight: FontWeight.w700)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.alert.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
