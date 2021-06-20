import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';
import 'package:mobil_dersi_projesi/core/userviewmodel/user_view_model.dart';
import 'package:mobil_dersi_projesi/utilities/constans.dart';
import 'package:provider/provider.dart';

PlatformException myHata;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email, _sifre;
  final _formKey = GlobalKey<FormState>();

  Widget _buildEmailAndPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 150.0,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: 'E-mail adresinizi giriniz.',
                    hintStyle: kHintTextStyle,
                  ),
                  onSaved: (String girilenEmail) {
                    _email = girilenEmail;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Şifre',
                  style: kLabelStyle,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    hintText: 'Şifrenizi giriniz.',
                    hintStyle: kHintTextStyle,
                  ),
                  onSaved: (String girilenSifre) {
                    _sifre = girilenSifre;
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Şifrenizi mi unuttunuz ?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _emailAndPasswordSignIn(context),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Giriş Yap',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- YA DA -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Şunlarla giriş yap',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => _facebookIleGiris(context),
            AssetImage(
              'assets/logos/facebook-logo.jpg',
            ),
          ),
          _buildSocialBtn(
                () => _googleIleGiris(context),
            AssetImage(
              'assets/logos/google-logo.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hesabınız yok mu? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Kayıt Ol',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Oturum Aç',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailAndPassword(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(context),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(context),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _emailAndPasswordSignIn(BuildContext context) async {
    _formKey.currentState.save();

    final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
    try {
      UserModel _girisYapanUser =
      await _userViewModel.signInWithEmailAndPassword(_email, _sifre);
      if (_girisYapanUser != null)
        print("Oturum açan user id:" + _girisYapanUser.userID.toString());
    }  catch (e) {
      print("Bir hata oluştu"+e.toString());
    }

  }

  void _googleIleGiris(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserModel _user = await _userViewModel.signInWithGoogle();
    if (_user != null) print("Oturum açan user id:" + _user.userID.toString());
  }

  void _facebookIleGiris(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user = await _userViewModel.signInWithFacebook();
      if (_user != null) {
        print("Oturum açan user id:" + _user.userID.toString());
      }
    } on PlatformException catch (e) {
      print("FACEBOOK HATA YAKALANDI :" + e.message.toString());
      myHata = e;
    }
  }
}
