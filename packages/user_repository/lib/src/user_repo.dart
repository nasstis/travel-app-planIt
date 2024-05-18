import 'dart:io';

import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;

  Future<void> signIn(String email, String password);

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> logOut();

  Future<void> setUserData(MyUser myUser);

  Future<void> resetPassword(String email);

  Future<MyUser> authWithGoogle();

  Future<void> signInWithFacebook();

  Future<List<String>> getHistory();

  Future<void> addToHistory(String id);

  Future<MyUser> editPhoto(File photo);

  Future<MyUser> editProfile({
    required String name,
    required String email,
  });

  Future<void> deleteAccount();
}
