import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class WorkerProfileSetup extends StatefulWidget {
  const WorkerProfileSetup({super.key});
  @override
  State<WorkerProfileSetup> createState() => _WorkerProfileSetupState();
}

class _WorkerProfileSetupState extends State<WorkerProfileSetup> {
  int _exp = 3;
  final Set<String> _langs = {'Kannada', 'Hindi'};
  final ImagePicker _picker = ImagePicker();
  String? _localImagePath; // Local state until saved

  @override
  void initState() {
    super.initState();
    // Load existing profile image from AppState if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AppState>();
      if (state.profileImagePath != null) {
        setState(() => _localImagePath = state.profileImagePath);
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _localImagePath = image.path);
        if (mounted) {
          context.read<AppState>().setProfileImage(image.path);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              source == ImageSource.camera
                  ? 'Could not open camera. Please check permissions.'
                  : 'Could not open gallery. Please check permissions.',
            ),
            backgroundColor: AppColors.alert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(child: Column(children: [
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.only(bottom: 100), child: Column(children: [
          _banner(), _photoSection(), _form(), _experience(), _languages(),
        ]))),
      ])),
      bottomNavigationBar: Container(color: AppColors.card, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            child: const Padding(padding: EdgeInsets.only(bottom: 16), child: Text('Skip for now', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600)))),
          SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/home'), child: const Text('Save Profile'))),
        ]),
      ),
    );
  }

  Widget _banner() => Container(color: AppColors.navy, padding: const EdgeInsets.fromLTRB(20, 16, 20, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white12, shape: BoxShape.circle), child: const Icon(Icons.arrow_back, size: 20, color: Colors.white))),
    const SizedBox(height: 16),
    const Text('Complete your profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
    const SizedBox(height: 4), Text('Get 3x more job views!', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.7))),
    const SizedBox(height: 16),
    Row(children: [Expanded(child: Container(height: 6, decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white24),
      child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: _localImagePath != null ? 0.8 : 0.6, child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: AppColors.primary))))),
      const SizedBox(width: 12), Text(_localImagePath != null ? '80%' : '60%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
    ]),
  ]));

  Widget _photoSection() => Padding(padding: const EdgeInsets.fromLTRB(20, 32, 20, 0), child: Column(children: [
    // Profile photo avatar — tap to take photo
    GestureDetector(
      onTap: () => _pickImage(ImageSource.camera),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        width: 100, height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
          color: AppColors.primaryLight,
          boxShadow: _localImagePath != null
              ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, spreadRadius: 2)]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: _localImagePath != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(_localImagePath!),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.camera_alt, size: 28, color: AppColors.primary),
                  ),
                  // Camera overlay on hover
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      height: 28,
                      color: Colors.black45,
                      alignment: Alignment.center,
                      child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              )
            : const Icon(Icons.camera_alt, size: 28, color: AppColors.primary),
      ),
    ),
    const SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _photoBtn(Icons.camera_alt, 'Take Photo', () => _pickImage(ImageSource.camera)),
      const SizedBox(width: 8),
      _photoBtn(Icons.upload, 'Upload', () => _pickImage(ImageSource.gallery)),
    ]),
  ]));

  Widget _photoBtn(IconData icon, String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        color: AppColors.card,
      ),
      child: Row(children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
    ),
  );

  Widget _form() => Padding(padding: const EdgeInsets.fromLTRB(20, 24, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _inputLabel('Full Name'),
    TextFormField(initialValue: 'Raju Kumar', decoration: const InputDecoration()),
    const SizedBox(height: 20),
    Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_inputLabel('Age'), TextFormField(initialValue: '24', keyboardType: TextInputType.number, decoration: const InputDecoration())])),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_inputLabel('Gender'), DropdownButtonFormField<String>(value: 'Male', items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (_) {}, decoration: const InputDecoration())])),
    ]),
    const SizedBox(height: 20), _inputLabel('About Yourself (optional)'),
    TextFormField(maxLines: 3, decoration: const InputDecoration(hintText: 'Tell employers about yourself...')),
  ]));

  Widget _experience() => Padding(padding: const EdgeInsets.fromLTRB(20, 24, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _inputLabel('Years of Experience'),
    const SizedBox(height: 12),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _counterBtn(Icons.remove, () { if (_exp > 0) setState(() => _exp--); }),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: SizedBox(width: 80, child: Text('$_exp years', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)))),
      _counterBtn(Icons.add, () => setState(() => _exp++)),
    ]),
  ]));

  Widget _counterBtn(IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(
    width: 48, height: 48, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), color: AppColors.card),
    child: Icon(icon, size: 20, color: AppColors.textSecondary)));

  Widget _languages() => Padding(padding: const EdgeInsets.fromLTRB(20, 24, 20, 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _inputLabel('Languages you speak'), const SizedBox(height: 12),
    Wrap(spacing: 8, runSpacing: 8, children: ['Kannada', 'Hindi', 'English', 'Tamil', 'Telugu'].map((l) {
      final sel = _langs.contains(l);
      return GestureDetector(onTap: () => setState(() { if (sel) _langs.remove(l); else _langs.add(l); }),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(
          color: sel ? AppColors.primary : AppColors.card, borderRadius: BorderRadius.circular(20), border: Border.all(color: sel ? AppColors.primary : AppColors.border)),
          child: Text('${sel ? '✓ ' : ''}$l', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppColors.text))));
    }).toList()),
  ]));

  Widget _inputLabel(String t) => Padding(padding: const EdgeInsets.only(bottom: 8),
    child: Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.text)));
}
