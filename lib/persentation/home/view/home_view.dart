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

  @override
  void initState() {
    productViewModel = ProductViewModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeViewAppBar(),
      body: HomeViewBody(productViewModel: productViewModel,)
    );
  }
}
