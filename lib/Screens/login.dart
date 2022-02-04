import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static String router = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: const [
            _Fondo(),
          ],
        ),
      ),
    );
  }
}

class _Fondo extends StatelessWidget {
  const _Fondo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.red,
        ),
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
