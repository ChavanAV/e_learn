import 'dart:math';

import 'package:e_learn/Screens/widgets/response_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../resources/getx_method.dart';
import '../../../utils/decoration.dart';
import '../../../widgets/no_data_found.dart';
import '../widgets/document_card.dart';

class ResourceListBuilderForOneRequestSender extends StatelessWidget {
  ResourceListBuilderForOneRequestSender({super.key});
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final snapshot = myController.resourceListForOneUserSnapshotState.value;
        if (snapshot == null ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return const NoDataFound();
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final documentName = document['documentName'].toString();
                final userName = document['userName'].toString();
                final answer = document['answer'].toString();
                final profileUrl = document['userProfileUrl'].toString();
                final documentUrl = document['documentUrl'].toString();
                final dateTime = document['dateTime'];
                final randomColor = Color(Random().nextInt(0xFFFFFFFF));
                String extension = path.extension(documentName);
                if (documentName == 'No File') {
                  extension = 'No File';
                }
                switch (extension) {
                  case ('.mp4'):
                    {
                      return ResponseCard(
                          userName: userName,
                          answer: answer,
                          dateTime: dateTime,
                          profileUrl: profileUrl,
                          myChild: DocumentCard(
                            documentName: documentName,
                            color: randomColor,
                            documentUrl: documentUrl,
                            documentType: 'VID',
                          ));
                    }
                  case ('.pdf'):
                    {
                      return ResponseCard(
                        userName: userName,
                        answer: answer,
                        dateTime: dateTime,
                        profileUrl: profileUrl,
                        myChild: DocumentCard(
                          documentName: documentName,
                          color: pdfColor,
                          documentUrl: documentUrl,
                          documentType: 'PDF',
                        ),
                      );
                    }
                  case ('.docx' || '.doc'):
                    {
                      return ResponseCard(
                        userName: userName,
                        answer: answer,
                        dateTime: dateTime,
                        profileUrl: profileUrl,
                        myChild: DocumentCard(
                          documentName: documentName,
                          color: docColor,
                          documentUrl: documentUrl,
                          documentType: 'DOC',
                        ),
                      );
                    }
                  case ('.pptx' || '.ppt'):
                    {
                      return ResponseCard(
                        userName: userName,
                        answer: answer,
                        dateTime: dateTime,
                        profileUrl: profileUrl,
                        myChild: DocumentCard(
                          documentName: documentName,
                          color: pptColor,
                          documentUrl: documentUrl,
                          documentType: 'PPT',
                        ),
                      );
                    }
                  case ('.jpg'):
                    {
                      return ResponseCard(
                        userName: userName,
                        answer: answer,
                        dateTime: dateTime,
                        profileUrl: profileUrl,
                        myChild: Image.network(
                          documentUrl,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Text(
                              'Image failed to load\ncheck your connection',
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      );
                    }
                  case ('No File'):
                    {
                      return ResponseCard(
                        userName: userName,
                        answer: answer,
                        dateTime: dateTime,
                        profileUrl: profileUrl,
                        myChild: Container(),
                      );
                    }
                }
                return Container();
              });
        }
      },
    );
  }
}
