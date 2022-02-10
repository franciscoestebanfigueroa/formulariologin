import 'package:flutter/material.dart';
import 'package:formulariologin/Widgets/formularios.dart';
import 'package:formulariologin/estaticos/estaticos.dart';

class Login extends StatelessWidget {
  static String router = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.grey[400],
            ),
            _FondoSuperior(),
            const _CardCustom(
              child: Formularios(),
            )
          ],
        ),
      ),
    );
  }
}

class _CardCustom extends StatelessWidget {
  final Widget child;
  const _CardCustom({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.20),
            Container(
              decoration: Estaticos.boxDecorationCar,
              height: size.height * 0.50,
              width: size.width * 0.80,
              child: child,
            ),
            const SizedBox(height: 30),
            const Text('Crear Usuario'),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

class _FondoSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.indigo,
          child: Stack(
            children: const [
              Positioned(
                left: -50,
                top: 10,
                child: _Burbujas(
                  size: 99,
                ),
              ),
              Positioned(
                right: -10,
                top: -10,
                child: _Burbujas(size: 60),
              ),
              Positioned(
                left: 170,
                top: -5,
                child: _Burbujas(
                  size: 60,
                ),
              ),
              Positioned(
                left: 180,
                top: 100,
                child: _Burbujas(
                  size: 100,
                ),
              ),
              Positioned(
                left: 300,
                top: 200,
                child: _Burbujas(
                  size: 40,
                ),
              ),
              Positioned(
                left: 80,
                top: 250,
                child: _Burbujas(
                  size: 78,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _Burbujas extends StatelessWidget {
  final double size;
  const _Burbujas({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: (Colors.white.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
