import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/data/requests/requests.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/base_usecase.dart';

class EditProfileUsecase extends BaseUsecase<EditProfileRequest, void> {
  final Repository repository;

  EditProfileUsecase(this.repository);

  @override
  Future<Either<ServerFailure, void>> call(EditProfileRequest editProfileRequest) async {
    return await repository.updateProfile(editProfileRequest);
  }
}