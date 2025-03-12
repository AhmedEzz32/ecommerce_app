import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/sign_in/view/login_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => getIt<CartViewModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null
        ? const LoginView()
        : FutureBuilder<User?>(
            future: _getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return HomeScreen(
                  firstName: user.displayName?.split(" ").first ?? "User",
                  lastName: user.displayName?.split(" ").last ?? "",
                  email: user.email,
                  profileImage: user.photoURL ?? "",
                );
              } else {
                return const LoginView();
              }
            },
          ),
          ),
        );
    }
    Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
