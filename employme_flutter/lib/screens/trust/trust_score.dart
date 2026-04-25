import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';

class TrustScoreScreen extends StatefulWidget {
  const TrustScoreScreen({super.key});
  @override
  State<TrustScoreScreen> createState() => _TrustScoreScreenState();
}

class _TrustScoreScreenState extends State<TrustScoreScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _scoreAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _scoreAnim = Tween(begin: 0.0, end: 87.0).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() { _animCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
        _header(),
        _scoreHero(),
        _badgesRow(),
        _breakdown(),
        _improveSection(),
        _comparisonCard(),
      ])),
    );
  }

  Widget _header() => Container(
    color: AppColors.card,
    padding: const EdgeInsets.fromLTRB(16, 12, 20, 12),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle),
        child: const Icon(Icons.arrow_back, size: 20),
      )),
      const Expanded(child: Column(children: [
        Text('Trust Score', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Text('ನಂಬಿಕೆ ಅಂಕ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ])),
      const SizedBox(width: 38),
    ]),
  );

  Widget _scoreHero() => Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E3A5F), Color(0xFF2D5986), Color(0xFF1E293B)]),
      borderRadius: BorderRadius.circular(AppRadius.xl),
      boxShadow: [BoxShadow(color: const Color(0xFF1E3A5F).withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 8))],
    ),
    child: Column(children: [
      // Animated score arc
      AnimatedBuilder(
        animation: _scoreAnim,
        builder: (_, __) => SizedBox(
          width: 160, height: 100,
          child: CustomPaint(
            painter: _ScoreArcPainter(score: _scoreAnim.value, maxScore: 100),
            child: Center(child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('${_scoreAnim.value.toInt()}', style: const TextStyle(fontSize: 44, fontWeight: FontWeight.w500, color: Colors.white, height: 1)),
                Text('/ 100', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
              ]),
            )),
          ),
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(AppRadius.xl)),
        child: const Text('🛡️ Good Standing', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)),
      ),
      const SizedBox(height: 8),
      Text('Better score = More job offers & higher pay', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6), height: 1.4), textAlign: TextAlign.center),
    ]),
  );

  Widget _badgesRow() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Row(children: [
      _badge('📱', 'Phone\nVerified', true),
      const SizedBox(width: 8),
      _badge('👤', 'Profile\nComplete', true),
      const SizedBox(width: 8),
      _badge('👥', 'Community\nVerified', true),
      const SizedBox(width: 8),
      _badge('🏛️', 'NGO\nVerified', false),
    ]),
  );

  Widget _badge(String emoji, String label, bool done) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: done ? AppColors.primaryLight : AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: done ? AppColors.primary.withOpacity(0.3) : AppColors.border),
      ),
      child: Column(children: [
        Stack(alignment: Alignment.bottomRight, children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          if (done) Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.check, size: 8, color: Colors.white)),
        ]),
        const SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: done ? AppColors.primaryDark : AppColors.caption, height: 1.3)),
      ]),
    ),
  );

  Widget _breakdown() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Score Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      const SizedBox(height: 12),
      ...[
        {'title': 'Phone Verified', 'points': 25, 'max': 25, 'status': 'done', 'icon': '📱'},
        {'title': 'Profile Completed', 'points': 20, 'max': 20, 'status': 'done', 'icon': '👤'},
        {'title': 'Community Verified', 'points': 20, 'max': 20, 'status': 'done', 'icon': '👥'},
        {'title': 'First Job Done', 'points': 15, 'max': 15, 'status': 'done', 'icon': '✅'},
        {'title': 'Employer Reviews', 'points': 7, 'max': 10, 'status': 'partial', 'icon': '⭐'},
        {'title': 'NGO Ground Verification', 'points': 0, 'max': 10, 'status': 'pending', 'icon': '🏛️'},
      ].map((f) => _breakdownRow(f)),
    ]),
  );

  Widget _breakdownRow(Map<String, dynamic> f) {
    final done = f['status'] == 'done';
    final pending = f['status'] == 'pending';
    final progress = (f['points'] as int) / (f['max'] as int);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
      child: Column(children: [
        Row(children: [
          Text(f['icon'] as String, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(f['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ])),
          Text('${f['points']}/${f['max']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
            color: done ? AppColors.primary : (pending ? AppColors.warning : AppColors.textSecondary))),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation(done ? AppColors.primary : (pending ? AppColors.warning : AppColors.info)),
          ),
        ),
        if (pending) Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(width: double.infinity, height: 36, child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/ngo'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning, padding: EdgeInsets.zero, textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            child: const Text('Request Verification'),
          )),
        ),
      ]),
    );
  }

  Widget _improveSection() => Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      border: Border.all(color: AppColors.primary.withOpacity(0.2)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        Icon(Icons.trending_up, size: 18, color: AppColors.primaryDark),
        SizedBox(width: 6),
        Text('Improve Your Score', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
      ]),
      const SizedBox(height: 12),
      _improveTip('🏛️ Get NGO verified', '+10 pts', AppColors.warning),
      _improveTip('⭐ Complete 5 more jobs', '+5 pts', AppColors.info),
      _improveTip('📝 Get 3 more reviews', '+3 pts', AppColors.primary),
    ]),
  );

  Widget _improveTip(String text, String pts, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(AppRadius.xs)),
        child: Text(pts, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
      ),
    ]),
  );

  Widget _comparisonCard() => Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.lg), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('You vs Average', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      const SizedBox(height: 12),
      _comparisonBar('Your Score', 87, AppColors.primary),
      const SizedBox(height: 8),
      _comparisonBar('Area Average', 62, AppColors.caption),
      const SizedBox(height: 12),
      Center(child: Text('You are in the top 15% in your area! 🎉', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryDark))),
    ]),
  );

  Widget _comparisonBar(String label, int score, Color color) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
      Text('$score/100', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color)),
    ]),
    const SizedBox(height: 4),
    ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(value: score / 100, minHeight: 8, backgroundColor: AppColors.border, valueColor: AlwaysStoppedAnimation(color)),
    ),
  ]);
}

class _ScoreArcPainter extends CustomPainter {
  final double score;
  final double maxScore;
  _ScoreArcPainter({required this.score, required this.maxScore});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    // Background arc
    final bgPaint = Paint()..color = Colors.white.withOpacity(0.1)..style = PaintingStyle.stroke..strokeWidth = 10..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromCircle(center: center, radius: 70), startAngle, sweepAngle, false, bgPaint);

    // Score arc
    final progress = (score / maxScore).clamp(0.0, 1.0);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: const [Color(0xFFF97316), Color(0xFFFBBF24), Color(0xFF10B981)],
    );
    final scorePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 10..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: 70));
    canvas.drawArc(Rect.fromCircle(center: center, radius: 70), startAngle, sweepAngle * progress, false, scorePaint);
  }

  @override
  bool shouldRepaint(covariant _ScoreArcPainter old) => old.score != score;
}
