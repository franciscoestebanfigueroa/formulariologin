import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Estaticos {
  static GlobalKey<ScaffoldMessengerState> messengerkey =
      GlobalKey<ScaffoldMessengerState>();
//metodo estatico para tener acceso a un snackbar, la llave es colocada en matrial..

  static showSnackbar(String mensaje) {
    final SnackBar misnackBar = SnackBar(content: Text(mensaje));

    messengerkey.currentState!.showSnackBar(misnackBar);
  }

  static BoxDecoration boxDecorationCar = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[100],
      boxShadow: const [
        BoxShadow(
            color: Colors.black, blurRadius: 50, offset: Offset(0.0, 15.0)),
      ]);

  static InputDecoration inputDecorationCar({
    IconData? icon,
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon) : null,
    );
  }

  static ImageProvider<Object> imagenes(String? value) {
    if (value == null) return const AssetImage('assets/no-image.jpg');

    if (value.startsWith('http')) {
      return NetworkImage(value);
    } else {
      Uri uri = Uri.file(value);
      File file = File.fromUri(uri);
      return FileImage(file);
    }
  }
}
