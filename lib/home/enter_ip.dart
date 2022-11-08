import 'package:flutter/material.dart';
import 'package:nexus/Widgets/my_textfield.dart';
import 'package:nexus/Widgets/new_button.dart';
import 'package:nexus/Widgets/splash_screen.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/globalVariable.dart';
import 'package:nexus/home/home_page.dart';
import 'package:nexus/main.dart';
import 'package:nexus/util/colors.dart';
import 'package:nexus/util/constants.dart';

class EnterIp extends StatefulWidget {
  const EnterIp({Key? key}) : super(key: key);

  @override
  _EnterIpState createState() => _EnterIpState();
}

class _EnterIpState extends State<EnterIp> {
  final linkController = TextEditingController(text: "192.168.43.43");

  bool splash = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay(2000).then((value) {
      setState(() {
        splash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: splash
            ? const SplaceScreen()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFiled(controller: linkController, hint: "Enter Ip"),
                  NewButton(
                      margin: EdgeInsets.all(constants.defaultPadding),
                      context: context,
                      buttonText: "Submit",
                      function: () async {
                        if (linkController.text.trim().isEmpty) {
                          showSnackbar(context, "Enter Link Ip", colorError);
                          return;
                        }
                        await prefs.setString(
                            LocalStorage.enterLink, linkController.text.trim());
                        nextPage(context, const HomePage());
                      })
                ],
              ));
  }
}
