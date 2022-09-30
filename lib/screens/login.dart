import 'package:doctor_appointment/constants/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
        ),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: const [
              Text(
                'Welcome To ',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                'MyDoctor',
                style: TextStyle(fontSize: 30, color: Constants.PRIMARY_COLOR),
              )
            ],
          ),
        ),
        const Center(
          child: Text(
            'Let us get to know you better!',
            style: TextStyle(color: Constants.GRAY, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: form(),
        ) // form
      ],
    );
  }

  Widget form() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customInput((text) {
              if (text == null || text.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, 'First Name'),
            customInput((text) {
              if (text == null || text.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, 'Last Name'),
            customInput((text) {
              if (text == null || text.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, 'Email'),
            customInput((text) {
              if (text == null || text.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, 'Password'),
            customInput((text) {
              if (text == null || text.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }, 'Confirm Password'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ));
  }

  Widget customInput(String? Function(String?)? validation, String label) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              color: Constants.GRAY,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                    validator: validation,
                    obscureText:
                        label == 'Password' || label == 'Confirm Password',
                    enableSuggestions:
                        label != 'Password' || label == 'Confirm Password',
                    autocorrect:
                        label != 'Password' || label == 'Confirm Password',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text(label),
                    )))));
  }
}
