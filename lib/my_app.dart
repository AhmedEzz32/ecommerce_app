import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/auth/view/login_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartViewModel>(
      create: (_) => getIt<CartViewModel>(),
      child: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          return MaterialApp(
            locale: viewModel.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: FirebaseAuth.instance.currentUser == null
                ? const LoginView()
                : FutureBuilder<User?>(
                    future: viewModel.getCurrentUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        final user = snapshot.data!;
                        return HomeScreen(
                          firstName: user.displayName?.split(" ").first ?? S.current.guest,
                          lastName: user.displayName?.split(" ").last ?? "",
                          email: user.email,
                          profileImage: user.photoURL ?? "",
                        );
                      } else {
                        return const LoginView();
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
