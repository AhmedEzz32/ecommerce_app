import 'package:flutter/material.dart';
import 'package:mini_app/persentation/sign_in/view/widgets/login_body.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
  }
}
