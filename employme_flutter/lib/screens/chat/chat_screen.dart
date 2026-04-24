import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _msgCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _picker = ImagePicker();
  
  bool _showOffer = true;
  bool _showPhoneReveal = true;

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! I saw your application for Shop Assistant. Are you available to start soon?', 'isMe': false, 'time': '10:32 AM'},
    {'text': 'Yes, I can start immediately. I have 2 years experience in similar work.', 'isMe': true, 'time': '10:34 AM'},
    {'text': 'Great! Can you come for a quick meeting tomorrow at the shop?', 'isMe': false, 'time': '10:35 AM'},
    {'text': "Yes, what time? 🚶 I'm only 6 minutes away!", 'isMe': true, 'time': '10:36 AM'},
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
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  Future<void> _pickMedia() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _messages.add({'text': '📷 Photo shared', 'isMe': true, 'time': 'Now'});
        });
      }
    } catch (e) {
      debugPrint('Error picking media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    
    // Get name from arguments (passed from Applicants page) or fallback to AppState
    final argName = ModalRoute.of(context)?.settings.arguments as String?;
    final userName = argName ?? (state.userName.isNotEmpty ? state.userName : 'User Name');
    
    final userInitials = userName.split(' ').map((e) => e[0]).take(2).join().toUpperCase();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          _header(userName, userInitials),
          _jobContextPill(),
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              // +1 for system message, +1 for offer, +1 for phone reveal
              itemCount: _messages.length + 1 + (_showOffer ? 1 : 0) + (_showPhoneReveal ? 1 : 0),
              itemBuilder: (_, i) {
                if (i == 0) return _systemMessage();
                
                int msgIndex = i - 1;
                if (msgIndex < _messages.length) {
                  return _bubble(_messages[msgIndex], userInitials);
                }
                
                // Show interaction cards at the end of the list
                int interactionIndex = msgIndex - _messages.length;
                if (_showOffer && interactionIndex == 0) return _offerCard();
                if (_showPhoneReveal && (interactionIndex == 0 || interactionIndex == 1)) return _phoneRevealCard();
                
                return const SizedBox.shrink();
              },
            ),
          ),
          _quickReplies(),
          _inputBar(),
        ]),
      ),
    );
  }

  Widget _header(String name, String initials) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    decoration: const BoxDecoration(color: AppColors.card, border: Border(bottom: BorderSide(color: AppColors.border))),
    child: Row(children: [
      TapScale(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
          child: const Icon(Icons.arrow_back, size: 20),
        ),
      ),
      const SizedBox(width: 12),
      Container(
        width: 44, height: 44,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.navy),
        alignment: Alignment.center,
        child: Text(initials, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Flexible(child: Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800), overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 6),
          const Icon(Icons.check_circle, size: 14, color: AppColors.primary),
        ]),
        const SizedBox(height: 2),
        const Text('Applicant • Shop Assistant', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
      ])),
      TapScale(child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
        child: const Icon(Icons.call, size: 18),
      )),
      const SizedBox(width: 8),
      PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'profile') {
            Navigator.pushNamed(context, '/worker-profile'); 
          }
        },
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'profile',
            child: Row(children: [
              Icon(Icons.person_outline, size: 20, color: AppColors.text),
              SizedBox(width: 12),
              Text('View Profile', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ]),
          ),
          const PopupMenuItem(
            value: 'report',
            child: Row(children: [
              Icon(Icons.report_problem_outlined, size: 20, color: AppColors.alert),
              SizedBox(width: 12),
              Text('Report User', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.alert)),
            ]),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
          child: const Icon(Icons.more_vert, size: 18),
        ),
      ),
    ]),
  );

  Widget _jobContextPill() => Container(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(children: [
      const Text('🏪', style: TextStyle(fontSize: 16)),
      const SizedBox(width: 8),
      const Flexible(child: Text('Shop Assistant', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
      const SizedBox(width: 8),
      const Text('₹12,000/mo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.primary)),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
        child: const Text('Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
      ),
    ]),
  );

  Widget _systemMessage() => Center(
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: const [
        Icon(Icons.info_outline, size: 14, color: AppColors.textSecondary),
        SizedBox(width: 6),
        Text('Chat started • Nov 12, 2025', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
      ]),
    ),
  );

  Widget _bubble(Map<String, dynamic> msg, String initials) {
    final isMe = msg['isMe'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            Container(
              width: 32, height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.navyLighter),
              alignment: Alignment.center,
              child: Text(initials, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.navy)),
            ),
            const SizedBox(width: 8),
          ],
          Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280), // Fixed max width to avoid MediaQuery issues in constrained container
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.card,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
                border: isMe ? null : Border.all(color: AppColors.border),
              ),
              child: Text(msg['text'], style: TextStyle(fontSize: 14, color: isMe ? Colors.white : AppColors.text, height: 1.5)),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(left: isMe ? 0 : 8, right: isMe ? 8 : 0),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(msg['time'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.caption)),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  const Text('✓✓', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                ],
              ]),
            ),
          ]),
        ],
      ),
    );
  }

  // React-matching job offer card with green banner
  Widget _offerCard() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        // Green banner header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: AppColors.primary,
          child: const Text('🎉 JOB OFFER', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5)),
        ),
        Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          const Text('Shop Assistant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('₹12,000/month • Full Time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          // Details
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: const [
                Text('Start: ', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                Text('Monday, Nov 14', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 4),
              Row(children: const [
                Text('Hours: ', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                Text('9 AM – 6 PM, Mon–Sat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // Buttons
          Row(children: [
            Expanded(child: SizedBox(height: 44, child: ElevatedButton(
              onPressed: () { setState(() { _showOffer = false; }); },
              style: ElevatedButton.styleFrom(minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.check, size: 18), SizedBox(width: 6), Text('Accept')]),
            ))),
            const SizedBox(width: 12),
            Expanded(child: SizedBox(height: 44, child: OutlinedButton(
              onPressed: () { setState(() { _showOffer = false; }); },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.alert),
                foregroundColor: AppColors.alert,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.close, size: 18), SizedBox(width: 6), Text('Decline')]),
            ))),
          ]),
          const SizedBox(height: 12),
          const Text('Offer expires in 24 hours', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.alert)),
        ])),
      ]),
    ),
  );

  // Phone Reveal Card — matches React
  Widget _phoneRevealCard() => Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border, style: BorderStyle.solid),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: const [
        Text('🔒', style: TextStyle(fontSize: 16)),
        SizedBox(width: 8),
        Text('Share your phone number?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
      ]),
      const SizedBox(height: 8),
      const Text('Sri Ganesh Store wants to contact you directly.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
      const SizedBox(height: 6),
      const Text('📞 Your number stays private until you accept', style: TextStyle(fontSize: 12, color: AppColors.caption, fontWeight: FontWeight.w600)),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: SizedBox(height: 44, child: ElevatedButton(
          onPressed: () { setState(() { _showPhoneReveal = false; }); },
          style: ElevatedButton.styleFrom(minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: const Text('Share Number', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
        ))),
        const SizedBox(width: 12),
        Expanded(child: SizedBox(height: 44, child: OutlinedButton(
          onPressed: () { setState(() { _showPhoneReveal = false; }); },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            foregroundColor: AppColors.textSecondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Keep Hidden', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        ))),
      ]),
    ]),
  );

  Widget _quickReplies() => Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: const BoxDecoration(color: AppColors.card, border: Border(top: BorderSide(color: AppColors.border))),
    child: SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ["Yes, I'm interested 👍", 'When do I start?', "What's the pay?", "I'm on my way"].map((reply) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TapScale(
            onTap: () { setState(() { _messages.add({'text': reply, 'isMe': true, 'time': 'Now'}); }); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(reply, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            ),
          ),
        )).toList(),
      ),
    ),
  );

  Widget _inputBar() => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
    color: AppColors.card,
    child: Row(children: [
      TapScale(
        onTap: _pickMedia,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.bg, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
          child: const Icon(Icons.attach_file, size: 20, color: AppColors.textSecondary),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(child: Container(
        height: 48,
        decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border)),
        child: Row(children: [
          Expanded(child: TextField(
            controller: _msgCtrl,
            onSubmitted: (_) => _send(),
            decoration: const InputDecoration(
              hintText: 'Type a message...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.caption),
            ),
            style: const TextStyle(fontSize: 15),
          )),
          const Padding(padding: EdgeInsets.only(right: 12), child: Icon(Icons.emoji_emotions_outlined, size: 20, color: AppColors.textSecondary)),
        ]),
      )),
      const SizedBox(width: 12),
      TapScale(
        onTap: _send,
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, boxShadow: AppShadows.primaryGlow(0.2)),
          child: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
        ),
      ),
    ]),
  );
}
