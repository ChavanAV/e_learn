import 'package:e_learn/widgets/select_file_squar_btn.dart';
import 'package:flutter/material.dart';

import '../../utils/decoration.dart';

class UploadContentWidget extends StatelessWidget {
  final String selectFileText;
  final String appBarBtnName;
  final String welcomeText;
  final String hintText;
  final String? hintTextForDocDescription;
  final String isVideoUploadScreen;
  final Widget selectFileIcon;
  final void Function() appBarBtnPress;
  final void Function() onTapForSelectFile;
  final void Function()? onTapForSelectThumbnail;
  final TextEditingController textEditingController;
  final TextEditingController? documentDescriptionController;
  final bool isLoading;
  const UploadContentWidget(
      {super.key,
      required this.selectFileText,
      required this.appBarBtnName,
      required this.welcomeText,
      required this.hintText,
      required this.selectFileIcon,
      required this.appBarBtnPress,
      required this.onTapForSelectFile,
      required this.textEditingController,
      required this.isLoading,
      required this.isVideoUploadScreen,
      this.onTapForSelectThumbnail,
      this.documentDescriptionController,
      this.hintTextForDocDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        actions: [
          GestureDetector(
            onTap: appBarBtnPress,
            child: Container(
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [orangeColor, Color(0XFFCB3737)])),
                child: Text(
                  appBarBtnName,
                  style: requestResourceTextStyle,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            isLoading
                ? const LinearProgressIndicator(
                    color: Colors.deepOrangeAccent,
                  )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            Text(
              welcomeText,
              style: requestResourceTextStyle,
            ),
            SizedBox(
              height: (isVideoUploadScreen == 'Yes') ? 10 : 100,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            )),
            (isVideoUploadScreen == 'Yes')
                ? Expanded(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: documentDescriptionController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: hintTextForDocDescription,
                            border: const UnderlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ))
                : Container(),
            Row(
              mainAxisAlignment: (isVideoUploadScreen == 'Yes')
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                SelectFileSquareBtn(
                  selectFileText: selectFileText,
                  selectFileIcon: selectFileIcon,
                  onTapForSelectFile: onTapForSelectFile,
                ),
                (isVideoUploadScreen == 'Yes')
                    ? SelectFileSquareBtn(
                        selectFileText: "Select Thumbnail",
                        selectFileIcon: const Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Color(0XFFF97B22),
                        ),
                        onTapForSelectFile: onTapForSelectThumbnail!,
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
