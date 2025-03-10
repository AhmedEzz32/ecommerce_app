import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/data/requests/requests.dart';
import 'package:mini_app/data/response/products_response.dart';

abstract class Repository {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>?>> signInWithGoogle();
  Future<Either<Failure, ProductsResponse>> getProducts();
  Future<Either<ServerFailure, void>> updateProfile(EditProfileRequest editProfileRequest);
}
