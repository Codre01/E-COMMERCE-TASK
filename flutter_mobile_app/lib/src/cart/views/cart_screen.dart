import 'package:flutter/material.dart';
import 'package:minified_commerce/common/services/storage.dart';
import 'package:minified_commerce/src/auth/views/login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if(accessToken == null){
      return const LoginScreen();
    }
    return Scaffold();
  }
}