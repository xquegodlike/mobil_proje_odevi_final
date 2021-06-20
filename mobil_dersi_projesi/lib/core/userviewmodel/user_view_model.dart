import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobil_dersi_projesi/core/repository/user_repository.dart';
import 'package:mobil_dersi_projesi/core/services/auth_base.dart';
import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';
import 'package:mobil_dersi_projesi/locator.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  UserModel _user;

  UserModel get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
    notifyListeners();
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      state = ViewState.Busy;
      _user =
          await _userRepository.createUserWithEmailAndPassword(email, password);
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithEmailAndPassword(email, password);
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithFacebook();
      if (_user != null)
        return _user;
      else {
        return null;
      }
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki signOut hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }
  Future<bool> updateUserName(String userID, String yeniUserName) async {
    var sonuc = await _userRepository.updateUserName(userID, yeniUserName);
    if (sonuc) {
      _user.userName = yeniUserName;
    }
    return sonuc;
  }

  Future<String> uploadFile(
      String userID, String fileType, File profilFoto) async {
    var indirmeLinki =
    await _userRepository.uploadFile(userID, fileType, profilFoto);
    return indirmeLinki;
  }
}
