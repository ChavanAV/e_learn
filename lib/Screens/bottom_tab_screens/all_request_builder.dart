import 'package:e_learn/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/getx_method.dart';
import '../widgets/request_info_list_tile.dart';

class AllRequestBuilder extends StatelessWidget {
  final String? searchText;
  AllRequestBuilder({
    super.key,
    this.searchText,
  });
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final snapshot = myController.allRequestSnapshotState.value;
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
            final presentData = doc['userName']
                    .toString()
                    .toLowerCase()
                    .contains(searchText!) ||
                doc['request'].toString().toLowerCase().contains(searchText!);
            return presentData;
          }).toList();
          if (filteredDocuments.isNotEmpty) {
            return ListView.builder(
                itemCount: filteredDocuments.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return RequestInfoListTile(
                    snap: filteredDocuments[index].data(),
                  );
                });
          } else {
            return const NoDataFound();
          }
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return RequestInfoListTile(
                  snap: snapshot.data!.docs[index].data(),
                );
              });
        }
      }
    });
  }
}
