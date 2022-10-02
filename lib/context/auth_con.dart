// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:doctor_appointment/navigation/user_stack.dart';
import 'package:doctor_appointment/screens/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthContext with ChangeNotifier, DiagnosticableTreeMixin {
  bool _authState = false;

  bool get authState => _authState;

  void setAuthorized() {
    _authState = true;
    notifyListeners();
  }

  Future<void> signUpEmailAndPass(String fname, String lname, String email,
      String pass, String cpass, BuildContext context) async {
    Uri url = Uri.http('192.168.1.7', '/wp/api/users/signup.php');
    var data = {'name': fname + ' ' + lname, 'password': pass, 'email': email};
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
    Uri url = Uri.http('192.168.1.7', '/wp/api/users/login.php');
    var data = {'password': pass, 'email': email};
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
