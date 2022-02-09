import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ProviderFormKeyEditProduct extends ChangeNotifier {
  GlobalKey<FormState> fromkeyeditproduct = GlobalKey<FormState>();

  bool validaEditProduct() {
    return fromkeyeditproduct.currentState!.validate() ? true : false;
  }
}
