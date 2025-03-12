
import 'dart:io' show File;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locator.dart';
import 'package:mini_app/data/requests/requests.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/edit_profile_usecase.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';

class EditProfileViewModel {

  late final EditProfileUsecase _editProfileUsecase;

  final TextEditingController _firstNameController = TextEditingController();
  TextEditingController get firstNameController => _firstNameController;

  final TextEditingController _lastNameController = TextEditingController();
  TextEditingController get lastNameController => _lastNameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  File? _imageFile;
  File? get imageFile => _imageFile;

  EditProfileViewModel() {
    _editProfileUsecase = EditProfileUsecase(getIt<Repository>());
  }

  void updateImage(File? imageFile) {
    _imageFile = imageFile;
  }

  void updateFirstName(String firstName) {
    _firstNameController.text = firstName;
  }

  void updateLastName(String lastName) {
    _lastNameController.text = lastName;
  }

  void updateEmail(String email) {
    _emailController.text = email;
  }

  Future<void> saveProfile(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await _editProfileUsecase.call(
        EditProfileRequest(
          id: user.uid,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          image: _imageFile,
        ),
      );

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => HomeScreen(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          profileImage: _imageFile?.path ?? 'https://static-00.iconduck.com/assets.00/avatar-default-icon-1024x1024-dvpl2mz1.png',
        )),
      );
    } catch (e) {
      debugPrint("Error saving profile: $e");
    }
  }
}