import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_app/persentation/sign_in/view/widgets/profile_edit_screen.dart';
import 'package:mini_app/persentation/sign_in/view_model/google_login_model.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});
  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();

  static Future<GoogleLoginModal?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleLoginModal? googleLoginModal;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        googleLoginModal = GoogleLoginModal(googleSignInAuthentication: googleSignInAuthentication,user: userCredential.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          debugPrint("Account exists with different credential");
        }
        else if (e.code == 'invalid-credential') {
          debugPrint("Invalid Credential");
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return googleLoginModal;
  }
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
              var types = await signInWithGoogle();
              final userCredential = types.$1;
              final googleUser = types.$2;
              User? user = userCredential.user;
              if (user != null) {
                if ((user.displayName == null || user.displayName!.isEmpty) ||
                    (user.photoURL == null || user.photoURL!.isEmpty)) {
                  await user.updateProfile(
                    displayName: googleUser.displayName,
                    photoURL: googleUser.photoUrl, // Manually setting the photo URL
                  );
                  await user.reload(); // Reload the user data from Firebase
                  user = FirebaseAuth.instance.currentUser;
                }
              }

              debugPrint("Updated Display Name: ${user?.displayName}");
              debugPrint("Updated photoURL: ${user?.photoURL}");

                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) {
                  return ProfileEditScreen(
                    firstName: user!.displayName!.split(" ")[0],
                    lastName: user.displayName!.split(" ")[1],
                  );
                }));
            },
          ),
        ],
      ),
    );
  }
  static Future<(UserCredential, GoogleSignInAccount)> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return (userCredential, googleUser);
    }
  }
