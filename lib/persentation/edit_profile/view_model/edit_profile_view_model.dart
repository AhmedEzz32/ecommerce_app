
import 'dart:io' show File; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart'; 
import 'package:mini_app/persentation/home/view/home_view.dart'; 
  
class EditProfileViewModel { 


  final TextEditingController _firstNameController = TextEditingController(); 
  TextEditingController get firstNameController => _firstNameController; 

  final TextEditingController _lastNameController = TextEditingController(); 
  TextEditingController get lastNameController => _lastNameController; 

  final TextEditingController _emailController = TextEditingController(); 
  TextEditingController get emailController => _emailController; 

  File? _imageFile; 
  File? get imageFile => _imageFile; 

  void updateImage(File? imageFile, {String? networkImage}) {
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

    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    // 🔹 Check if the user document exists
    final docSnapshot = await userDocRef.get();
    if (!docSnapshot.exists) {
      // 🔹 Create the document if it doesn't exist
      await userDocRef.set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'profileImage': _imageFile != null ? _imageFile!.path : user.photoURL,
      });
      debugPrint("New user document created.");
    } else {
      // 🔹 Update the document if it exists
      await userDocRef.update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'profileImage': _imageFile != null ? _imageFile!.path : user.photoURL,
      });
      debugPrint("User profile updated.");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          profileImage: _imageFile != null ? _imageFile!.path : user.photoURL,
        ),
      ),
    );
  } catch (e) {
    debugPrint("Error saving profile: $e");
  }
}
}