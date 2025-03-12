import 'package:flutter/material.dart';
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
          const Text(
            'Welcome to Mini App',
            style: TextStyle(
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
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
