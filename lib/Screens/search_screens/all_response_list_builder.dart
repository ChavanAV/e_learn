import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../resources/getx_method.dart';
import '../../utils/decoration.dart';
import '../../widgets/no_data_found.dart';
import '../widgets/document_card.dart';
import '../widgets/response_card.dart';

class AllResponseListBuilder extends StatelessWidget {
  final String? userUid;
  final String? searchText;
  AllResponseListBuilder({super.key, this.userUid, this.searchText});
  final MyController myController = Get.put(MyController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final snapshot = myController.allUserResponseSnapshotState.value;
        if (snapshot == null ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const NoDataFound();
        } else {
          if (searchText != null) {
            var filteredDocuments = snapshot.data!.docs.where((doc) {
              final presentData = doc['answer']
                      .toString()
                      .toLowerCase()
                      .contains(searchText!) ||
                  doc['documentName']
                      .toString()
                      .toLowerCase()
                      .contains(searchText!);
              return presentData;
            }).toList();
            if (filteredDocuments.isNotEmpty) {
              return ListView.builder(
                  itemCount: filteredDocuments.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index].data();
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
                      case ('.jpg' || '.png' || '.jpeg'):
                        {
                          return ResponseCard(
                            userName: userName,
                            answer: answer,
                            dateTime: dateTime,
                            profileUrl: profileUrl,
                            myChild: Image.network(
                              documentUrl,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
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
            } else {
              return const NoDataFound();
            }
          } else if (userUid != null) {
            if (auth.currentUser != null) {
              var filteredDocuments = snapshot.data!.docs.where((doc) {
                final presentData =
                    doc['userUid'].toString().contains(userUid!);
                return presentData;
              }).toList();
              if (filteredDocuments.isNotEmpty) {
                return ListView.builder(
                    itemCount: filteredDocuments.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final document = filteredDocuments[index].data();
                      final documentName = document['documentName'].toString();
                      final userName = document['userName'].toString();
                      final answer = document['answer'].toString();
                      final profileUrl = document['userProfileUrl'].toString();
                      final documentUrl = document['documentUrl'].toString();
                      final requestSenderUserName =
                          document['requestSenderUserName'].toString();

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
                                requestSenderUserName: requestSenderUserName,
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
                              requestSenderUserName: requestSenderUserName,
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
                              requestSenderUserName: requestSenderUserName,
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
                              requestSenderUserName: requestSenderUserName,
                              myChild: DocumentCard(
                                documentName: documentName,
                                color: pptColor,
                                documentUrl: documentUrl,
                                documentType: 'PPT',
                              ),
                            );
                          }
                        case ('.jpg' || '.png' || '.jpeg'):
                          {
                            return ResponseCard(
                              userName: userName,
                              answer: answer,
                              dateTime: dateTime,
                              profileUrl: profileUrl,
                              requestSenderUserName: requestSenderUserName,
                              myChild: Image.network(
                                documentUrl,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
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
                              requestSenderUserName: requestSenderUserName,
                              myChild: Container(),
                            );
                          }
                      }
                      return Container();
                    });
              } else {
                return const NoDataFound();
              }
            } else {
              return const NoDataFound(
                showTextForLogin: 'Yes',
              );
            }
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
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
                    case ('.jpg' || '.png' || '.jpeg'):
                      {
                        return ResponseCard(
                          userName: userName,
                          answer: answer,
                          dateTime: dateTime,
                          profileUrl: profileUrl,
                          myChild: Image.network(
                            documentUrl,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
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
        }
      },
    );
  }
}
