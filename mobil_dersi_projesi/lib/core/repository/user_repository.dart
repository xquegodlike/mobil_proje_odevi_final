import 'dart:io';

import 'package:mobil_dersi_projesi/core/services/auth_base.dart';
import 'package:mobil_dersi_projesi/core/services/fake_auth_service.dart';
import 'package:mobil_dersi_projesi/core/services/firebase_auth_service.dart';
import 'package:mobil_dersi_projesi/core/services/firebase_storage_service.dart';
import 'package:mobil_dersi_projesi/core/services/firestore_db_service.dart';
import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';
import 'package:mobil_dersi_projesi/locator.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =
  locator<FakeAuthenticationService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
  locator<FirebaseStorageService>();


  AppMode appMode = AppMode.RELEASE;

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.createUserWithEmailAndPassword(
          email, password);
    } else {
      UserModel _user = await _firebaseAuthService
          .createUserWithEmailAndPassword(email, password);
      bool _sonuc = await _firestoreDBService.saveUser(_user);
      if (_sonuc) {
        return await _firestoreDBService.readUser(_user.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.currentUser();
    } else {
      UserModel _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _firestoreDBService.readUser(_user.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithEmailAndPassword(
          email, password);
    } else {
      UserModel _user = await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);
      return await _firestoreDBService.readUser(_user.userID);
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithFacebook();
    } else {
      UserModel _user = await _firebaseAuthService.signInWithFacebook();
      if (_user != null) {
        bool _sonuc = await _firestoreDBService.saveUser(_user);
        if(_sonuc){
          return await _firestoreDBService.readUser(_user.userID);
        }else{
          await _firebaseAuthService.signOut();
          return null;
        }
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signInWithGoogle();
    } else {
      UserModel _user = await _firebaseAuthService.signInWithGoogle();
      if (_user != null) {
        bool _sonuc = await _firestoreDBService.saveUser(_user);
        if(_sonuc){
          return await _firestoreDBService.readUser(_user.userID);
        }else{
          await _firebaseAuthService.signOut();
          return null;
        }
      } else {
        return null;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _fakeAuthenticationService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    if (appMode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreDBService.updateUserName(userID, yeniUserName);
    }
  }

  Future<String> uploadFile(
      String userID, String fileType, File profilFoto) async {
    if (appMode == AppMode.DEBUG) {
      return "dosya_indirme_linki";
    } else {
      var profilFotoURL = await _firebaseStorageService.uploadFile(
          userID, fileType, profilFoto);
      await _firestoreDBService.updateProfilFoto(userID, profilFotoURL);
      return profilFotoURL;
    }
  }
}
