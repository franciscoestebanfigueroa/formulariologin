import 'package:flutter/material.dart';
import 'package:formulariologin/Screens/home.dart';
import 'package:formulariologin/Screens/login.dart';
import 'package:formulariologin/provider/service_login.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static String router = 'splash';
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ServiceLogin>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: future.splsh(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              Future.microtask(() {
                if (snapshot.data!) {
                  return Navigator.pushReplacementNamed(context, Home.router);
                } else {
                  return Navigator.pushReplacementNamed(context, Login.router);
                }
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
