import 'dart:convert';

import 'package:doctor_appointment/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class Booking extends StatefulWidget {
  final String doc_id;
  const Booking({Key? key, required this.doc_id}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<dynamic> timeList = [];
  int timeSelected = 0;
  String dateSelected = '';
  void getAppointmentForDate(String date) async {
    Uri url = Uri.http('192.168.1.3', '/wp/api/users/get_doc_schedule.php');
    var data = {'uid': widget.doc_id, 'date': date};
    var response = await http.post(url, body: data);
    var msg = json.decode(response.body);
    if (msg.toString().contains(date) && msg[date] != null) {
      setState(() {
        timeList = msg[date];
        dateSelected = date;
      });
    } else {
      setState(() {
        timeList = [];
        dateSelected = '';
      });
    }
  }

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

  Widget initWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [dateTimePicker(), dateWid(), button()],
      ),
    );
  }

  Widget dateTimePicker() {
    return SfDateRangePicker(
      onSelectionChanged: ((DateRangePickerSelectionChangedArgs args) {
        getAppointmentForDate(args.value.toString().substring(0, 10));
      }),
      selectionMode: DateRangePickerSelectionMode.single,
      minDate: DateTime.now(),
    );
  }

  Widget dateWid() {
    List<Widget> foo = [];
    for (var tim in timeList) {
      foo.add(dateContainer(tim));
    }
    return Wrap(
      spacing: 15,
      children: foo,
    );
  }

  Widget dateContainer(int time) {
    var end = time + 1;
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: InkWell(
        onTap: () {
          setState(() {
            timeSelected = time;
          });
          print(timeSelected);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 95,
          height: 55,
          decoration: BoxDecoration(
              color:
                  timeSelected == time ? Constants.PRIMARY_COLOR : Colors.white,
              border: Border.all(
                color: Constants.PRIMARY_COLOR,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child:
              Center(child: (Text(time.toString() + " - " + end.toString()))),
        ),
      ),
    );
  }

  Widget button() {
    if (timeList.length == 0) return Container();
    return Container(
      margin: EdgeInsets.only(top: 45),
      child: SizedBox(
          width: 150, // <-- Your width
          height: 40, // <-- Your height
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          )),
    );
  }
}
