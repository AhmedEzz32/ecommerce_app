import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileEditScreen extends StatefulWidget {
  final String firstName;
  final String lastName;

  const ProfileEditScreen({
    super.key, 
    required this.firstName, 
    required this.lastName,
  });

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
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
        _imageFile = File(croppedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      String? imageUrl;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      if (_imageFile != null) {
        final ref = FirebaseStorage.instance.ref().child('user_images/${user.uid}.jpg');
        await ref.putFile(_imageFile!);
        imageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'profileImage': imageUrl ?? user.photoURL,
      });
      Navigator.pop(context);
    } catch (e) {
      debugPrint("Error saving profile: $e");
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
                      _imageFile != null ? FileImage(_imageFile!) : NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? ''),
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
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveProfile,
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
