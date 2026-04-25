import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ImpactDashboard extends StatefulWidget {
  const ImpactDashboard({super.key});
  @override
  State<ImpactDashboard> createState() => _ImpactDashboardState();
}

class _ImpactDashboardState extends State<ImpactDashboard> with TickerProviderStateMixin {
  late AnimationController _countCtrl;
  late Animation<double> _countAnim;

  @override
  void initState() {
    super.initState();
    _countCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _countAnim = CurvedAnimation(parent: _countCtrl, curve: Curves.easeOutCubic);
    _countCtrl.forward();
  }

  @override
  void dispose() { _countCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 20), child: Column(children: [
        _topBar(),
        _heroMetric(),
        _statsGrid(),
        _liveMap(),
        _impactCategories(),
        _sdgCards(),
        _quote(),
        _logo(),
      ]))),
    );
  }

  Widget _topBar() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('EmployMe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: -0.5)),
        const SizedBox(height: 2),
        Text('Karnataka Pilot', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
      ]),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)),
          const SizedBox(width: 6),
          const Text('Live Impact Data', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
        ]),
      ),
    ]),
  );

  Widget _heroMetric() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
    child: AnimatedBuilder(
      animation: _countAnim,
      builder: (_, __) {
        final value = (_countAnim.value * 10247).toInt();
        return Column(children: [
          Text(_formatNumber(value), style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w500, color: Colors.white, height: 1)),
          const SizedBox(height: 8),
          const Text('Jobs Matched This Month', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary)),
          const SizedBox(height: 6),
          const Text('↑ 23% from last month', style: TextStyle(fontSize: 13, color: AppColors.primary)),
        ]);
      },
    ),
  );

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 0)},${(n % 1000).toString().padLeft(3, '0')}';
    return n.toString();
  }

  Widget _statsGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.2,
      children: [
        _statCard('3,842', 'Workers Registered', '↑ 847 new this week', AppColors.primary),
        _statCard('847', 'Businesses Active', '50+ joined today', AppColors.info),
        _statCard('4.2 min', 'Avg Match Time', '98% faster', AppColors.primary),
        _statCard('₹18.4L', 'Wages Facilitated', 'This month', AppColors.primary),
      ],
    ),
  );

  Widget _statCard(String value, String label, String sub, Color accent) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.06)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white)),
      const SizedBox(height: 4),
      Text(sub, style: TextStyle(fontSize: 13, color: accent)),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
      const Spacer(),
      // Mini chart bars matching React
      Row(children: [30, 45, 35, 55, 70, 60, 85].asMap().entries.map((e) => Expanded(
        child: Container(
          height: e.value * 0.3,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            color: e.key == 6 ? accent : accent.withOpacity(0.25),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      )).toList()),
    ]),
  );

  // Live map matching React with labeled dots
  Widget _liveMap() => Container(
    height: 180,
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.06)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CustomPaint(
        painter: _MapPainter(),
        child: Stack(children: [
          // Activity dots with labels matching React
          _mapDot(left: 120, top: 55, size: 16, label: 'Kodialbail'),
          _mapDot(left: 200, top: 45, size: 12, label: 'Hampankatta'),
          _mapDot(left: 80, top: 100, size: 8, label: 'Surathkal'),
          _mapDot(left: 250, top: 90, size: 14, label: 'City Centre'),
          _mapDot(left: 160, top: 120, size: 6),
          // Urgent pin
          Positioned(
            left: 150, top: 75,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.alert.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: const Text('🔴 3 urgent', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.alert)),
            ),
          ),
        ]),
      ),
    ),
  );

  Widget _mapDot({required double left, required double top, required double size, String? label}) => Positioned(
    left: left, top: top,
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: size, height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.8),
          boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8)]),
      ),
      if (label != null) ...[
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.6))),
      ],
    ]),
  );

  Widget _impactCategories() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Who We're Helping", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      const SizedBox(height: 10),
      Row(children: [
        _helpCard('👷', '2,841 Daily Workers'),
        const SizedBox(width: 8),
        _helpCard('👩', '847 Women'),
        const SizedBox(width: 8),
        _helpCard('🎓', '634 Students'),
      ]),
    ]),
  );

  Widget _helpCard(String icon, String label) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withOpacity(0.06)),
    ),
    child: Column(children: [
      Text(icon, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5)), textAlign: TextAlign.center),
    ]),
  ));

  Widget _sdgCards() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('UN Sustainable Development Goals', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.5))),
      const SizedBox(height: 8),
      Row(children: [
        _sdg(8, 'Decent Work', const Color(0xFF9E1B32)),
        const SizedBox(width: 8),
        _sdg(10, 'Reduced Inequalities', const Color(0xFFDD1367)),
        const SizedBox(width: 8),
        _sdg(1, 'No Poverty', const Color(0xFFE5243B)),
      ]),
    ]),
  );

  Widget _sdg(int num, String title, Color color) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: Column(children: [
      Text('$num', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
      const SizedBox(height: 2),
      Text(title, style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.8)), textAlign: TextAlign.center),
    ]),
  ));

  Widget _quote() => Container(
    margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(12),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        Positioned(
          left: 0, top: 0, bottom: 0,
          child: Container(width: 4, color: AppColors.primary),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const Text(
              '"For Raju and 500 million like him — their first digital job, just 8 minutes away."',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white, height: 1.6),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text('- Team EmployMe, MITE', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)), textAlign: TextAlign.center),
          ]),
        ),
      ],
    ),
  );

  Widget _logo() => Center(
    child: Text('EmployMe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.3), letterSpacing: -0.5)),
  );
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = Colors.white.withOpacity(0.08)..strokeWidth = 1;
    // Grid lines
    canvas.drawLine(Offset(40, 60), Offset(size.width - 40, 60), linePaint);
    canvas.drawLine(Offset(40, 100), Offset(size.width - 40, 100), linePaint);
    canvas.drawLine(const Offset(100, 20), Offset(100, size.height - 20), linePaint);
    canvas.drawLine(const Offset(200, 20), Offset(200, size.height - 20), linePaint);

    // Coast line
    final coastPaint = Paint()..color = AppColors.info.withOpacity(0.3)..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path()..moveTo(size.width - 40, 20)..cubicTo(size.width - 60, 60, size.width - 50, 100, size.width - 30, 150);
    canvas.drawPath(path, coastPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
