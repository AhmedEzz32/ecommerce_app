import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/core/criteria/where_criteria.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/core/helper/google_sign_helper.dart';
import 'package:mini_app/data/data_source/firebase_data_source.dart';
import 'package:mini_app/data/data_source/shared_preference_datasource.dart';
import 'package:mini_app/data/requests/requests.dart';
import 'package:mini_app/data/response/products_response.dart';
import 'package:mini_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {

  final FirebaseDataSource _firebaseDataSource;
  final SharedPreferenceDataSource _sharedPreferenceDataSource;
  final Constants _constants;

  RepositoryImpl(this._firebaseDataSource, this._sharedPreferenceDataSource, this._constants);

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>?>> signInWithGoogle() async {
    try {
      var response = await GoogleSignInHelper.signInWithGoogle();
      final userCredential = response.$1;
      final googleUser = response.$2;
      User? user = userCredential.user;
      if (user != null) {
        if ((user.displayName == null || user.displayName!.isEmpty) 
          || (user.photoURL == null || user.photoURL!.isEmpty)
        ) {
          await user.updateProfile(
            displayName: googleUser.displayName,
            photoURL: googleUser.photoUrl, // Manually setting the photo URL
          );
          await user.reload(); // Reload the user data from Firebase
        }
        user = FirebaseAuth.instance.currentUser;
        final data = {
          'uid': user!.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoURL': user.photoURL,
        };
        /// Save user to Firestore
        final savedUser = await _firebaseDataSource.store(
          'users', 
          data,
          id: user.uid,
        );

        /// save user to local storage
        _sharedPreferenceDataSource.saveString(
          _constants.saved_user_key, 
          jsonEncode(data),
        );
        return Right(savedUser);
      }
      return Left(ServerFailure('User not found'));
    } catch (e) {
      if(e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<ServerFailure, ProductsResponse>> getProducts({WhereCriteria? where}) async {
    try {
      final productsSnapshot = await _firebaseDataSource.index('products', where: where);
      final products = productsSnapshot!.map((e) => e.data()).toList();
      return Right(ProductsResponse.fromJson({'products': products}));
    } catch (e) {
      if(e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
  
  @override
  Future<Either<ServerFailure, void>> updateProfile(EditProfileRequest editProfileRequest) async {
    try {
      String? imageUrl;
      if (editProfileRequest.image != null) {
        final imageResponse = await FirebaseStorage.instance.ref('users/${editProfileRequest.id}').putFile(File(editProfileRequest.image!.path));
        imageUrl = await imageResponse.ref.getDownloadURL();
      }

      await _firebaseDataSource.update(
        'users', 
        editProfileRequest.id,
        {
          'first_name': editProfileRequest.firstName,
          'last_name': editProfileRequest.lastName,
          if (imageUrl != null)
            'photo_url': imageUrl,
        },
      );
      return const Right(null);
    } catch (e) {
      if(e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }


}
