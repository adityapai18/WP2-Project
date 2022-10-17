// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:doctor_appointment/navigation/user_stack.dart';
import 'package:doctor_appointment/screens/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class User {
  String _name = '';
  String _email = '';
  String _photoUrl = '';

  String get name => _name;

  set setName(String name) {
    _name = name;
  }

  String get getEmail => _email;

  set setEmail(String email) {
    _email = email;
  }

  String get photoUrl => _photoUrl;

  set setphotoUrl(String photo) {
    _photoUrl = photo;
  }
}

class AuthContext with ChangeNotifier, DiagnosticableTreeMixin {
  bool _authState = false;
  User user = User();
  bool get authState => _authState;

  void setAuthorized() {
    _authState = true;
    notifyListeners();
  }

  String hashPassword(String data) {
    var bytes1 = utf8.encode(data); // data being hashed
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }

  Future<void> signUpEmailAndPass(String fname, String lname, String email,
      String pass, String cpass, BuildContext context) async {
    Uri url = Uri.http('localhost', '/wp/api/users/signup.php');
    var data = {
      'name': fname + ' ' + lname,
      'password': hashPassword(pass),
      'email': email
    };
    var response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 200) {
      var msg = json.decode(response.body);
      if (msg['message'] == 'success') {
        // print('reco');
        // setAuthorized();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const Login();
        }), (r) {
          return false;
        });
      } else {
        AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {print('Gay')},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {print('Gay')},
              child: const Text('OK'),
            ),
          ],
        );
      }
    }
  }

  Future<void> loginWithEmailAndPassword(
      String email, String pass, BuildContext cntx) async {
    Uri url = Uri.http('localhost', '/wp/api/users/login.php');
    var data = {'password': hashPassword(pass), 'email': email};

    var response = await http.post(url, body: json.encode(data));
    if (response.statusCode == 200) {
      var msg = json.decode(response.body);
      if (msg['message'] == 'success') {
        Navigator.pushAndRemoveUntil(cntx,
            MaterialPageRoute(builder: (BuildContext context) {
          return const UserStack();
        }), (r) {
          return false;
        });
      } else {
        AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {print('Gay')},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {print('Gay')},
              child: const Text('OK'),
            ),
          ],
        );
      }
    }
  }
}
