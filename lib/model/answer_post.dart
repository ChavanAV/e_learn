import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerPosts {
  final String answer;
  final String userName;
  final String requestSenderUserName;
  final String userProfileUrl;
  final DateTime dateTime;
  final String documentUrl;
  final String documentName;
  final String userUid;
  AnswerPosts({
    required this.answer,
    required this.userName,
    required this.userProfileUrl,
    required this.dateTime,
    required this.documentUrl,
    required this.documentName,
    required this.requestSenderUserName,
    required this.userUid,
  });

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'userName': userName,
        'userProfileUrl': userProfileUrl,
        'dateTime': dateTime,
        'documentUrl': documentUrl,
        'documentName': documentName,
        'requestSenderUserName': requestSenderUserName,
        'userUid': userUid,
      };

  static AnswerPosts fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data()! as Map<String, dynamic>;
    return AnswerPosts(
      answer: snap['answer'],
      userName: snap['userName'],
      userProfileUrl: snap['userProfileUrl'],
      dateTime: snap['dateTime'],
      documentUrl: snap['documentUrl'],
      documentName: snap['documentName'],
      requestSenderUserName: snap['requestSenderUserName'],
      userUid: snap['userUid'],
    );
  }
}
