import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../services/demo_data.dart';
import '../../providers/app_state.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  String _search = '';

  List<Map<String, dynamic>> get _filtered {
    if (_search.isEmpty) return DemoData.chatList;
    return DemoData.chatList.where((c) => (c['name'] as String).toLowerCase().contains(_search.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(state),
          _searchBar(state),
          Expanded(child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
            itemCount: _filtered.length,
            separatorBuilder: (_, __) => const Divider(indent: 76, height: 0),
            itemBuilder: (_, i) => _chatItem(state, _filtered[i]),
          )),
        ]),
      ),
      bottomNavigationBar: const WorkerNav(currentIndex: 3),
    );
  }

  Widget _header(AppState state) => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
    color: AppColors.card,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(state.tr('messages'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
        child: Text('${DemoData.chatList.where((c) => (c['unread'] as int) > 0).length} ${state.tr('unread')}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
      ),
    ]),
  );

  Widget _searchBar(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
    child: Container(
      height: 44,
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        decoration: InputDecoration(
          hintText: state.tr('search_conversations'),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.caption),
          border: InputBorder.none, fillColor: Colors.transparent, filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );

  Widget _chatItem(AppState state, Map<String, dynamic> chat) {
    final unread = (chat['unread'] as int) > 0;
    return TapScale(
      onTap: () => Navigator.pushNamed(context, '/chat'),
      child: Container(
        color: unread ? AppColors.primaryLight.withOpacity(0.3) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(children: [
          Stack(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: unread ? AppColors.primary : AppColors.primaryLight, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(chat['initials'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: unread ? Colors.white : AppColors.primaryDark)),
            ),
            if (chat['verified'] == true) Positioned(
              bottom: 0, right: 0,
              child: Container(
                width: 16, height: 16,
                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: AppColors.card, width: 2)),
                child: const Icon(Icons.check, size: 10, color: Colors.white),
              ),
            ),
          ]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(chat['name'], style: TextStyle(fontSize: 15, fontWeight: unread ? FontWeight.w700 : FontWeight.w600, color: AppColors.text)),
              Text(chat['time'], style: TextStyle(fontSize: 12, color: unread ? AppColors.primary : AppColors.caption, fontWeight: unread ? FontWeight.w600 : FontWeight.w400)),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Expanded(child: Text(chat['lastMessage'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: unread ? AppColors.text : AppColors.textSecondary))),
              if (unread) ...[
                const SizedBox(width: 8),
                Container(
                  width: 20, height: 20,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text('${chat['unread']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ],
            ]),
            const SizedBox(height: 2),
            Text(chat['jobTitle'] ?? '', style: const TextStyle(fontSize: 11, color: AppColors.caption)),
          ])),
        ]),
      ),
    );
  }
}
