import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';

class BusinessVerification extends StatefulWidget {
  const BusinessVerification({super.key});

  @override
  State<BusinessVerification> createState() => _BusinessVerificationState();
}

class _BusinessVerificationState extends State<BusinessVerification> {
  final _nameCtrl = TextEditingController();
  final _gstCtrl = TextEditingController();
  bool _documentUploaded = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gstCtrl.dispose();
    super.dispose();
  }

  bool get _isValid => 
    _nameCtrl.text.trim().isNotEmpty && 
    _gstCtrl.text.trim().isNotEmpty && 
    _documentUploaded;

  Future<void> _pickDocument() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        setState(() => _documentUploaded = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document uploaded successfully!'), backgroundColor: AppColors.primary)
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open gallery.'), backgroundColor: AppColors.alert)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final category = ModalRoute.of(context)?.settings.arguments as String? ?? 'Business';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.card, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back, size: 20, color: AppColors.text),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Business Verification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.text)),
              const SizedBox(height: 6),
              Text('Verify your $category business to start hiring.', style: const TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 32),
              
              // Business Name
              const Text('Business Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.soft,
                ),
                child: TextField(
                  controller: _nameCtrl,
                  onChanged: (_) => setState(() {}),
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Enter legal business name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // GST Number
              const Text('GSTIN Number', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.soft,
                ),
                child: TextField(
                  controller: _gstCtrl,
                  onChanged: (_) => setState(() {}),
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    hintText: 'e.g. 22AAAAA0000A1Z5',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Documents
              const Text('Business Document', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              const Text('Upload Registration Certificate, Shop License, or Address Proof.', style: TextStyle(fontSize: 12, color: AppColors.caption)),
              const SizedBox(height: 12),
              
              TapScale(
                onTap: _pickDocument,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: _documentUploaded ? AppColors.primaryLight.withOpacity(0.5) : AppColors.card,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: _documentUploaded ? AppColors.primary : AppColors.border, style: BorderStyle.solid, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _documentUploaded ? Icons.check_circle : Icons.cloud_upload_outlined, 
                        size: 40, 
                        color: _documentUploaded ? AppColors.primary : AppColors.primaryDark
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _documentUploaded ? 'Document Uploaded' : 'Tap to upload document', 
                        style: TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w600, 
                          color: _documentUploaded ? AppColors.primary : AppColors.text
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SizedBox(
          width: double.infinity, height: 56,
          child: ElevatedButton(
            onPressed: _isValid
                ? () {
                    // Save business name to AppState
                    context.read<AppState>().updateProfile(name: _nameCtrl.text.trim());
                    // Verification complete! Go to employer dashboard
                    Navigator.pushReplacementNamed(context, '/employer-home');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Complete Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
