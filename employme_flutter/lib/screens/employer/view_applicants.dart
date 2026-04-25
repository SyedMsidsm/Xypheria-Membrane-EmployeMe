import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class ViewApplicants extends StatefulWidget {
  const ViewApplicants({super.key});
  @override
  State<ViewApplicants> createState() => _ViewApplicantsState();
}

class _ViewApplicantsState extends State<ViewApplicants> {
  String _tab = 'All';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final filtered = _tab == 'All' 
        ? state.applicants 
        : state.applicants.where((a) => a['status'] == _tab).toList();

    return Scaffold(backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [_header(), Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 120), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sortRow(), ...filtered.map(_applicantCard),
      ])))])),
      bottomNavigationBar: const EmployerNav(currentIndex: 2),
    );
  }

  Widget _header() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16), child: Column(children: [
    Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 22)), const Expanded(child: Column(children: [Text('Applicants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)), Text('Shop Assistant — 47 applicants', style: TextStyle(fontSize: 13, color: AppColors.textSecondary))])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.local_fire_department, size: 12, color: Color(0xFFF97316)), const SizedBox(width: 4), const Text('High', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFFF97316)))]))]),
    const SizedBox(height: 12),
    SizedBox(height: 32, child: ListView(scrollDirection: Axis.horizontal, children: ['All (47)', 'New (12)', 'Shortlisted (5)', 'Contacted (8)', 'Hired (2)'].map((t) {
      final id = t.split(' ')[0]; final active = _tab == id;
      return Padding(padding: const EdgeInsets.only(right: 6), child: GestureDetector(onTap: () => setState(() => _tab = id),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: active ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(20), border: active ? null : Border.all(color: AppColors.border)),
          child: Text(t, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.textSecondary)))));
    }).toList())),
  ]));

  Widget _sortRow() => Padding(padding: const EdgeInsets.fromLTRB(20, 12, 20, 0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    const Row(children: [Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)), SizedBox(width: 6), Text('Top Matches for You', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))]),
    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: const Text('Sort: Distance ▼', style: TextStyle(fontSize: 11, color: AppColors.textSecondary))),
  ]));

  Widget _applicantCard(Map<String, dynamic> a) {
    final bool isBest = a['bestMatch'] as bool;
    final bool isShortlisted = a['status'] == 'Shortlisted';
    
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: isShortlisted ? AppColors.navyLighter.withOpacity(0.5) : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isShortlisted ? null : [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
        border: isShortlisted ? Border.all(color: AppColors.border) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (isBest)
            Positioned(
              left: 0, top: 0, bottom: 0,
              child: Container(width: 4, color: const Color(0xFFD97706)),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                if (isShortlisted) 
                  const Text('shortlisted', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.caption, fontStyle: FontStyle.italic)),
                if (!isShortlisted && a['bestMatch'] as bool) 
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(10)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star, size: 12, color: Color(0xFFD97706)), const SizedBox(width: 4), const Text('BEST MATCH', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFFD97706)))]))
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Container(width: 52, height: 52, decoration: BoxDecoration(shape: BoxShape.circle, color: isShortlisted ? AppColors.caption : (a['bestMatch'] as bool ? AppColors.primary : AppColors.info)),
                  alignment: Alignment.center, child: Text(a['initial'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(a['name'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isShortlisted ? AppColors.textSecondary : AppColors.text)),
                  const SizedBox(height: 4), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: isShortlisted ? AppColors.border : AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.shield, size: 12, color: isShortlisted ? AppColors.caption : AppColors.primary), const SizedBox(width: 4), Text('${a['trustScore']}/100', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: isShortlisted ? AppColors.caption : AppColors.primary))])),
                  const SizedBox(height: 6), Wrap(spacing: 4, children: (a['skills'] as List<String>).map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: isShortlisted ? AppColors.border : AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_circle, size: 10, color: isShortlisted ? AppColors.caption : AppColors.primary), const SizedBox(width: 4), Text(s, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isShortlisted ? AppColors.caption : AppColors.primary))]))).toList()),
                  const SizedBox(height: 4), Row(children: [Icon(Icons.directions_walk, size: 14, color: isShortlisted ? AppColors.caption : AppColors.primary), const SizedBox(width: 4), Text('${a['distance']}', style: TextStyle(fontSize: 12, color: isShortlisted ? AppColors.caption : AppColors.primary, fontWeight: FontWeight.w600))]),
                  Row(children: [
                    const Icon(Icons.star, size: 14, color: Color(0xFFF59E0B)), 
                    const SizedBox(width: 4), 
                    Expanded(child: Text('${a['rating']} • ${a['jobsDone']} jobs • ${a['showUp']} show-up', style: const TextStyle(fontSize: 11, color: AppColors.caption), overflow: TextOverflow.ellipsis)),
                  ]),
                ])),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(flex: 3, child: SizedBox(height: 40, child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/chat', arguments: a['name']), 
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.chat_bubble_outline, size: 16), SizedBox(width: 6), Text('Message')])))),
                const SizedBox(width: 8),
                Expanded(flex: 3, child: SizedBox(height: 40, child: ElevatedButton(
                  onPressed: isShortlisted ? null : () => context.read<AppState>().shortlistApplicant(a['name']), 
                  style: ElevatedButton.styleFrom(backgroundColor: isShortlisted ? AppColors.border : AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(isShortlisted ? Icons.check_circle : Icons.check_circle_outline, size: 16, color: Colors.white), 
                    const SizedBox(width: 6), 
                    Flexible(child: Text(isShortlisted ? 'Shortlisted' : 'Shortlist', style: const TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis))
                  ])))),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}
