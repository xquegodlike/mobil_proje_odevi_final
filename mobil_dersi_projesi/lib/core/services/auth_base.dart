import 'package:mobil_dersi_projesi/core/usermodel/user_model.dart';

abstract class AuthBase{
  Future<UserModel> currentUser();
  Future<UserModel> createUserWithEmailAndPassword(String email, String password);
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<bool> signOut();
}