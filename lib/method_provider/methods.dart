import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../resources/getx_method.dart';
import '../utils/decoration.dart';
import '../utils/toast_msg.dart';
import '../widgets/login_bottom_sheet_element.dart';

class MethodProvider {
  PlatformFile? file;
  final history = FirebaseFirestore.instance.collection('history');
  final courseVideos = FirebaseFirestore.instance.collection('courseVideos');
  final requestPosts = FirebaseFirestore.instance.collection('requestPosts');
  final MyController myController = Get.put(MyController());

  Future<PlatformFile?> pickFile(List<String> allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      file = result.files.single;
      return file;
    } else {
      return null;
    }
  }

  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

  void loginBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: bottomSheetShape,
      enableDrag: true,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return const LoginBottomSheetElement();
      },
    );
  }

  Future<void> openDocument(String documentUrl) async {
    if (!await launchUrlString(
      documentUrl,
      mode: LaunchMode.externalApplication,
    )) {
      Utils().toastMsg('$documentUrl not fund');
    }
  }

  Future<void> refreshAllUserData() async {
    await myController.allRequestFetchData(
        requestPosts.orderBy('dateTime', descending: true).get());
    await myController.allCourseVFetchData(courseVideos.get());
    myController.allUserResponseFetchData(
        history.orderBy('dateTime', descending: true).get());
  }

  Future<void> refreshOneUserData(String userTimeStampId) async {
    await myController.resourceListForOneUserFetchData(requestPosts
        .doc(userTimeStampId)
        .collection('answerPosts')
        .orderBy('dateTime', descending: true)
        .get());
  }
}
