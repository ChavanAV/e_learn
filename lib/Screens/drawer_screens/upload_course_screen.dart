import 'dart:io';

import 'package:e_learn/method_provider/methods.dart';
import 'package:e_learn/model/user.dart';
import 'package:e_learn/resources/user_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../method_provider/storage_methods.dart';
import '../../resources/firestore_methods.dart';
import '../../utils/toast_msg.dart';
import '../widgets/upload_content_widget.dart';

class UploadCourseScreen extends StatefulWidget {
  const UploadCourseScreen({super.key});

  @override
  State<UploadCourseScreen> createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourseScreen> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController documentDescriptionController =
      TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  PlatformFile? videoCourseFile;
  PlatformFile? thumbnailFile;
  String? courseFileUrl;
  String? thumbnailUrl;
  String? courseName;
  @override
  void dispose() {
    super.dispose();
    courseNameController.dispose();
    documentDescriptionController.dispose();
  }

  void uploadCourseVideo(String videoCourseName, String userUid,
      String documentDescription) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (videoCourseFile != null) {
        String? getCourseUrl = await StorageMethods()
            .uploadFile(File(videoCourseFile!.path!), 'video_courses');
        setState(() {
          courseFileUrl = getCourseUrl!;
          courseName = videoCourseName;
        });
      } else {
        Utils().toastMsg("Select Course Video");
      }

      if (thumbnailFile != null) {
        String? getThumbnailUrl = await StorageMethods()
            .uploadFile(File(thumbnailFile!.path!), 'video_thumbnails');
        setState(() {
          thumbnailUrl = getThumbnailUrl!;
        });
      } else {
        setState(() {
          thumbnailUrl = "No Thumbnail";
        });
      }

      String res = await FireStoreMethods().uploadCourses(courseName!,
          courseFileUrl!, thumbnailUrl!, userUid, documentDescription);
      if (res == "success") {
        setState(() {
          isLoading = false;
          courseNameController.clear();
          documentDescriptionController.clear();
          videoCourseFile = null;
          thumbnailFile = null;
        });
        Utils().toastMsg("Course Successfully Uploaded");
      } else {
        setState(() {
          isLoading = false;
        });
        Utils().toastMsg(res);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().toastMsg(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AllUser? user = Provider.of<UserProvider>(context).getUser;
    return UploadContentWidget(
      hintTextForDocDescription: "Enter course description",
      documentDescriptionController: documentDescriptionController,
      isVideoUploadScreen: 'Yes',
      onTapForSelectThumbnail: () async {
        thumbnailFile = await MethodProvider().pickFile(['jpg', 'jpeg', 'png']);
      },
      selectFileText: "Select Video",
      appBarBtnName: "Upload",
      welcomeText: "Upload Video Course",
      hintText: "Enter Course Name",
      selectFileIcon: const Icon(
        Icons.video_camera_back_outlined,
        size: 50,
        color: Color(0XFFF97B22),
      ),
      appBarBtnPress: () {
        if (auth.currentUser != null) {
          if (courseNameController.text.isNotEmpty &&
              documentDescriptionController.text.isNotEmpty &&
              videoCourseFile != null) {
            uploadCourseVideo(courseNameController.text.toString(),
                user!.userUid, documentDescriptionController.text.toString());
          } else {
            Utils().toastMsg("Enter course name, description and select video");
          }
        } else {
          MethodProvider().loginBottomSheet(context);
          setState(() {
            videoCourseFile = null;
            thumbnailFile = null;
          });
        }
      },
      onTapForSelectFile: () async {
        videoCourseFile = await MethodProvider().pickFile(['mp4']);
      },
      textEditingController: courseNameController,
      isLoading: isLoading,
    );
  }
}
