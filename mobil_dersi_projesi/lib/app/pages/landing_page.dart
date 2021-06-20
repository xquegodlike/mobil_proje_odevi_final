import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/app/pages/home_page.dart';

import 'package:mobil_dersi_projesi/app/screens/sign_in_page.dart';
import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);
    if (_userViewModel.state == ViewState.Idle) {
      if (_userViewModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(user: _userViewModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

}
