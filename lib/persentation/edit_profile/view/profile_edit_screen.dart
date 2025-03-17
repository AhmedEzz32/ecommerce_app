import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/persentation/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    List<String> nameParts = (user.displayName ?? '').split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ''; 

    _viewModel.updateFirstName(firstName);
    _viewModel.updateLastName(lastName);
    _viewModel.updateEmail(user.email ?? '');

    // ✅ Fix: Don't try to convert a URL to a File
    _viewModel.updateImage(null);
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Fetch user profile data from Firestore (replace this with your actual Firestore fetching logic)
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      _viewModel.updateFirstName(data['firstName']);
      _viewModel.updateLastName(data['lastName']);
      _viewModel.updateEmail(data['email']);
      
      // If you are storing the image as a URL or path, you can handle that too
      if (data['profileImage'] != null) {
        _viewModel.updateImage(File(data['profileImage']));
      } else {
        _viewModel.updateImage(null);
      }
    }
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
        if (pickedFile == null) {
        // No image selected
        return;
      }

    _cropImage(File(pickedFile.path));
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
      await _saveImagePath(croppedFile.path);
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
                  backgroundImage: _viewModel.imageFile != null
                      ? FileImage(_viewModel.imageFile!)
                      : NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? Constants().default_image),
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

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }
}
