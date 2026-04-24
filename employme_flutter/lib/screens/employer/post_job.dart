import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});
  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  int _people = 2;
  bool _urgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [_header(), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 100), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionNum(1, 'Job Details'), _titleInput(), _category(), _peopleCounter(), _sectionNum(2, 'Pay & Timing'), _payInput(), _timeInputs(), _jobType(), _description(), _requirements(), _urgency(),
      ]))))])),
      bottomNavigationBar: _bottom(),
    );
  }

  Widget _header() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16), child: Column(children: [
    Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)), child: const Icon(Icons.arrow_back, size: 20))),
      const Expanded(child: Text('Post a Job', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), const SizedBox(width: 38)]),
    const SizedBox(height: 16),
    Row(children: [const Text('Step 1 of 2', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), const SizedBox(width: 12),
      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
        child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: 0.5, child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))))))]),
  ]));

  Widget _sectionNum(int n, String title) => Padding(padding: EdgeInsets.only(top: n == 1 ? 0 : 40, bottom: 20), child: Row(children: [
    Container(width: 24, height: 24, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), alignment: Alignment.center,
      child: Text('$n', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primaryDark))),
    const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))]));

  Widget _titleInput() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('Job Title *'), TextFormField(decoration: const InputDecoration(hintText: 'e.g. Shop Helper')),
    const SizedBox(height: 12), Wrap(spacing: 8, children: ['Shop Helper', 'Cook', 'Delivery', 'Cleaner'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Text(s, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600)))).toList()),
  ]);

  Widget _category() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 24), _label('Category *'),
    Container(height: 56, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Retail & Shop', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), Text('▼', style: TextStyle(color: AppColors.textSecondary))]))]);

  Widget _peopleCounter() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 24), _label('Number of people needed'), const SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _counterBtn(Icons.remove, () { if (_people > 1) setState(() => _people--); }),
      SizedBox(width: 80, child: Text('$_people', textAlign: TextAlign.center, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800))),
      _counterBtn(Icons.add, () => setState(() => _people++)),
    ])]);

  Widget _counterBtn(IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(width: 56, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border), color: AppColors.card), child: Icon(icon, size: 24)));

  Widget _payInput() => Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), color: AppColors.card), child: Row(children: [
    Container(width: 48, padding: const EdgeInsets.symmetric(vertical: 16), decoration: const BoxDecoration(color: AppColors.bg, border: Border(right: BorderSide(color: AppColors.border))),
      child: const Text('₹', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary))),
    const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)))),
    Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), decoration: const BoxDecoration(color: AppColors.bg, border: Border(left: BorderSide(color: AppColors.border))),
      child: const Text('per day ▼', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
  ]));

  Widget _timeInputs() => Padding(padding: const EdgeInsets.only(top: 20), child: Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('From', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), const SizedBox(height: 8),
      Container(height: 56, decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)), alignment: Alignment.center, child: const Text('9:00 AM', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)))])),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('To', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), const SizedBox(height: 8),
      Container(height: 56, decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)), alignment: Alignment.center, child: const Text('6:00 PM', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)))])),
  ]));

  Widget _jobType() => Padding(padding: const EdgeInsets.only(top: 20), child: Container(decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
    child: Row(children: ['Full Time', 'Part Time', 'Daily Wage'].asMap().entries.map((e) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: e.key == 1 ? AppColors.primary : AppColors.card, border: e.key < 2 ? const Border(right: BorderSide(color: AppColors.border)) : null),
      alignment: Alignment.center, child: Text(e.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: e.key == 1 ? Colors.white : AppColors.textSecondary))))).toList())));

  Widget _description() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 32), _label('Describe the work'),
    TextFormField(maxLines: 5, initialValue: 'Help manage daily shop operations including customer service, billing, and shelf organization.', decoration: const InputDecoration()),
    const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), color: AppColors.bg),
        child: const Text('✨ Generate Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary))),
      const Text('47/300', style: TextStyle(fontSize: 12, color: AppColors.caption)),
    ])]);

  Widget _requirements() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 32), _label('What do you need? (optional)'), const SizedBox(height: 4),
    Wrap(spacing: 8, runSpacing: 8, children: [
      ...['Kannada speaking', 'Physically fit'].map((r) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Text(r, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)), const SizedBox(width: 6), const Text('×', style: TextStyle(fontSize: 16, color: AppColors.primaryDark))]))),
      Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border, style: BorderStyle.solid)),
        child: const Text('+ Add requirement', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w600))),
    ])]);

  Widget _urgency() => Container(margin: const EdgeInsets.only(top: 32), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
    child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Need someone urgently? ⚡', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4), const Text('Your job shows as 🔴 HIRING TODAY', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    ])), Switch(value: _urgent, onChanged: (v) => setState(() => _urgent = v), activeColor: AppColors.alert)]));

  Widget _bottom() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24), child: Row(children: [
    Expanded(child: SizedBox(height: 56, child: OutlinedButton(onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preview: Shop Assistant — ₹500/day'), duration: Duration(seconds: 2)));
    }, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Preview')))),
    const SizedBox(width: 12),
    Expanded(flex: 2, child: SizedBox(height: 56, child: ElevatedButton(onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Job posted successfully!'), backgroundColor: AppColors.primary, duration: Duration(seconds: 2)));
      Future.delayed(const Duration(seconds: 1), () { if (mounted) Navigator.pop(context); });
    }, child: const Text('Post Job ✓')))),
  ]));

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)));
}
