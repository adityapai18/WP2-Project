import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../context/auth_con.dart';
import 'package:http/http.dart' as http;

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  String appoint = 'upcoming';
  var resArr = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: initWidget(),
        ),
      ),
    );
  }

  void getAppointments() async {
    var uid = context.read<AuthContext>().user.uid;
    Uri url = Uri.http('192.168.1.3', '/wp/api/users/get_appointments.php',
        {'all': 'true', 'user_id': uid});
    var response = await http.get(url);
    var msg = json.decode(response.body);
    if (msg.toString() != '[]') {
      if (appoint == 'upcoming') {
        setState(() {
          resArr = msg['upcoming'];
        });
      }
      if (appoint == 'past') {
        setState(() {
          resArr = msg['past'];
        });
      }
    }
  }

  Widget initWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
              ),
              const Text(
                "Your bookings",
                style: TextStyle(fontSize: 32),
              ),
              Container(
                width: 45,
              )
            ],
          ),
          divider(),
          renderResult()
        ],
      ),
    );
  }

  Widget divider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (() {
            setState(() {
              appoint = 'past';
            });
            getAppointments();
          }),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: appoint == 'past' ? Constants.PRIMARY_COLOR : Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              'Past Appointments',
              style: TextStyle(
                  color: appoint == 'past' ? Colors.white : Colors.black,
                  fontSize: 12),
            ),
          ),
        ),
        InkWell(
          onTap: (() {
            setState(() {
              appoint = 'upcoming';
            });
            getAppointments();
          }),
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: appoint == 'upcoming'
                    ? Constants.PRIMARY_COLOR
                    : Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                'Upcoming Appointments',
                style: TextStyle(
                    color: appoint == 'upcoming' ? Colors.white : Colors.black,
                    fontSize: 12),
              )),
        )
      ],
    );
  }

  Widget renderResult() {
    return Text(resArr.toString());
  }
}
