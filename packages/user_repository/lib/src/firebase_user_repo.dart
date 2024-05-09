import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'user_repo.dart';
import 'models/models.dart';
import 'entities/entities.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await userCollection.doc(firebaseUser.uid).get().then(
              (value) => MyUser.fromEntity(
                MyUserEntity.fromDocument(value.data()!),
              ),
            );
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await userCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> authWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return MyUser.empty;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);

      return MyUser(
          userId: user.user!.uid,
          name: googleUser.displayName ?? googleUser.email,
          email: googleUser.email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    try {
      final loginResult = await FacebookAuth.instance.login();

      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> getHistory() async {
    final userId = _firebaseAuth.currentUser!.uid;
    final List<String> history = await userCollection
        .doc(userId)
        .get()
        .then((doc) => doc.data()!['recentlyViewed'].cast<String>());
    return history;
  }

  @override
  Future<void> addToHistory(String id) async {
    final userId = _firebaseAuth.currentUser!.uid;
    final List<String> history = await userCollection
        .doc(userId)
        .get()
        .then((doc) => doc.data()!['recentlyViewed'].cast<String>());
    if (history.length == 6) {
      history.removeAt(0);
    }
    history.add(id);
    userCollection.doc(userId).update({'recentlyViewed': history});
  }
}
