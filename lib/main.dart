import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/my_app.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("✅👌👌 Firebase initialized successfully!");
  } catch (e) {
    debugPrint("❌😊😍 Firebase initialization error: $e");
  }
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity, // أو safetyNet لو القديم
    appleProvider: AppleProvider.appAttest, // أو deviceCheck
  );

  runApp(const MyApp());
}
