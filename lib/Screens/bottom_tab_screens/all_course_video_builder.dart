import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/getx_method.dart';
import '../../widgets/no_data_found.dart';
import '../widgets/videoCourseCard.dart';

class AllCourseVideoBuilder extends StatelessWidget {
  final String? searchText;
  final String? userUid;
  AllCourseVideoBuilder({super.key, this.searchText, this.userUid});
  final MyController myController = Get.put(MyController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final snapshot = myController.allCourseVideoSnapshotState.value;
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
            final presentData = doc['courseFileName']
                .toString()
                .toLowerCase()
                .contains(searchText!);
            return presentData;
          }).toList();
          if (filteredDocuments.isNotEmpty) {
            return GridView.builder(
              itemCount: filteredDocuments.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 7,
              ),
              itemBuilder: (context, index) {
                final data = filteredDocuments[index].data();
                final documentName = data['courseFileName'].toString();
                final documentUrl = data['courseFileUrl'].toString();
                final documentDescription =
                    data['documentDescription'].toString();
                String? thumbnailUrl = data['thumbnailUrl'].toString();
                final randomColor = Color(Random().nextInt(0xFFFFFFFF));
                if (thumbnailUrl == 'No Thumbnail') {
                  thumbnailUrl = null;
                }
                return VideoCourseCard(
                  videoCardBgColor: randomColor,
                  videoDocumentUrl: documentUrl,
                  videoThumbnailUrl: thumbnailUrl,
                  documentName: documentName,
                  documentDescription: documentDescription,
                );
              },
            );
          } else {
            return const NoDataFound();
          }
        } else if (userUid != null) {
          if (auth.currentUser != null) {
            var filteredDocuments = snapshot.data!.docs.where((doc) {
              final presentData = doc['userUid'].toString().contains(userUid!);
              return presentData;
            }).toList();
            if (filteredDocuments.isNotEmpty) {
              return GridView.builder(
                itemCount: filteredDocuments.length,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 7,
                ),
                itemBuilder: (context, index) {
                  final data = filteredDocuments[index].data();
                  final documentName = data['courseFileName'].toString();
                  final documentUrl = data['courseFileUrl'].toString();
                  final documentDescription =
                      data['documentDescription'].toString();
                  String? thumbnailUrl = data['thumbnailUrl'].toString();
                  final randomColor = Color(Random().nextInt(0xFFFFFFFF));
                  if (thumbnailUrl == 'No Thumbnail') {
                    thumbnailUrl = null;
                  }
                  return VideoCourseCard(
                    videoCardBgColor: randomColor,
                    videoDocumentUrl: documentUrl,
                    videoThumbnailUrl: thumbnailUrl,
                    documentName: documentName,
                    documentDescription: documentDescription,
                  );
                },
              );
            } else {
              return const NoDataFound();
            }
          } else {
            return const NoDataFound(
              showTextForLogin: 'Yes',
            );
          }
        } else {
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 9 / 7,
            ),
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              final documentName = data['courseFileName'].toString();
              final documentUrl = data['courseFileUrl'].toString();
              final documentDescription =
                  data['documentDescription'].toString();
              String? thumbnailUrl = data['thumbnailUrl'].toString();
              final randomColor = Color(Random().nextInt(0xFFFFFFFF));
              if (thumbnailUrl == 'No Thumbnail') {
                thumbnailUrl = null;
              }
              return VideoCourseCard(
                videoCardBgColor: randomColor,
                videoDocumentUrl: documentUrl,
                videoThumbnailUrl: thumbnailUrl,
                documentName: documentName,
                documentDescription: documentDescription,
              );
            },
          );
        }
      }
    });
  }
}
