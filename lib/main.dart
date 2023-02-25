import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leaveworkung/states/main_home_admin.dart';
import 'package:leaveworkung/states/main_home_officer.dart';
import 'package:leaveworkung/states/sign_in.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/signin',
    page: () => const SignIn(),
  ),
  GetPage(
    name: '/admin',
    page: () => const MainHomeAdmin(),
  ),
  GetPage(
    name: '/officer',
    page: () => const MainHomeOfficer(),
  ),
];

String name = '/signin';

Future<void> main() async {
  HttpOverrides.global = MyHttpOveride();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: getPages,
      initialRoute: name,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class MyHttpOveride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
