import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/trust_gauge.dart';
import '../../providers/app_state.dart';

class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _changeProfilePhoto() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            const Text('Update Profile Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            ListTile(
              leading: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.camera_alt, color: AppColors.primary),
              ),
              title: const Text('Take Photo', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Open camera to take a new photo', style: TextStyle(fontSize: 12, color: AppColors.caption)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.photo_library, color: AppColors.primary),
              ),
              title: const Text('Choose from Gallery', style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Upload photo from your device', style: TextStyle(fontSize: 12, color: AppColors.caption)),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null && mounted) {
        context.read<AppState>().setProfileImage(image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(source == ImageSource.camera
                ? 'Could not open camera. Please check permissions.'
                : 'Could not open gallery. Please check permissions.'),
            backgroundColor: AppColors.alert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    
    // Get name from arguments (passed from Employer Dashboard) or fallback to AppState
    final argName = ModalRoute.of(context)?.settings.arguments as String?;
    final userName = argName ?? (state.userName.isNotEmpty ? state.userName : 'User Name');
    final initials = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 16), child: Column(children: [
        _profileHeader(state, userName, initials), _trustCard(context, state), _statsRow(context, state), _aboutSection(state), _skillsSection(state), _availabilitySection(state), _reviewsSection(state), _actions(context, state, userName),
      ]))),
      bottomNavigationBar: argName != null
          ? const EmployerNav(currentIndex: 0)
          : const WorkerNav(currentIndex: 4),
    );
  }

  Widget _profileHeader(AppState state, String name, String initials) => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1E3A5F), Color(0xFF2D5986)])),
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
    child: Column(children: [
      Align(alignment: Alignment.topRight, child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/edit-profile'),
        child: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: const Icon(Icons.edit, size: 16, color: Colors.white)),
      )),
      // Profile photo — tap to change
      GestureDetector(
        onTap: _changeProfilePhoto,
        child: Stack(
          children: [
            Container(
              width: 88, height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12)],
              ),
              clipBehavior: Clip.antiAlias,
              child: state.profileImagePath != null
                  ? Image.file(File(state.profileImagePath!), fit: BoxFit.cover, width: 88, height: 88,
                      errorBuilder: (_, __, ___) => Center(child: Text(initials, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white))))
                  : Center(child: Text(initials, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white))),
            ),
            // Camera badge
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
        child: Text(state.tr('available_now'), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))),
      const SizedBox(height: 8), Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white)),
      const SizedBox(height: 2), Text('📍 ${state.location} • ${state.gender}, ${state.age}', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
      Text(state.tr('member_since', args: {'date': 'April 2025'}), style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
    ]));

  Widget _trustCard(BuildContext context, AppState state) => Transform.translate(offset: const Offset(0, -20), child: GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/trust'),
    child: Container(margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)]),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [Text(state.tr('trust_score'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(width: 6), const Icon(Icons.shield, size: 18, color: AppColors.text)]),
        GestureDetector(onTap: () => Navigator.pushNamed(context, '/trust'), child: Text(state.tr('what_is_this'), style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600))),
      ]),
      const SizedBox(height: 12),
      Row(children: [
        const TrustGauge(score: 87),
        const SizedBox(width: 20),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(state.tr('good'), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary)),
          Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 14, color: AppColors.primary), const SizedBox(width: 6), Text(state.tr('verified'), style: const TextStyle(fontSize: 12, color: AppColors.primary))]),
          const SizedBox(height: 4), Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 14, color: AppColors.primary), const SizedBox(width: 6), Text(state.tr('community_verified'), style: const TextStyle(fontSize: 12, color: AppColors.primary))]),
          const SizedBox(height: 4), Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.hourglass_empty, size: 14, color: Color(0xFFF97316)), const SizedBox(width: 6), Text('${state.tr('ngo_verification')} — Get verified →', style: const TextStyle(fontSize: 12, color: Color(0xFFF97316)))]),
        ])),
      ]),
    ]))));

  Widget _statsRow(BuildContext context, AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), child: Row(children: [
    _statBox('12', state.tr('jobs_done'), () => Navigator.pushNamed(context, '/my-jobs')),
    _statBox('₹18,400', state.tr('earned'), () => Navigator.pushNamed(context, '/earnings')),
    _statBox('100%', state.tr('show_up'), () => Navigator.pushNamed(context, '/trust')),
  ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: w))).toList()));

  Widget _statBox(String n, String l, [VoidCallback? onTap]) => GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]),
    child: Column(children: [Text(n, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.primary)), const SizedBox(height: 2), Text(l, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))])));

  Widget _skillsSection(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(state.tr('my_skills'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), GestureDetector(onTap: () => Navigator.pushNamed(context, '/edit-profile'), child: Text(state.tr('edit'), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)))]),
    const SizedBox(height: 10),
    Wrap(spacing: 8, runSpacing: 8, children: [
      ...state.selectedSkills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
        child: Text(state.tr(s), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)))),
      if (state.selectedSkills.isEmpty)
         Text(state.tr('no_skills_added'), style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    ]),
  ]));

  Widget _aboutSection(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('About Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    const SizedBox(height: 8),
    Text(state.aboutMe.isNotEmpty ? state.aboutMe : 'No details provided yet.', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
  ]));

  Widget _availabilitySection(AppState state) => Container(margin: const EdgeInsets.fromLTRB(20, 16, 20, 0), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(state.tr('my_availability'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 10),
      Row(children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
        final selected = state.availableDays.contains(day);
        return Padding(padding: const EdgeInsets.only(right: 6),
        child: Container(width: 36, height: 36, decoration: BoxDecoration(shape: BoxShape.circle, color: selected ? AppColors.primary : AppColors.border),
          alignment: Alignment.center, child: Text(day, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: selected ? Colors.white : AppColors.caption))));
      }).toList()),
      const SizedBox(height: 10),
      Wrap(spacing: 8, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(_getTimingIconData(state.preferredTiming), size: 14, color: AppColors.primary), const SizedBox(width: 4), Text(state.tr(state.preferredTiming.toLowerCase()), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary))])),
        Text('Available: ${state.availableNow ? state.tr('immediately') : 'Not right now'}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))]),
    ]));

  IconData _getTimingIconData(String timing) {
    switch (timing) {
      case 'Morning': return Icons.wb_twilight;
      case 'Afternoon': return Icons.wb_sunny_outlined;
      case 'Evening': return Icons.wb_twilight_rounded;
      case 'Night': return Icons.dark_mode_outlined;
      default: return Icons.access_time;
    }
  }

  Widget _reviewsSection(AppState state) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Text(state.tr('work_history'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(width: 6), const Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)), const Text(' 4.8 (12 reviews)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))]),
    const SizedBox(height: 12), _reviewCard(state, Icons.storefront, state.businessName, 'Aug 2025', 5, 'Excellent worker, very punctual and honest', [state.tr('on_time'), state.tr('honest'), state.tr('hardworking')]),
    const SizedBox(height: 10), _reviewCard(state, Icons.restaurant, 'Hotel Udupi', 'Jul 2025', 4, 'Good worker, reliable and quick to learn', [state.tr('reliable'), state.tr('would_rehire')]),
    const SizedBox(height: 12), Center(child: Text(state.tr('view_all_reviews', args: {'count': '12'}), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
  ]));

  Widget _reviewCard(AppState state, IconData icon, String name, String date, int stars, String text, List<String> badges) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Container(width: 36, height: 36, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryLight), alignment: Alignment.center, child: Icon(icon, size: 18, color: AppColors.primaryDark)), const SizedBox(width: 10), Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))]), Text(date, style: const TextStyle(fontSize: 12, color: AppColors.caption))]),
      const SizedBox(height: 6), Row(children: List.generate(stars, (_) => const Icon(Icons.star, size: 14, color: Color(0xFFF59E0B)))),
      const SizedBox(height: 6), Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
      const SizedBox(height: 8), Wrap(spacing: 6, children: badges.map((b) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 12, color: AppColors.primary), const SizedBox(width: 4), Text(b, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary))]))).toList()),
    ]));

  Widget _actions(BuildContext ctx, AppState state, String userName) => Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0), child: Row(children: [
    Expanded(child: OutlinedButton(onPressed: () {
      Share.share("Check out $userName's profile on EmployMe! Find trusted local workers for your needs. #EmployMe #HireLocal");
    }, style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.ios_share, size: 18), const SizedBox(width: 8), Text(state.tr('share'))]))),
    const SizedBox(width: 10),
    Expanded(child: SizedBox(height: 48, child: ElevatedButton(onPressed: () => Navigator.pushNamed(ctx, '/trust'), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.shield, size: 18), const SizedBox(width: 8), Text(state.tr('trust_score'))])))),
  ]));
}
