import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learn/method_provider/storage_methods.dart';
import 'package:e_learn/model/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/toast_msg.dart';

class AuthMethod {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.AllUser> getUserDetails() async {
    if (auth.currentUser == null) {
      return const model.AllUser(
        userName: "Sign in to see your profile",
        userEmail: "",
        userUid: "",
        userProfileUrl: "assets/images/user_image.png",
      );
    } else {
      User currentUser = auth.currentUser!;
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(currentUser.uid).get();
      return model.AllUser.fromSnap(snapshot);
    }
  }

  Future<String> signUpUsers({
    required String userName,
    required String userEmail,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );

      String userProfileUrl =
          await StorageMethods().uplaodToStorage("ProfilePics", file, false);

      model.AllUser users = model.AllUser(
        userName: userName,
        userEmail: userEmail,
        userProfileUrl: userProfileUrl,
        userUid: cred.user!.uid,
      );
      await firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(users.toJson());

      res = "success";
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          Utils().toastMsg("User not found");
        } else if (e.code == 'wrong-password') {
          Utils().toastMsg("Incorrect password");
        } else if (e.code == 'invalid-email') {
          Utils().toastMsg("Please check your email");
        } else if (e.code == 'email-already-in-use') {
          Utils().toastMsg("User already exists, try with another email");
        } else if (e.code == 'weak-password') {
          Utils().toastMsg("Please enter more than 6 character password");
        } else {
          Utils().toastMsg("Something went wrong\nplease signup again");
        }
      }
    }
    return res;
  }

  Future<String> loginUsers({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurs";
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          Utils().toastMsg("User not found");
        } else if (e.code == 'wrong-password') {
          Utils().toastMsg("Incorrect password");
        } else if (e.code == 'invalid-email') {
          Utils().toastMsg("Please check your email");
        } else {
          Utils().toastMsg("Something went wrong\nplease login again");
        }
      }
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
