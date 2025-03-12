import 'package:flutter/material.dart';
import 'package:mini_app/persentation/home/view/widgets/custom_drawer.dart';
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
      drawer: CustomDrawer(widget: widget),
      body: HomeViewBody(productViewModel: productViewModel,)
    );
  }
}
