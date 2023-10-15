import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyController extends GetxController {
  Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>
      allUserResponseSnapshotState =
      Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>(null);

  Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>
      allRequestSnapshotState =
      Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>(null);
  Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>
      allCourseVideoSnapshotState =
      Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>(null);

  Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>
      resourceListForOneUserSnapshotState =
      Rx<AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>?>(null);

  Future<void> allUserResponseFetchData(stream) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await stream;
      allUserResponseSnapshotState.value =
          AsyncSnapshot.withData(ConnectionState.done, snapshot);
    } catch (error) {
      allUserResponseSnapshotState.value =
          AsyncSnapshot.withError(ConnectionState.done, error);
    }
  }

  Future<void> allRequestFetchData(stream) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await stream;
      allRequestSnapshotState.value =
          AsyncSnapshot.withData(ConnectionState.done, snapshot);
    } catch (error) {
      allRequestSnapshotState.value =
          AsyncSnapshot.withError(ConnectionState.done, error);
    }
  }

  Future<void> allCourseVFetchData(stream) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await stream;
      allCourseVideoSnapshotState.value =
          AsyncSnapshot.withData(ConnectionState.done, snapshot);
    } catch (error) {
      allCourseVideoSnapshotState.value =
          AsyncSnapshot.withError(ConnectionState.done, error);
    }
  }

  Future<void> resourceListForOneUserFetchData(stream) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await stream;
      resourceListForOneUserSnapshotState.value =
          AsyncSnapshot.withData(ConnectionState.done, snapshot);
    } catch (error) {
      resourceListForOneUserSnapshotState.value =
          AsyncSnapshot.withError(ConnectionState.done, error);
    }
  }
}
