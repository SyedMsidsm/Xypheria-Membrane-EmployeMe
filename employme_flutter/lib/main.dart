import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'providers/app_state.dart';

// Auth
import 'screens/auth/splash_screen.dart';
import 'screens/auth/language_selection.dart';
import 'screens/auth/role_selection.dart';
import 'screens/auth/phone_entry.dart';

// Onboarding
import 'screens/onboarding/skills_selection.dart';
import 'screens/onboarding/location_availability.dart';
import 'screens/onboarding/worker_profile_setup.dart';
import 'screens/onboarding/business_selection.dart';
import 'screens/onboarding/business_verification.dart';

// Worker
import 'screens/worker/job_feed.dart';
import 'screens/worker/job_search.dart';
import 'screens/worker/job_detail.dart';
import 'screens/worker/quick_apply.dart';
import 'screens/worker/my_jobs.dart';
import 'screens/worker/worker_profile_page.dart';
import 'screens/worker/edit_profile.dart';
import 'screens/worker/notifications.dart';
import 'screens/worker/nearby_jobs_map.dart';
import 'screens/worker/earnings_wallet.dart';

// Employer
import 'screens/employer/employer_dashboard.dart';
import 'screens/employer/post_job.dart';
import 'screens/employer/view_applicants.dart';
import 'screens/employer/employer_reviews.dart';
import 'screens/employer/employer_analytics.dart';
import 'screens/employer/payment_page.dart';
import 'screens/employer/view_all_jobs.dart';
import 'screens/employer/employer_profile.dart';

// Chat
import 'screens/chat/chat_list.dart';
import 'screens/chat/chat_screen.dart';

// Trust
import 'screens/trust/trust_score.dart';
import 'screens/trust/ngo_verification.dart';

// Demo
import 'screens/demo/impact_dashboard.dart';
import 'screens/demo/feature_highlights.dart';
import 'screens/demo/sms_fallback.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const EmployMeApp(),
    ),
  );
}

class EmployMeApp extends StatelessWidget {
  const EmployMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmployMe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      builder: (context, child) {
        final isNarrow = MediaQuery.of(context).size.width <= 500;
        if (isNarrow) return child!;
        return Container(
          color: const Color(0xFF0F172A),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 40),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
          ),
        );
      },
      routes: {
        // Auth Flow
        '/': (_) => const SplashScreen(),
        '/language': (_) => const LanguageSelection(),
        '/role': (_) => const RoleSelection(),
        '/phone': (_) => const PhoneEntry(),

        // Onboarding Flow
        '/skills': (_) => const SkillsSelection(),
        '/location': (_) => const LocationAvailability(),
        '/profile-setup': (_) => const WorkerProfileSetup(),
        '/employer-business-type': (_) => const BusinessSelection(),
        '/employer-verification': (_) => const BusinessVerification(),

        // Worker Flow
        '/worker-home': (_) => const JobFeed(),
        '/search': (_) => const JobSearch(),
        '/map': (_) => const NearbyJobsMap(),
        '/job-detail': (_) => const JobDetail(),
        '/apply': (_) => const QuickApply(),
        '/my-jobs': (_) => const MyJobs(),
        '/earnings': (_) => const EarningsWallet(),
        '/worker-profile': (_) => const WorkerProfilePage(),
        '/edit-profile': (_) => const EditProfilePage(),
        '/notifications': (_) => const NotificationsScreen(),

        // Employer Flow
        '/employer-home': (_) => const EmployerDashboard(),
        '/post-job': (_) => const PostJob(),
        '/applicants': (_) => const ViewApplicants(),
        '/reviews': (_) => const EmployerReviews(),
        '/analytics': (_) => const EmployerAnalytics(),
        '/payment': (_) => const PaymentPage(),
        '/view-all-jobs': (_) => const ViewAllJobs(),
        '/employer-profile': (_) => const EmployerProfile(),

        // Chat Flow
        '/messages': (_) => const ChatList(),
        '/chat': (_) => const ChatScreen(),

        // Trust Flow
        '/trust': (_) => const TrustScoreScreen(),
        '/ngo': (_) => const NGOVerification(),

        // Demo Flow
        '/impact': (_) => const ImpactDashboard(),
        '/features': (_) => const FeatureHighlights(),
        '/sms': (_) => const SMSFallback(),
      },
    );
  }
}
