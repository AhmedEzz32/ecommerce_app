import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/auth/view/widgets/sign_up.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/auth/view_model/login_view_model.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginViewBody extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginViewBody({super.key, required this.viewModel});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _loginWithEmail() async {
  setState(() => isLoading = true);
  try {
    // Sign in the user with email and password
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    final user = userCredential.user;

    // Fetch the user profile from Firestore (assuming user profile is stored in 'users' collection)
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        String firstName = userData['firstName'] ?? '';
        String lastName = userData['lastName'] ?? '';

        // Navigate to the home screen with the fetched data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              firstName: firstName,
              lastName: lastName,
              profileImage: user.photoURL ?? Constants().default_image,
              email: user.email,
            ),
          ),
        );
      } else {
        // Handle the case where user data doesn't exist (e.g., show default values or create profile)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              firstName: '',
              lastName: '',
              profileImage: user.photoURL ?? Constants().default_image,
              email: user.email,
            ),
          ),
        );
      }
    }
  } catch (e) {
    // Show error message if login fails
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  setState(() => isLoading = false);
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.current.welcome_to_mini_app,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: S.current.email),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: S.current.password),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _loginWithEmail,
                    child: Text(S.current.login),
                  ),
            const SizedBox(height: 10),
            isLoading
                ? const CircularProgressIndicator()
                : SignInButton(
                    Buttons.google,
                    onPressed: () async {
                      setState(() => isLoading = true);
                      final user = await widget.viewModel.signinWithGoogle();
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(
                              firstName: user.displayName?.split(' ')[0] ?? '',
                              lastName: user.displayName?.split(' ')[1] ?? '',
                              profileImage: user.photoURL ?? Constants().default_image,
                              email: user.email,
                            ),
                          ),
                        );
                      }
                      setState(() => isLoading = false);
                    },
                ),
                            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpView()),
                );
              },
              child: Text(S.current.dont_have_account_sign_up),
            ),
          ],
        ),
      ),
    );
  }
}