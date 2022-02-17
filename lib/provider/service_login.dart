import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServiceLogin extends ChangeNotifier {
  Future<String> newUser(String email, String password) async {
    //  Uri url = Uri.parse(
    //      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBoXMFrc7jcWRaYAqi47NAa6yin7Z2yB0k');
    //
    String authority = 'identitytoolkit.googleapis.com';
    String unencodedPath = 'v1/accounts:signUp';
    String keyTokenWeb = 'AIzaSyBoXMFrc7jcWRaYAqi47NAa6yin7Z2yB0k';

    Uri url = Uri.https(authority, unencodedPath, {'key': keyTokenWeb});

    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      //'returnSecureToken': true
    };

    http.Response response = await http.post(url, body: jsonEncode(data));

    var jdecode = jsonDecode(response.body);
    var mensage = jdecode['error']['message'];
    return mensage ?? 'sin data';
  }
}
