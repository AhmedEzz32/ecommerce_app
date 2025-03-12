import 'package:flutter/material.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/sign_in/view_model/login_view_model.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginViewBody extends StatefulWidget {
  
  final LoginViewModel viewModel;

  const LoginViewBody({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.current.welcome_to_mini_app,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          isLoading ? const CircularProgressIndicator() :
          SignInButton(
            Buttons.google, 
            onPressed: () async{
              setState(() {
                isLoading = true;
              });
              
              final user = await widget.viewModel.signinWithGoogle();
              if (user != null) {
                debugPrint("Updated Display Name: ${user.displayName}");
                debugPrint("Updated photoURL: ${user.photoURL}");

                setState(() {
                  isLoading = false;
                });
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (_) => HomeScreen(
                    firstName: user.displayName?.split(' ')[0] ?? '',
                    lastName: user.displayName?.split(' ')[1] ?? '',
                    profileImage: user.photoURL ?? Constants().default_image,
                  )),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
