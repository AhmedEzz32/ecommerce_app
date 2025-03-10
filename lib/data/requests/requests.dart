
import 'dart:io';

class EditProfileRequest {
  final String id;
  final String firstName;
  final String lastName;
  final File? image;
  
  EditProfileRequest({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
  });
}