import 'package:flutter/material.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';
import 'package:mini_app/persentation/home/view/widgets/home_view_app_bar.dart';
import 'package:mini_app/persentation/home/view/widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductViewModel productViewModel;
  String? firstName;
  String? lastName;
  String? profileImage;

  @override
  void initState() {
    productViewModel = ProductViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeViewAppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  profileImage?.isNotEmpty == true
                      ? profileImage!
                      : "https://static-00.iconduck.com/assets.00/avatar-default-icon-1024x1024-dvpl2mz1.png",
                ),
              ),
              accountName: Text((firstName != null && lastName != null) ? '$firstName $lastName' : "name"),
              accountEmail: Text(lastName ?? "Email"),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ProfileEditScreen(
                //       firstName: firstName ?? '',
                //       lastName: lastName ?? '',
                //     ),
                //   ),
                // ).then((_) => _fetchUserData());
              },
            ),
          ],
        ),
      ),
      body: HomeViewBody(productViewModel: productViewModel,)
    );
  }
}
