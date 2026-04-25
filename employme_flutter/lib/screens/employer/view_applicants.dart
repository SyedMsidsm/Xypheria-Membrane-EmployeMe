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
        _sortRow(), ...filtered.map((a) => _applicantCard(context, state, a)),
      ])))])),
      bottomNavigationBar: const EmployerNav(currentIndex: 3),
    );
  }

  Widget _header() => Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 16), child: Column(children: [
    Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 22)), const Expanded(child: Column(children: [Text('Applicants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)), Text('Shop Assistant — 47 applicants', style: TextStyle(fontSize: 13, color: AppColors.textSecondary))])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.local_fire_department, size: 12, color: Color(0xFFF97316)), const SizedBox(width: 4), const Text('High', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFFF97316)))]))]),
    const SizedBox(height: 12),
    SizedBox(height: 32, child: ListView(scrollDirection: Axis.horizontal, children: ['All (47)', 'New (12)', 'Invited (3)', 'Contacted (8)', 'Hired (2)'].map((t) {
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

  Widget _applicantCard(BuildContext context, AppState state, Map<String, dynamic> a) {
    final bool isInvited = a['status'] == 'Invited';

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 52, height: 52, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle), alignment: Alignment.center,
              child: Text(a['initial'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primaryDark))),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(a['name'], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                if (a['trustScore'] > 80) const Padding(padding: EdgeInsets.only(left: 6), child: Icon(Icons.verified, size: 16, color: AppColors.primary)),
              ]),
              const SizedBox(height: 6),
              Wrap(spacing: 4, children: (a['skills'] as List<String>).map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.check_circle, size: 10, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(s, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ]))).toList()),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.directions_walk, size: 14, color: AppColors.primary),
                const SizedBox(width: 4),
                Text('${a['distance']}', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
              ]),
              Row(children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFF59E0B)),
                const SizedBox(width: 4),
                Expanded(child: Text('${a['rating']} • ${a['jobsDone']} jobs • ${a['showUp']} show-up',
                  style: const TextStyle(fontSize: 11, color: AppColors.caption), overflow: TextOverflow.ellipsis)),
              ]),
            ])),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(flex: 3, child: SizedBox(height: 40, child: OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/chat', arguments: a['name']),
              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.chat_bubble_outline, size: 16), SizedBox(width: 6), Text('Message'),
              ])))),
            const SizedBox(width: 8),
            Expanded(flex: 3, child: SizedBox(height: 40, child: ElevatedButton(
              onPressed: isInvited ? null : () {
                state.inviteApplicant(a['name']);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      Text('Invitation sent to ${a['name']}!', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ]),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.send_rounded, size: 16, color: Colors.white),
                SizedBox(width: 6),
                Flexible(child: Text('Invite', style: TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis)),
              ])))),
          ]),
        ]),
      ),
    );
  }
}
