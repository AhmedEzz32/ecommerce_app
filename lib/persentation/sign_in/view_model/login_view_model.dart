import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_app/core/di/service_locator.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/sign_in_with_google_usecase.dart';

class LoginViewModel {

  late final SignInWithGoogleUsecase _googleUsecase;
  
  LoginViewModel() {
    _googleUsecase = SignInWithGoogleUsecase(getIt<Repository>());
  }

  Future<User?> signinWithGoogle() async {
    final response = await _googleUsecase.call(null);
    if (response.isRight()) {
      return FirebaseAuth.instance.currentUser;
    } else {
      return null;
    }
  }
}
