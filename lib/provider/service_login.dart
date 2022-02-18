import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as store;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServiceLogin extends ChangeNotifier {
  Future<bool> loginEmailPass(String email, String password) async {
    //https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBoXMFrc7jcWRaYAqi47NAa6yin7Z2yB0k
    const store.FlutterSecureStorage guardarToken =
        store.FlutterSecureStorage();

    String authority = 'identitytoolkit.googleapis.com';
    String unencodedPath = 'v1/accounts:signInWithPassword';
    String key = 'AIzaSyBoXMFrc7jcWRaYAqi47NAa6yin7Z2yB0k';
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      // 'returnSecureToken': true
    };
    Uri url = Uri.https(authority, unencodedPath, {'key': key});
    http.Response response = await http.post(url, body: jsonEncode(data));
    print(response.statusCode);
    print(response.body);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['registered'] == true) {
        guardarToken.write(
            key: 'token', value: responseBody['registered'].toString());
        //vamos a guardar usuario registrado, en realidad devemos guardar token

        return true;
      }
    }
    return false;
  }

  Future<String?> newUser(String email, String password) async {
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
    int status = response.statusCode;
    if (status == 200) {
      return 'ok';
    } else {
      String? mensage = jdecode['error']['message'];
      return mensage;
    }
  }

  Future<bool> splsh() async {
    const store.FlutterSecureStorage guardarToken =
        store.FlutterSecureStorage();

    final estado = await guardarToken.read(key: 'token');

    if (estado == 'true') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> clearToken() async {
    const store.FlutterSecureStorage guardarToken =
        store.FlutterSecureStorage();
    await guardarToken.delete(key: 'token');
    notifyListeners();
  }
}
