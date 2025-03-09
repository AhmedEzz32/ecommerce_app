import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locator.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/sign_in/view/login_view.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully!");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }
    await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity, // أو safetyNet لو القديم
    appleProvider: AppleProvider.appAttest, // أو deviceCheck
  ); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartViewModel>(
      create: (context) => getIt<CartViewModel>(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
