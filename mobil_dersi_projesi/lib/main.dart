import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobil_dersi_projesi/app/pages/landing_page.dart';

import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:mobil_dersi_projesi/locator.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: backGroundColor,
    statusBarColor: backGroundColor,
    statusBarBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        title: 'Bitirme Projesi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        bottomAppBarColor: backGroundColor,
            primarySwatch: Colors.purple
        ),
        home: LandingPage(),
      ),
    );
  }
}
