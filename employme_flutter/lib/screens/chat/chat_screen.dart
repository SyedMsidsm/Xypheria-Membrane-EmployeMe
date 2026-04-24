import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hi! I saw your profile. We have an opening for Shop Assistant.', 'isMe': false, 'time': '10:30 AM'},
    {'text': 'Thank you! I am interested. What are the timings?', 'isMe': true, 'time': '10:32 AM'},
    {'text': 'Morning 9 AM to 6 PM, 6 days a week. Salary is ₹12,000/month.', 'isMe': false, 'time': '10:33 AM'},
    {'text': 'That sounds good! When can I start?', 'isMe': true, 'time': '10:35 AM'},
    {'type': 'offer', 'title': '🎉 Job Offer', 'job': 'Shop Assistant', 'salary': '₹12,000/mo', 'company': 'Sri Ganesh Store', 'isMe': false, 'time': '10:36 AM'},
  ];

  @override
  void dispose() { _msgCtrl.dispose(); _scrollCtrl.dispose(); super.dispose(); }

  void _send() {
    if (_msgCtrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _msgCtrl.text.trim(), 'isMe': true, 'time': 'Now'});
    });
    _msgCtrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(),
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                if (msg['type'] == 'offer') return _offerCard(msg);
                return _bubble(msg);
              },
            ),
          ),
          _quickReplies(),
          _inputBar(),
        ]),
      ),
    );
  }

  Widget _header() => Container(
    padding: const EdgeInsets.fromLTRB(6, 8, 16, 8),
    decoration: BoxDecoration(color: AppColors.card, border: Border(bottom: BorderSide(color: AppColors.border.withOpacity(0.5))), boxShadow: AppShadows.soft),
    child: Row(children: [
      IconButton(icon: const Icon(Icons.arrow_back, size: 20), onPressed: () => Navigator.pop(context)),
      Container(
        width: 40, height: 40,
        decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: const Text('SG', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
      ),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Text('Sri Ganesh Store', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          const Icon(Icons.check_circle, size: 14, color: AppColors.primary),
        ]),
        Row(children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          Text('Online • Shop Assistant', style: TextStyle(fontSize: 12, color: AppColors.caption)),
        ]),
      ])),
      TapScale(child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle),
        child: const Icon(Icons.call, size: 18, color: AppColors.primary),
      )),
    ]),
  );

  Widget _bubble(Map<String, dynamic> msg) {
    final isMe = msg['isMe'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 16),
              ),
              boxShadow: isMe ? null : AppShadows.soft,
              border: isMe ? null : Border.all(color: AppColors.border.withOpacity(0.5)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(msg['text'], style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppColors.text, height: 1.4)),
              const SizedBox(height: 4),
              Text(msg['time'], style: TextStyle(fontSize: 10, color: isMe ? Colors.white.withOpacity(0.7) : AppColors.caption)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _offerCard(Map<String, dynamic> msg) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)]),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        boxShadow: AppShadows.card,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(msg['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.md), border: Border.all(color: AppColors.border)),
          child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.sm)),
              alignment: Alignment.center, child: const Text('🏪', style: TextStyle(fontSize: 20))),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(msg['job'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Text(msg['company'], style: const TextStyle(fontSize: 12, color: AppColors.caption)),
            ])),
            Text(msg['salary'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
          ]),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: SizedBox(height: 40, child: OutlinedButton(onPressed: () {}, child: const Text('Decline')))),
          const SizedBox(width: 10),
          Expanded(child: SizedBox(height: 40, child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(minimumSize: Size.zero),
            child: const Text('Accept ✓', style: TextStyle(fontSize: 14)),
          ))),
        ]),
      ]),
    ),
  );

  Widget _quickReplies() => SizedBox(
    height: 36,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: ['Yes, I am interested', 'When can I start?', 'What is the salary?', 'I need directions'].map((reply) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: TapScale(
          onTap: () { setState(() { _messages.add({'text': reply, 'isMe': true, 'time': 'Now'}); }); },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(AppRadius.xl)),
            child: Text(reply, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryDark)),
          ),
        ),
      )).toList(),
    ),
  );

  Widget _inputBar() => Container(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
    decoration: BoxDecoration(color: AppColors.card, border: Border(top: BorderSide(color: AppColors.border.withOpacity(0.5)))),
    child: Row(children: [
      Expanded(
        child: Container(
          height: 44,
          decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(AppRadius.xl)),
          child: TextField(
            controller: _msgCtrl,
            onSubmitted: (_) => _send(),
            decoration: const InputDecoration(
              hintText: 'Type a message...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(fontSize: 14, color: AppColors.caption),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
      const SizedBox(width: 8),
      TapScale(
        onTap: _send,
        child: Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, boxShadow: AppShadows.primaryGlow(0.2)),
          child: const Icon(Icons.send_rounded, size: 18, color: Colors.white),
        ),
      ),
    ]),
  );
}
