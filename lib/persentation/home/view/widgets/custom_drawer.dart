import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/core/constants.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:mini_app/persentation/edit_profile/view/profile_edit_screen.dart';
import 'package:mini_app/persentation/home/view/home_view.dart';
import 'package:mini_app/persentation/sign_in/view/login_view.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.widget,
  });

  final HomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.profileImage?.isNotEmpty == true
                    ? widget.profileImage!
                    : Constants().default_image,
              ),
            ),
            accountName: Text('${widget.firstName} ${widget.lastName!}'),
            accountEmail: Text(widget.email!),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(S.current.edit_profile),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
              );
            },
          ),
          Consumer<CartViewModel>(
            builder: (context, localeProvider, child) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(localeProvider.locale.languageCode == 'ar'
                    ? S.current.english
                    : S.current.arabic),
                trailing: Switch(
                  value: localeProvider.locale.languageCode == 'ar',
                  onChanged: (value) {
                    localeProvider.toggleLocale();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(S.current.logout),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
