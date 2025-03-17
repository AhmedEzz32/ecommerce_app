import 'package:flutter/material.dart';
import 'package:mini_app/persentation/auth/view/widgets/login_body.dart';
import 'package:mini_app/persentation/auth/view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final LoginViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LoginViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBody(
        viewModel: _viewModel,
      ),
    );
  }
}
