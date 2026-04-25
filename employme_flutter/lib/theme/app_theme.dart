import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF2563EB); // Blue for actions
  static const primaryDark = Color(0xFF1D4ED8);
  static const primaryLight = Color(0xFFDBEAFE);
  static const moneyGreen = Color(0xFF16A34A); // Green for money
  static const moneyGreenLight = Color(0xFFDCFCE7);
  static const moneyGreenDark = Color(0xFF15803D);
  
  static const navy = Color(0xFF111827); 
  static const navyLight = Color(0xFF1F2937);
  static const navyLighter = Color(0xFF374151);
  static const alert = Color(0xFFEF4444); 
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);
  
  static const bg = Color(0xFFFAFAFA); 
  static const card = Color(0xFFFFFFFF);
  static const text = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const successLight = Color(0xFFDCFCE7);
  static const caption = Color(0xFF6B7280);
}

class AppShadows {
  static List<BoxShadow> get card => [];
  static List<BoxShadow> get cardHover => [
    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
  ];
  static List<BoxShadow> get elevated => [
    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
  ];
  static List<BoxShadow> get soft => [];
  static List<BoxShadow> primaryGlow(double opacity) => [];
}

// Consistent border radius tokens
class AppRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double pill = 100;
}

// Smooth page transition
class SlideUpRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  SlideUpRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: const Offset(0, 0.08), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            final fadeTween = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(opacity: animation.drive(fadeTween), child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
        );
}

// Tap feedback wrapper
class TapScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleDown;

  const TapScale({super.key, required this.child, this.onTap, this.scaleDown = 0.98});

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TapScale> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween(begin: 1.0, end: widget.scaleDown).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) { _controller.reverse(); widget.onTap?.call(); },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

class AppTheme {
  static ThemeData get lightTheme {
    final base = GoogleFonts.interTextTheme();
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.card,
        error: AppColors.alert,
      ),
      textTheme: base.copyWith(
        displayLarge: base.displayLarge?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontFamilyFallback: ['Roboto']),
        displayMedium: base.displayMedium?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontFamilyFallback: ['Roboto']),
        headlineLarge: base.headlineLarge?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontFamilyFallback: ['Roboto']),
        headlineMedium: base.headlineMedium?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontFamilyFallback: ['Roboto']),
        titleLarge: base.titleLarge?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontSize: 20, fontFamilyFallback: ['Roboto']),
        titleMedium: base.titleMedium?.copyWith(color: AppColors.text, fontWeight: FontWeight.w500, fontSize: 16, fontFamilyFallback: ['Roboto']),
        bodyLarge: base.bodyLarge?.copyWith(color: AppColors.text, fontSize: 15, height: 1.6, fontWeight: FontWeight.w400, fontFamilyFallback: ['Roboto']),
        bodyMedium: base.bodyMedium?.copyWith(color: AppColors.textSecondary, fontSize: 14, height: 1.6, fontWeight: FontWeight.w400, fontFamilyFallback: ['Roboto']),
        bodySmall: base.bodySmall?.copyWith(color: AppColors.caption, fontSize: 12, fontWeight: FontWeight.w400, fontFamilyFallback: ['Roboto']),
        labelLarge: base.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16, fontFamilyFallback: ['Roboto']),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.text,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.text),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          side: const BorderSide(color: AppColors.border, width: 1.0),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
          textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintStyle: GoogleFonts.inter(color: AppColors.caption, fontSize: 15, fontWeight: FontWeight.w400),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1, space: 0),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Colors.white : AppColors.caption),
        trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? AppColors.primary : AppColors.border),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.card,
        hourMinuteTextColor: AppColors.primary,
        dayPeriodTextColor: AppColors.primary,
        dialHandColor: AppColors.primary,
        dialBackgroundColor: AppColors.bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
        confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}

