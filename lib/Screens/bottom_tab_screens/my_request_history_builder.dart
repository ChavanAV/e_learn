import 'package:e_learn/widgets/no_data_found.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../resources/getx_method.dart';
import '../../utils/decoration.dart';

class MyRequestHistoryBuilder extends StatelessWidget {
  final String? userUid;
  MyRequestHistoryBuilder({super.key, this.userUid});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final MyController myController = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final snapshot = myController.allRequestSnapshotState.value;
        if (snapshot == null ||
            snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty || auth.currentUser == null) {
          return const NoDataFound(
            showTextForLogin: 'Yes',
          );
        } else {
          var filteredDocuments = snapshot.data!.docs.where((doc) {
            final presentData =
                doc['userUid'].toString().contains(auth.currentUser!.uid);
            return presentData;
          }).toList();
          if (filteredDocuments.isNotEmpty) {
            return ListView.builder(
              itemCount: filteredDocuments.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = filteredDocuments[index].data();
                final request = data['request'].toString();
                final dateTime = data['dateTime'];
                return Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.chat,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      request,
                    ),
                    trailing: Text(
                      DateFormat.yMMMd().format(dateTime.toDate()),
                      style:
                          const TextStyle(fontSize: 16, color: dateTimeColor),
                    ),
                  ),
                );
              },
            );
          } else {
            return const NoDataFound();
          }
        }
      },
    );
  }
}
