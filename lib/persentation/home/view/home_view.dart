import 'package:flutter/material.dart';
import 'package:mini_app/persentation/edit_profile/view/profile_edit_screen.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';
import 'package:mini_app/persentation/home/view/widgets/home_view_app_bar.dart';
import 'package:mini_app/persentation/home/view/widgets/home_view_body.dart';

class HomeScreen extends StatefulWidget {

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImage;

  const HomeScreen({
    super.key, 
    this.firstName, 
    this.lastName, 
    this.profileImage, 
    this.email
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ProductViewModel productViewModel;

  @override
  void initState() {
    productViewModel = ProductViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  HomeViewAppBar(productViewModel: productViewModel),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.profileImage?.isNotEmpty == true
                      ? widget.profileImage!
                      : "https://static-00.iconduck.com/assets.00/avatar-default-icon-1024x1024-dvpl2mz1.png",
                ),
              ),
              accountName: Text('${widget.firstName} ${widget.lastName!}'),
              accountEmail: Text(widget.email!),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: HomeViewBody(productViewModel: productViewModel,)
    );
  }
}
