import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locator.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
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
        home: HomeScreen(),
      ),
    );
  }
}
