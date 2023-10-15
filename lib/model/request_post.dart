import 'package:cloud_firestore/cloud_firestore.dart';

class RequestPost {
  final String request;
  final String userName;
  final String userProfileUrl;
  final String userUid;
  final String userTimeStampId;
  final DateTime dateTime;

  RequestPost({
    required this.request,
    required this.userName,
    required this.userProfileUrl,
    required this.dateTime,
    required this.userUid,
    required this.userTimeStampId,
  });

  Map<String, dynamic> toJson() => {
        'request': request,
        'userName': userName,
        'userProfileUrl': userProfileUrl,
        'dateTime': dateTime,
        'userUid': userUid,
        'userTimeStampId': userTimeStampId,
      };

  static RequestPost fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return RequestPost(
      request: snap['request'],
      userName: snap['userName'],
      userProfileUrl: snap['userProfileUrl'],
      dateTime: snap['dateTime'],
      userUid: snap['userUid'],
      userTimeStampId: snap['userTimeStampId'],
    );
  }
}
