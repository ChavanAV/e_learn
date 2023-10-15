import 'package:cloud_firestore/cloud_firestore.dart';

class CoursePost {
  final String courseFileName;
  final String courseFileUrl;
  final String thumbnailUrl;
  final String documentDescription;
  final String userUid;
  CoursePost({
    required this.courseFileName,
    required this.courseFileUrl,
    required this.thumbnailUrl,
    required this.userUid,
    required this.documentDescription,
  });

  Map<String, dynamic> toJson() => {
        'courseFileName': courseFileName,
        'courseFileUrl': courseFileUrl,
        'thumbnailUrl': thumbnailUrl,
        'userUid': userUid,
        'documentDescription': documentDescription,
      };

  static CoursePost fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data()! as Map<String, dynamic>;
    return CoursePost(
      courseFileName: snap['courseFileName'],
      courseFileUrl: snap['courseFileUrl'],
      thumbnailUrl: snap['thumbnailUrl'],
      userUid: snap['userUid'],
      documentDescription: snap['documentDescription'],
    );
  }
}
