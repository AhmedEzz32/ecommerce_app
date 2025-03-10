
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/base_usecase.dart';

class SignInWithGoogleUsecase extends BaseUsecase<void, DocumentReference<Map<String, dynamic>>?> {

  final Repository repository;

  SignInWithGoogleUsecase(this.repository);

  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>?>> call(void input) async {
    return await repository.signInWithGoogle();
  }
}