import 'package:cloud_firestore/cloud_firestore.dart';

class AllUser {
  final String userName;
  final String userEmail;
  final String userProfileUrl;
  final String userUid;

  const AllUser({
    required this.userName,
    required this.userEmail,
    required this.userProfileUrl,
    required this.userUid,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'userEmail': userEmail,
        'userProfileUrl': userProfileUrl,
        'userUid': userUid,
      };

  static AllUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data()! as Map<String, dynamic>;
    return AllUser(
      userName: snapshot['userName'],
      userEmail: snapshot['userEmail'],
      userProfileUrl: snapshot['userProfileUrl'],
      userUid: snapshot['userUid'],
    );
  }
}
