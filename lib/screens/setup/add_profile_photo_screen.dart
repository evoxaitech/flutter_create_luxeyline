import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/setup_progress_bar.dart';
import 'welcome_screen.dart';

class AddProfilePhotoScreen extends StatefulWidget {
  const AddProfilePhotoScreen({super.key});

  @override
  State<AddProfilePhotoScreen> createState() => _AddProfilePhotoScreenState();
}

class _AddProfilePhotoScreenState extends State<AddProfilePhotoScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  void _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SetupProgressBar(step: 3),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: AppColors.fieldFill, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back,
                      size: 18, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Add a Profile Photo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text(
                'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                style: TextStyle(
                    color: AppColors.textSecondary, height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.fieldFill,
                          image: _image != null
                              ? DecorationImage(
                                  image: FileImage(_image!), fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=300&q=80'),
                                  fit: BoxFit.cover),
                        ),
                      ),
                      if (_image != null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => setState(() => _image = null),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        )
                      else
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Icon(Icons.camera_alt_outlined,
                                color: AppColors.primary, size: 18),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(label: 'Continue', onPressed: _goNext),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _goNext,
                  child: const Text('Skip',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
