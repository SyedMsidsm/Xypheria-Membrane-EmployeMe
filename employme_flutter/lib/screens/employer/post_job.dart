import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../models/job_posting.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});
  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  final _titleController = TextEditingController(text: 'Shop Helper');
  final _payController = TextEditingController(text: '500');
  final _descController = TextEditingController(text: 'Help manage daily shop operations including customer service, billing, and shelf organization.');
  
  int _people = 2;
  bool _urgent = false;
  String _category = 'Retail & Shop';
  String _payPeriod = 'per day';
  String _selectedJobType = 'Part Time';
  String _fromTime = '9:00 AM';
  String _toTime = '6:00 PM';
  
  final List<String> _requirementsList = ['Kannada speaking', 'Physically fit'];
  final _reqController = TextEditingController();
  bool _isAddingReq = false;

  final List<String> _suggestedTitles = ['Shop Helper', 'Cook', 'Delivery', 'Cleaner'];
  final List<String> _categories = ['Retail & Shop', 'Restaurant', 'Delivery', 'Construction', 'Household', 'Security'];

  @override
  void dispose() {
    _titleController.dispose();
    _payController.dispose();
    _descController.dispose();
    _reqController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [_header(), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 100), child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionNum(1, 'Job Details'), _titleInput(), _categorySelector(), _peopleCounter(), _sectionNum(2, 'Pay & Timing'), _payInput(), _timeInputs(), _jobTypeToggles(), _description(), _requirements(), _urgency(),
      ]))))])),
      bottomNavigationBar: _bottom(),
    );
  }

  Widget _header() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16), child: Column(children: [
    Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)), child: const Icon(Icons.arrow_back, size: 20))),
      const Expanded(child: Text('Post a Job', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), const SizedBox(width: 38)]),
  ]));

  Widget _sectionNum(int n, String title) => Padding(padding: EdgeInsets.only(top: n == 1 ? 0 : 40, bottom: 20), child: Row(children: [
    Container(width: 24, height: 24, decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle), alignment: Alignment.center,
      child: Text('$n', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primaryDark))),
    const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))]));

  Widget _titleInput() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('Job Title *'), 
    TextFormField(controller: _titleController, decoration: const InputDecoration(hintText: 'e.g. Shop Helper')),
    const SizedBox(height: 12), 
    Wrap(spacing: 8, runSpacing: 8, children: _suggestedTitles.map((s) {
      final bool isActive = _titleController.text == s;
      return GestureDetector(
        onTap: () => setState(() => _titleController.text = s),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary.withOpacity(0.1) : AppColors.bg, 
            borderRadius: BorderRadius.circular(12), 
            border: Border.all(color: isActive ? AppColors.primary : AppColors.border, width: isActive ? 2 : 1)
          ),
          child: Text(s, style: TextStyle(fontSize: 13, color: isActive ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.w700))
        ),
      );
    }).toList()),
  ]);

  Widget _categorySelector() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SizedBox(height: 24), _label('Category *'),
    GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (ctx) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Select Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              ..._categories.map((c) => ListTile(
                title: Text(c, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: _category == c ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                onTap: () { setState(() => _category = c); Navigator.pop(ctx); },
              )),
            ]),
          ),
        );
      },
      child: Container(
        height: 56, padding: const EdgeInsets.symmetric(horizontal: 16), 
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(_category, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), 
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary)
        ])
      )
    )
  ]);

  Widget _peopleCounter() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 24), _label('Number of people needed'), const SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _counterBtn(Icons.remove, () { if (_people > 1) setState(() => _people--); }),
      SizedBox(width: 80, child: Text('$_people', textAlign: TextAlign.center, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800))),
      _counterBtn(Icons.add, () => setState(() => _people++)),
    ])]);

  Widget _counterBtn(IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(width: 56, height: 56, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border), color: AppColors.card), child: Icon(icon, size: 24)));

  Widget _payInput() => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), color: AppColors.card), 
    child: Row(children: [
      Container(width: 48, padding: const EdgeInsets.symmetric(vertical: 16), decoration: const BoxDecoration(color: AppColors.bg, border: Border(right: BorderSide(color: AppColors.border))),
        child: const Text('₹', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary))),
      Expanded(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16), 
        child: TextFormField(
          controller: _payController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
        )
      )),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12), 
        decoration: const BoxDecoration(color: AppColors.bg, border: Border(left: BorderSide(color: AppColors.border))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _payPeriod,
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w700, fontFamily: 'Inter'),
            onChanged: (v) => setState(() => _payPeriod = v!),
            items: ['per hour', 'per day', 'per month'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          ),
        ),
      ),
    ])
  );

  Widget _timeInputs() => Padding(padding: const EdgeInsets.only(top: 20), child: Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('From', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), const SizedBox(height: 8),
      GestureDetector(
        onTap: () async {
          final time = await showTimePicker(
            context: context, 
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input,
          );
          if (time != null) setState(() => _fromTime = time.format(context));
        },
        child: Container(height: 56, decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)), alignment: Alignment.center, child: Text(_fromTime, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)))
      )])),
    const SizedBox(width: 12),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('To', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)), const SizedBox(height: 8),
      GestureDetector(
        onTap: () async {
          final time = await showTimePicker(
            context: context, 
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input,
          );
          if (time != null) setState(() => _toTime = time.format(context));
        },
        child: Container(height: 56, decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)), alignment: Alignment.center, child: Text(_toTime, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)))
      )])),
  ]));

  Widget _jobTypeToggles() => Padding(padding: const EdgeInsets.only(top: 20), child: Container(decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
    child: Row(children: ['Full Time', 'Part Time', 'Daily Wage'].asMap().entries.map((e) {
      final bool isActive = _selectedJobType == e.value;
      return Expanded(child: GestureDetector(
        onTap: () => setState(() => _selectedJobType = e.value),
        child: Container(padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.green : AppColors.card, 
            border: e.key < 2 ? const Border(right: BorderSide(color: AppColors.border)) : null,
            borderRadius: BorderRadius.horizontal(
              left: e.key == 0 ? const Radius.circular(11) : Radius.zero,
              right: e.key == 2 ? const Radius.circular(11) : Radius.zero,
            )
          ),
          alignment: Alignment.center, 
          child: Text(e.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: isActive ? Colors.white : AppColors.textSecondary))
        ),
      ));
    }).toList())));

  Widget _description() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 32), _label('Describe the work'),
    TextFormField(controller: _descController, maxLines: 5, decoration: const InputDecoration()),
    const SizedBox(height: 8), Align(alignment: Alignment.centerRight, child: Text('${_descController.text.length}/300', style: const TextStyle(fontSize: 12, color: AppColors.caption))),
  ]);

  Widget _requirements() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 32), _label('What do you need? (optional)'), const SizedBox(height: 8),
    Wrap(spacing: 8, runSpacing: 8, children: [
      ..._requirementsList.map((r) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(r, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primaryDark)), 
          const SizedBox(width: 8), 
          GestureDetector(onTap: () => setState(() => _requirementsList.remove(r)), child: const Icon(Icons.close, size: 14, color: AppColors.primaryDark))
        ]))),
      if (_isAddingReq)
        SizedBox(width: 200, child: TextFormField(
          controller: _reqController,
          autofocus: true,
          decoration: InputDecoration(hintText: 'Type requirement...', isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
            suffixIcon: IconButton(icon: const Icon(Icons.check, size: 16), onPressed: () {
              if (_reqController.text.isNotEmpty) {
                setState(() { _requirementsList.add(_reqController.text); _reqController.clear(); _isAddingReq = false; });
              }
            })
          ),
          onFieldSubmitted: (v) {
            if (v.isNotEmpty) {
              setState(() { _requirementsList.add(v); _reqController.clear(); _isAddingReq = false; });
            }
          },
        ))
      else
        GestureDetector(
          onTap: () => setState(() => _isAddingReq = true),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border, style: BorderStyle.solid)),
            child: const Text('+ Add requirement', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w700)))
        ),
    ])]);

  Widget _urgency() => Container(margin: const EdgeInsets.only(top: 32), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
    child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Need someone urgently? ⚡', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4), const Text('Your job shows as 🔴 HIRING TODAY', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    ])), Switch(value: _urgent, onChanged: (v) => setState(() => _urgent = v), activeColor: AppColors.alert)]));

  Widget _bottom() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24), child: Row(children: [
    Expanded(child: SizedBox(height: 56, child: OutlinedButton(onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preview: ${_titleController.text} — ₹${_payController.text}/$_payPeriod'), duration: const Duration(seconds: 2)));
    }, style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Preview')))),
    const SizedBox(width: 12),
    Expanded(flex: 2, child: SizedBox(height: 56, child: ElevatedButton(onPressed: () {
      final state = context.read<AppState>();
      final newJob = JobPosting(
        title: _titleController.text,
        category: _category,
        pay: _payController.text,
        payPeriod: _payPeriod,
        timing: '$_fromTime - $_toTime',
        peopleNeeded: _people,
        type: _selectedJobType,
        description: _descController.text,
        requirements: List.from(_requirementsList),
        isUrgent: _urgent,
        postedAt: DateTime.now(),
      );
      
      state.addJobPosting(newJob);
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Job posted successfully!'), backgroundColor: AppColors.primary, duration: Duration(seconds: 2)));
      Future.delayed(const Duration(seconds: 1), () { if (mounted) Navigator.pop(context); });
    }, child: const Text('Post Job ✓')))),
  ]));

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)));
}
