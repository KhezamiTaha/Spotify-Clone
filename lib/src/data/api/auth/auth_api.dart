import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/src/data/models/auth/user_model.dart';
import "package:firebase_auth/firebase_auth.dart";

abstract class AuthApi {
  Future<Either> register(UserModel user);
  Future<Either> signin(UserModel user);
}


@Singleton(as: AuthApi)
class AuthApiImp extends AuthApi {
  @override
  Future<Either> register(UserModel user) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        "fullName": user.fullName,
        "email": user.email,
        "favoriteSongs": <String>[],
      });

      return Right("Firebase register was done successfully!");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "The password is Weak";
      }
      if (e.code == "email-already-in-use") {
        message = "This email is already associated with another account";
      } else {
        message = e.code;
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signin(UserModel user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      return Right("Firebase sign in was done successfully!");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "invalid-credential") {
        message = "Invalid email or password. Please try again.";
      } else {
        message = e.code;
      }
      return Left(message);
    }
  }
}
