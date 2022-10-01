import 'package:doctor_appointment/context/auth_con.dart';
import 'package:doctor_appointment/navigation/auth_stack.dart';
import 'package:doctor_appointment/navigation/user_stack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AuthContext>().authState
        ? const UserStack()
        : const AuthStack();
  }
}
