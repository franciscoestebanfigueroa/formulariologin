import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServiceLogin extends ChangeNotifier {
  Future<String> newUser() async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBoXMFrc7jcWRaYAqi47NAa6yin7Z2yB0k');
    Map<String, dynamic> data = {
      'email': 'fluter@fluter.com',
      'password': 'fluter',
    };

    http.post(url, body: jsonEncode(data));

    return '';
  }
}
