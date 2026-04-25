import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ImagePicker _picker = ImagePicker();
  late TextEditingController _nameCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _aboutCtrl;
  late String _gender;
  late int _experience;
  late String _preferredTiming;
  bool _hasChanges = false;

  // All available skills
  final List<String> _allSkills = [
    'Cooking', 'Cleaning', 'Delivery', 'Shop Helper',
    'Painting', 'Plumbing', 'Electrician', 'Carpentry',
    'Driving', 'Security', 'Gardening', 'Tailoring',
    'Teaching', 'Babysitting', 'Laundry', 'Masonry',
  ];

  final List<String> _allLanguages = [
    'Kannada', 'Hindi', 'English', 'Tamil', 'Telugu', 'Malayalam', 'Marathi', 'Urdu',
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<AppState>();
    _nameCtrl = TextEditingController(text: state.userName);
    _ageCtrl = TextEditingController(text: state.age.toString());
    _locationCtrl = TextEditingController(text: state.location);
    _aboutCtrl = TextEditingController(text: state.aboutMe);
    _gender = state.gender;
    _experience = state.experience;
    _preferredTiming = state.preferredTiming;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _locationCtrl.dispose();
    _aboutCtrl.dispose();
    super.dispose();
  }

  void _markChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source, maxWidth: 800, maxHeight: 800, imageQuality: 85,
      );
      if (image != null && mounted) {
        context.read<AppState>().setProfileImage(image.path);
        _markChanged();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}'), backgroundColor: AppColors.alert),
        );
      }
    }
  }

  void _saveProfile() {
    final state = context.read<AppState>();
    state.updateProfile(
      name: _nameCtrl.text.trim(),
      aboutMe: _aboutCtrl.text.trim(),
      age: int.tryParse(_ageCtrl.text.trim()),
      gender: _gender,
      exp: _experience,
    );
    state.setLocation(_locationCtrl.text.trim());
    state.setPreferredTiming(_preferredTiming);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(children: [
          Icon(Icons.check_circle, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text('Profile updated successfully!', style: TextStyle(fontWeight: FontWeight.w600)),
        ]),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(children: [
          // ── App Bar ──
          Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
            decoration: BoxDecoration(
              color: AppColors.card,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
            ),
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(child: Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
              if (_hasChanges)
                TextButton(
                  onPressed: _saveProfile,
                  child: const Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primary)),
                ),
            ]),
          ),

          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(children: [
                _photoSection(state),
                _divider(),
                _personalInfoSection(),
                _divider(),
                _skillsSection(state),
                _divider(),
                _languagesSection(state),
                _divider(),
                _availabilitySection(state),
                _divider(),
                _timingSection(),
              ]),
            ),
          ),
        ]),
      ),
      // ── Save Button ──
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: AppColors.card,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -4))],
        ),
        child: SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // ── Photo Section ──
  Widget _photoSection(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
    child: Column(children: [
      // Avatar
      GestureDetector(
        onTap: () => _showPhotoOptions(),
        child: Stack(children: [
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              border: Border.all(color: AppColors.primary, width: 3),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 16, spreadRadius: 2)],
            ),
            clipBehavior: Clip.antiAlias,
            child: state.profileImagePath != null
                ? Image.file(File(state.profileImagePath!), fit: BoxFit.cover, width: 96, height: 96,
                    errorBuilder: (_, __, ___) => _initials(state))
                : _initials(state),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.navy, shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
            ),
          ),
        ]),
      ),
      const SizedBox(height: 12),
      TextButton(
        onPressed: _showPhotoOptions,
        child: const Text('Change Photo', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
      ),
    ]),
  );

  Widget _initials(AppState state) => Center(
    child: Text(
      state.userName.isNotEmpty ? state.userName[0].toUpperCase() : 'U',
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );

  void _showPhotoOptions() {
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
            const SizedBox(height: 16),
            _photoOption(Icons.camera_alt, 'Take Photo', 'Open camera', () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            }),
            const SizedBox(height: 8),
            _photoOption(Icons.photo_library, 'Choose from Gallery', 'Upload from device', () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            }),
          ]),
        ),
      ),
    );
  }

  Widget _photoOption(IconData icon, String title, String subtitle, VoidCallback onTap) => ListTile(
    leading: Container(
      width: 44, height: 44,
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
      child: Icon(icon, color: AppColors.primary),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.caption)),
    onTap: onTap,
  );

  // ── Personal Info ──
  Widget _personalInfoSection() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader('Personal Information', Icons.person),
      const SizedBox(height: 16),
      _labeledField('Full Name', _nameCtrl, Icons.badge),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _labeledField('Age', _ageCtrl, Icons.cake, keyboardType: TextInputType.number)),
        const SizedBox(width: 12),
        Expanded(child: _genderDropdown()),
      ]),
      const SizedBox(height: 16),
      _labeledField('Location', _locationCtrl, Icons.location_on),
      const SizedBox(height: 16),
      _label('About Yourself'),
      TextField(
        controller: _aboutCtrl,
        maxLines: 3,
        onChanged: (_) => _markChanged(),
        decoration: InputDecoration(
          hintText: 'Tell employers about yourself...',
          hintStyle: TextStyle(color: AppColors.caption.withOpacity(0.6)),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Icon(Icons.info_outline, size: 20, color: AppColors.caption),
          ),
        ),
      ),
    ]),
  );

  Widget _labeledField(String label, TextEditingController ctrl, IconData icon, {TextInputType? keyboardType}) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label(label),
      TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        onChanged: (_) => _markChanged(),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20, color: AppColors.caption),
        ),
      ),
    ]);

  Widget _genderDropdown() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _label('Gender'),
    DropdownButtonFormField<String>(
      value: _gender,
      items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) { if (v != null) { setState(() => _gender = v); _markChanged(); } },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.wc, size: 20, color: AppColors.caption),
      ),
    ),
  ]);

  // ── Skills Section ──
  Widget _skillsSection(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader('My Skills', Icons.build_circle),
      const SizedBox(height: 4),
      Text('Tap to add or remove skills (max 5)', style: TextStyle(fontSize: 12, color: AppColors.caption)),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 10, children: _allSkills.map((skill) {
        final selected = state.selectedSkills.contains(skill);
        return GestureDetector(
          onTap: () { state.toggleSkill(skill); _markChanged(); },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.5),
              boxShadow: selected ? [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 8)] : [],
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (selected) ...[
                const Icon(Icons.check_circle, size: 16, color: Colors.white),
                const SizedBox(width: 6),
              ],
              Text(skill, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.text)),
            ]),
          ),
        );
      }).toList()),
    ]),
  );

  // ── Languages Section ──
  Widget _languagesSection(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader('Languages Spoken', Icons.translate),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 10, children: _allLanguages.map((lang) {
        final selected = state.spokenLanguages.contains(lang);
        return GestureDetector(
          onTap: () { state.toggleLanguageSpoken(lang); _markChanged(); },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF6366F1) : AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? const Color(0xFF6366F1) : AppColors.border, width: 1.5),
              boxShadow: selected ? [BoxShadow(color: const Color(0xFF6366F1).withOpacity(0.2), blurRadius: 8)] : [],
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (selected) ...[
                const Icon(Icons.check_circle, size: 16, color: Colors.white),
                const SizedBox(width: 6),
              ],
              Text(lang, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.text)),
            ]),
          ),
        );
      }).toList()),
    ]),
  );

  // ── Availability Section ──
  Widget _availabilitySection(AppState state) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader('Availability', Icons.calendar_month),
      const SizedBox(height: 4),
      Text('Select the days you are available to work', style: TextStyle(fontSize: 12, color: AppColors.caption)),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
        final selected = state.availableDays.contains(day);
        return GestureDetector(
          onTap: () { state.toggleDay(day); _markChanged(); },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 42, height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? AppColors.primary : AppColors.card,
              border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.5),
              boxShadow: selected ? [BoxShadow(color: AppColors.primary.withOpacity(0.25), blurRadius: 6)] : [],
            ),
            alignment: Alignment.center,
            child: Text(day, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: selected ? Colors.white : AppColors.caption)),
          ),
        );
      }).toList()),
      const SizedBox(height: 16),
      // Available now toggle
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Icon(Icons.flash_on, size: 20, color: state.availableNow ? AppColors.primary : AppColors.caption),
            const SizedBox(width: 10),
            const Text('Available Now', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ]),
          Switch.adaptive(
            value: state.availableNow,
            onChanged: (v) { state.setAvailableNow(v); _markChanged(); },
            activeColor: AppColors.primary,
          ),
        ]),
      ),
    ]),
  );

  // ── Timing Section ──
  Widget _timingSection() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionHeader('Preferred Timing', Icons.access_time),
      const SizedBox(height: 12),
      Row(children: [
        _timingChip('🌅 Morning', 'Morning'),
        const SizedBox(width: 8),
        _timingChip('☀️ Afternoon', 'Afternoon'),
        const SizedBox(width: 8),
        _timingChip('🌙 Evening', 'Evening'),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        _timingChip('🌃 Night', 'Night'),
        const SizedBox(width: 8),
        _timingChip('🕐 Any Time', 'Any'),
      ]),
      const SizedBox(height: 16),
      // Experience
      _sectionHeader('Years of Experience', Icons.work_history),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _counterBtn(Icons.remove, () {
          if (_experience > 0) setState(() => _experience--);
          _markChanged();
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(width: 100, child: Text(
            '$_experience ${_experience == 1 ? 'year' : 'years'}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          )),
        ),
        _counterBtn(Icons.add, () {
          setState(() => _experience++);
          _markChanged();
        }),
      ]),
    ]),
  );

  Widget _timingChip(String label, String value) {
    final selected = _preferredTiming == value;
    return GestureDetector(
      onTap: () { setState(() => _preferredTiming = value); _markChanged(); },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF59E0B) : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? const Color(0xFFF59E0B) : AppColors.border, width: 1.5),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.text)),
      ),
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48, height: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border), color: AppColors.card),
      child: Icon(icon, size: 20, color: AppColors.textSecondary),
    ),
  );

  // ── Helpers ──
  Widget _sectionHeader(String title, IconData icon) => Row(children: [
    Container(
      width: 32, height: 32,
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 18, color: AppColors.primary),
    ),
    const SizedBox(width: 10),
    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
  ]);

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.caption)),
  );

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Divider(color: AppColors.border.withOpacity(0.5), height: 1),
  );
}
