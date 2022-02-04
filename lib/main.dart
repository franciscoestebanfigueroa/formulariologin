import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Login.router,
      routes: {
        Home.router: (_) => const Home(),
        Login.router: (_) => const Login()
      },
    );
  }
}
