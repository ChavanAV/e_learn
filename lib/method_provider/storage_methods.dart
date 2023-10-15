import 'dart:io';
import 'dart:typed_data';

import 'package:e_learn/utils/toast_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uplaodToStorage(
      String childName, Uint8List file, isPost) async {
    Reference ref =
        firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);
    if (isPost) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> uploadFile(File file, String childName) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      // Create a reference to the desired location in Firebase Storage
      Reference ref = firebaseStorage
          .ref()
          .child(childName)
          .child(file.path.split('/').last);
      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      // Retrieve the download URL of the uploaded file
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      Utils().toastMsg("Something went wrong\ntry again later.");
    }
  }
}
