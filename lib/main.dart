// @dart=2.9
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nexus/home/enter_ip.dart';
import 'package:nexus/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globalVariable.dart';

SharedPreferences prefs;
const String appName = "Potato App";

Future<void> backgroundHandler(RemoteMessage message) async {
  customPrint(message.data.toString());
  customPrint(message.notification.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // FirebaseMessageApi.initialize();
  // FirebaseMessageApi.handleMessage();
  runApp(const MyApp());
}

// Dell Laptop

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); //force portrait mode
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData(
              primarySwatch: colorCustom,
              fontFamily: "poppins",
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
            // home: const HomePage(),
            home: const EnterIp(),
            // home: const HomePage(),
          );
        });
  }
}
