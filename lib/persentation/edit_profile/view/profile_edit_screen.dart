import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_app/persentation/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {

  late final EditProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = EditProfileViewModel();

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _viewModel.updateFirstName(user.displayName?.split(' ')[0] ?? '');
    _viewModel.updateLastName(user.displayName?.split(' ')[1] ?? '');
    _viewModel.updateEmail(user.email ?? '');
    _viewModel.updateImage(null);
  }

  Future<void> _pickImage() async {
    // Request camera and gallery permissions
    PermissionStatus cameraPermission = await Permission.camera.request();
    PermissionStatus galleryPermission = await Permission.photos.request();
    PermissionStatus storagePermission = await Permission.storage.request();

    // Check if both permissions are granted
    if (cameraPermission.isGranted || galleryPermission.isGranted || storagePermission.isGranted) {
      // Permission granted, pick image
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _cropImage(File(pickedFile.path));
      }
    } else {
      // Show an error if permissions are denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please grant camera and gallery permissions.')),
      );
        openAppSettings();

    }
  }

  Future<void> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _viewModel.updateImage(File(croppedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _viewModel.imageFile != null ? FileImage(_viewModel.imageFile!) : NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? ''),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt, 
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _viewModel.firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _viewModel.lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _viewModel.saveProfile(context),
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
