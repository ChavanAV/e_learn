import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../method_provider/methods.dart';
import '../../method_provider/storage_methods.dart';
import '../../model/user.dart';
import '../../resources/firestore_methods.dart';
import '../../resources/user_provider.dart';
import '../../utils/toast_msg.dart';
import '../widgets/upload_content_widget.dart';

class SendAnswerScreen extends StatefulWidget {
  final String userTimeStampId;
  final String requestSenderUserName;
  const SendAnswerScreen(
      {super.key,
      required this.userTimeStampId,
      required this.requestSenderUserName});

  @override
  State<SendAnswerScreen> createState() => _SendAnswerScreenState();
}

class _SendAnswerScreenState extends State<SendAnswerScreen> {
  final TextEditingController answerController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  PlatformFile? allDocFile;
  String? documentUrl;
  String? documentName;
  @override
  void dispose() {
    super.dispose();
    answerController.dispose();
  }

  void sendAnswer(
    String answer,
    String userName,
    String userProfileUrl,
    String userTimeStampId,
    String requestSenderUserName,
    String userUid,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (allDocFile != null) {
        String? url = await StorageMethods()
            .uploadFile(File(allDocFile!.path!), 'documents');
        setState(() {
          documentUrl = url!;
          documentName = allDocFile!.name;
        });
      } else {
        setState(() {
          documentUrl = "No Document";
          documentName = "No File";
        });
      }

      String res = await FireStoreMethods().uploadAnswerToRequest(
        answer,
        userName,
        userProfileUrl,
        userTimeStampId,
        documentUrl!,
        documentName!,
        requestSenderUserName,
        userUid,
      );
      if (res == "success") {
        String historyRes = await FireStoreMethods().uploadAnswerHistory(
          answer,
          userName,
          userProfileUrl,
          userUid,
          documentUrl!,
          documentName!,
          requestSenderUserName,
        );
        if (historyRes == "success") {
          setState(() {
            isLoading = false;
            answerController.clear();
            allDocFile = null;
          });
          Utils().toastMsg("Posted Successfully");
        } else {
          setState(() {
            isLoading = false;
          });
          Utils().toastMsg("Something went wrong\ntry again later.");
        }
      } else {
        setState(() {
          isLoading = false;
        });
        Utils().toastMsg("Something went wrong\ntry again later.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().toastMsg("Something went wrong\ntry again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final AllUser user = Provider.of<UserProvider>(context).getUser!;
    return UploadContentWidget(
      isVideoUploadScreen: "No",
      selectFileText: "Attach File",
      appBarBtnName: "Post",
      welcomeText: "Send Your Answer !!!",
      hintText: 'Enter answer',
      selectFileIcon: const Icon(
        Icons.attach_file_outlined,
        size: 50,
        color: Color(0XFFF97B22),
      ),
      appBarBtnPress: () {
        if (answerController.text.isNotEmpty) {
          sendAnswer(
            answerController.text.toString(),
            user.userName,
            user.userProfileUrl,
            widget.userTimeStampId,
            widget.requestSenderUserName,
            user.userUid,
          );
        } else {
          Utils().toastMsg("Enter Text");
        }
      },
      onTapForSelectFile: () async {
        allDocFile = await MethodProvider().pickFile([
          'pdf',
          'jpg',
          'jpeg',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'ppt',
          'pptx',
          'txt',
          'mp4',
        ]);
      },
      textEditingController: answerController,
      isLoading: isLoading,
    );
  }
}
