import 'models/models.dart';

abstract class UserRepository {
  Stream<MyUser?> get user;

  Future<void> signIn(String email, String password);

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> logOut();

  Future<void> setUserData(MyUser myUser);

  Future<void> resetPassword(String email);
}
