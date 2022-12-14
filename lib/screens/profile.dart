// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:doctor_appointment/constants/constants.dart';
import 'package:doctor_appointment/screens/appointments.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../context/auth_con.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';
  var isPrivate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email = context.read<AuthContext>().user.getEmail;
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? uploadimage;
  void showAlert(String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              setState(() {
                uploadimage = null;
              }),
              Navigator.of(context).pop()
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void uploadImage() async {
    final fileName = uploadimage!.name;
    final destination = 'files/$fileName';
    File file = File(uploadimage!.path);
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      await ref.putFile(file);
      var downUrl = await ref.getDownloadURL();
      Uri url = Uri.http('192.168.1.3', '/wp/api/users/upload_image_url.php');
      var response =
          await http.post(url, body: {'img_url': downUrl, 'email': email});
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body); //decode json data
        if (jsondata["error"]) {
          //check error sent from server
          showAlert(jsondata["msg"]);

          //if error return from server, show message from server
        } else {
          context.read<AuthContext>().setUserImage(jsondata["img_url"]);
          showAlert("Upload successful");
        }
      }
    } catch (e) {
      showAlert('error occured');
    }
    // List<int> imageBytes = await uploadimage!.readAsBytes();
    // String baseimage = base64Encode(imageBytes);
  }

  Future<void> pickImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        uploadimage = image;
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Image Upload'),
          content: const Text('Do You want to Upload this Image ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                setState(() {
                  uploadimage = null;
                }),
                Navigator.of(context).pop()
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {uploadImage(), Navigator.of(context).pop()},
              child: const Text('Yes'),
            ),
          ],
        ),
      );
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
    return Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            navBar(),
            InkWell(
              onTap: () => {pickImage()},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  profileWid(),
                  const Positioned(
                    width: 132,
                    height: 132,
                    child: Center(
                      child: Icon(
                        Icons.camera_enhance,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                context.watch<AuthContext>().user.name,
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Text(
              context.watch<AuthContext>().user.getEmail,
              style: const TextStyle(fontSize: 15),
            ),
            Container(
              child: optionsWid(),
              margin: const EdgeInsets.only(top: 35),
            ),
          ],
        ));
  }

  Widget navBar() {
    var name = context.watch<AuthContext>().user.name.split(' ');
    final fnameContlr = TextEditingController();
    final lnameContlr = TextEditingController();
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(15),
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
          "Profile",
          style: TextStyle(fontSize: 32),
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext cntx) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: inputWid('First Name', (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Please enter something";
                                  }
                                  return null;
                                }, name[0], fnameContlr),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: inputWid('Last Name', (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Please enter something";
                                    }
                                    return null;
                                  }, name[1], lnameContlr)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text("Submit"),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<AuthContext>()
                                          .updateUserName(fnameContlr.text,
                                              lnameContlr.text, email);
                                      Navigator.of(cntx).pop();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Text('Edit'),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0))),
        )
      ]),
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget inputWid(String placeHolder, String? Function(String?)? validation,
      String text, TextEditingController contlr) {
    contlr.text = text;
    return TextFormField(
        controller: contlr,
        validator: validation,
        decoration: InputDecoration(
          label: Text(placeHolder),
        ));
  }

  Widget profileWid() {
    if (context.watch<AuthContext>().user.photoUrl == '' ||
        uploadimage != null) {
      return Container(
        width: 132,
        height: 132,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: profilePic(), fit: BoxFit.fill),
        ),
      );
    }
    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(context.watch<AuthContext>().user.photoUrl),
            fit: BoxFit.fill),
      ),
    );
  }

  ImageProvider<Object> profilePic() {
    if (uploadimage != null) return Image.file(File(uploadimage!.path)).image;
    return Image.network(
            'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png')
        .image;
  }

  Widget optionsWid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        optionTab("Your History", Icons.history),
        optionTab("Terms & Conditions", Icons.file_copy),
        optionTab("Logout", Icons.exit_to_app),
        mySwitch()
      ],
    );
  }

  Widget optionTab(String opt, IconData ic) {
    return InkWell(
      onTap: () {
        if (opt == "Logout") {
          context.read<AuthContext>().logOut(context);
        }
        if (opt == "Your History") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Appointments()));
        }
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 15),
        margin: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromARGB(185, 204, 204, 204)))),
        child: Row(
          children: [
            Icon(
              ic,
              size: 35,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                opt,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mySwitch() {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Constants.PRIMARY_COLOR;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      margin: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(185, 204, 204, 204)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text(
              'Manage Privacy',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Switch(
            // This bool value toggles the switch.
            value: context.watch<AuthContext>().user.isPrivate,
            overlayColor: overlayColor,
            trackColor: trackColor,
            thumbColor: MaterialStateProperty.all<Color>(Colors.black),
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              context.read<AuthContext>().setAndUpdatePrivacy(value);
            },
          )
        ],
      ),
    );
  }
}
