import 'package:bom_hamburguer/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bom Hambúrguer',
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
