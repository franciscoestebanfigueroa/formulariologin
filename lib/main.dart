import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/screens.dart';
import 'package:formulariologin/estaticos/estaticos.dart';
import 'package:formulariologin/provider/provider_productos.dart';
import 'package:formulariologin/provider/service_login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyAppProvider());
}

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProviderPreoductos()),
      ChangeNotifierProvider(create: (context) => ServiceLogin())
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.router,
      routes: {
        Splash.router: (_) => const Splash(),
        Home.router: (_) => const Home(),
        Login.router: (_) => const Login(),
        EditProduct.router: (_) => const EditProduct(),
        NewUser.router: (_) => const NewUser()
      },
      scaffoldMessengerKey: Estaticos.messengerkey,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.indigo),
        scaffoldBackgroundColor: Colors.grey,
      ),
    );
  }
}
