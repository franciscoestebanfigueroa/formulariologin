import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/screens.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyAppProvider());
}

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProviderPreoductos())
    ], child: MyApp());
  }
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
        Login.router: (_) => const Login(),
        EditProduct.router: (_) => EditProduct()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.indigo),
        scaffoldBackgroundColor: Colors.grey,
      ),
    );
  }
}
