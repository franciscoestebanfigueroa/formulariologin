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
}
