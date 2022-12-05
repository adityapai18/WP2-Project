import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String appoint = '';
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
          buildDoctorsList()
        ],
      ),
    );
  }

  Widget buildDoctorsList() {
    List<Widget> list = [];
    if (resArr.isNotEmpty) {
      for (var doc in resArr) {
        list.add(docAppCard(doc));
      }
    }

    return ListView(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: list,
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

  Widget docAppCard(dynamic latestAppointment) {
    String getDateAndTime(int time, String date) {
      var res = '';
      DateTime dateTime = DateTime.parse(date);
      res += dateTime.day.toString() + '/' + dateTime.month.toString() + '    ';
      if (time > 12) {
        res += (time - 12).toString() + " PM";
      } else {
        res += (time).toString() + " AM";
      }
      return res;
    }

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      width: window.physicalGeometry.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Constants.PRIMARY_COLOR),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  latestAppointment['doc_data']["SPECIALITY"]
                          .toString()
                          .toUpperCase() +
                      '  CHECKUP',
                  style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  getDateAndTime(latestAppointment['apt_time'],
                      latestAppointment['apt_date']),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            doctorCard(
                latestAppointment['doc_data']["IMG_URL"],
                "Dr. " + latestAppointment['doc_data']["NAME"],
                latestAppointment['doc_data']["LOCATION"]!,
                '',
                '')
          ],
        ),
      ),
    );
  }

  Widget doctorCard(
      String img, String name, String specialist, String rating, String time,
      {bool isSelected = true}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(left: 5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(img),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: GoogleFonts.mulish().fontFamily,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Text(
                      specialist,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: GoogleFonts.mulish().fontFamily,
                          color: isSelected ? Colors.white : Colors.black),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
