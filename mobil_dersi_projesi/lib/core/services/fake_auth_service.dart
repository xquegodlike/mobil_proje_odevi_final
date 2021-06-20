
import 'package:mobil_dersi_projesi/core/services/auth_base.dart';
import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "123123123123123213123123123";

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email,
      String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            UserModel(
                userID: "created_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> currentUser() async {
    return await Future.value(
        UserModel(userID: userID, email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email,
      String password) async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            UserModel(
                userID: "signIn_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            UserModel(
                userID: "facebook_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            UserModel(
                userID: "google_user_id_123456", email: "fakeuser@fake.com"));
  }

  @override
  Future<bool> signOut()  {
    return Future.value(true);
  }
}