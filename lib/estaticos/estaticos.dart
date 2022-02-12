import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Estaticos {
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

  static ImageProvider<Object> imagenes(String value) {
    if (value == null) {
      return const NetworkImage('https://via.placeholder.com/400x300/f6f6f6f6');
    }

    if (value.startsWith('http')) {
      return NetworkImage(value);
    } else {
      Uri uri = Uri.file(value);
      File file = File.fromUri(uri);
      return FileImage(file);
    }
  }
}
