
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobil_dersi_projesi/core/services/auth_base.dart';

import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';

class FirebaseAuthService extends AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(_userCredential.user);
    } catch (e) {
      debugPrint("Firebase Auth " "Kullanıcı Oluştururken" "bir hata oluştu");
    }
  }

  @override
  Future<UserModel> currentUser() async {
    User _user = await _firebaseAuth.currentUser;
    if (_user != null) {
      return _userFromFirebase(_user);
    } else {
      debugPrint("Firebase Auth  Şuan ki Kullanıcı bir hata oluştu");
      return null;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(_userCredential.user);
    } catch  (e) {
      debugPrint("Firebase Auth " "Kullanıcı Girişi" "bir hata oluştu");
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _facebookLogin = FacebookLogin();
      await _facebookLogin.logOut();

      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("Firebase Auth  Çıkış yaparken bir hata oluştu");
      return false;
    }
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    } else {
      return UserModel(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    FacebookLogin _facebookLogin = FacebookLogin();
    FacebookLoginResult _loginResult =
    await _facebookLogin.logIn(['public_profile', 'email']);
    switch (_loginResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_loginResult.accessToken != null &&
            _loginResult.accessToken.isValid()) {
          UserCredential _userCredential = await _firebaseAuth
              .signInWithCredential(FacebookAuthProvider.credential(
              _loginResult.accessToken.token));
          User _user = _userCredential.user;
          return _userFromFirebase(_user);
        } else {
          print("access token valid :" +
              _loginResult.accessToken.isValid().toString());
        }

        break;

      case FacebookLoginStatus.cancelledByUser:
        print("kullanıcı facebook girişi iptal etti");
        break;

      case FacebookLoginStatus.error:
        print("Hata cıktı :" + _loginResult.errorMessage);
        break;
    }

    return null;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.accessToken != null && _googleAuth.idToken != null) {
        UserCredential _userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
            idToken: _googleAuth.idToken,
            accessToken: _googleAuth.accessToken));
        User _user = _userCredential.user;
        return _userFromFirebase(_user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
