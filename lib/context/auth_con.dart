import 'package:flutter/foundation.dart';

class AuthContext with ChangeNotifier, DiagnosticableTreeMixin {
  bool _authState = false;

  bool get authState => _authState;

  void signUpEmailAndPass(
      String fname, String lname, String email, String pass, String cpass) {}

  void setAuthorized() {
    _authState = true;
    notifyListeners();
  }
}
