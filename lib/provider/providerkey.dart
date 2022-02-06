import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PoroviderKey extends ChangeNotifier {
  String email = '';
  String pass = '';
  bool _islouding = false;

  GlobalKey<FormState> fromkey = GlobalKey<FormState>();

  bool validar() {
    print(fromkey.currentState?.validate() ?? false);
    return (fromkey.currentState?.validate() ?? false);
  }

  bool get islouding => _islouding;
  set islouding(bool value) {
    _islouding = value;
    notifyListeners();
  }
}
