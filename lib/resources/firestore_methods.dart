import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learn/model/answer_post.dart';
import 'package:e_learn/model/course_post.dart';
import 'package:e_learn/model/request_post.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  var dateTime = DateTime.now();
  Future<String> uploadRequest(
    String request,
    String userName,
    String userProfileUrl,
    String userUid,
  ) async {
    String res = "Some error occurs";
    try {
      RequestPost requestPost = RequestPost(
        request: request,
        userName: userName,
        userProfileUrl: userProfileUrl,
        dateTime: dateTime,
        userUid: userUid,
        userTimeStampId: id,
      );
      _firestore.collection('requestPosts').doc(id).set(requestPost.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadAnswerToRequest(
    String answer,
    String userName,
    String userProfileUrl,
    String userTimeStampId,
    String documentUrl,
    String documentName,
    String requestSenderUserName,
    String userUid,
  ) async {
    String res = "Some error occurs";
    try {
      AnswerPosts answerPosts = AnswerPosts(
          answer: answer,
          userUid: userUid,
          userName: userName,
          userProfileUrl: userProfileUrl,
          dateTime: dateTime,
          documentUrl: documentUrl,
          documentName: documentName,
          requestSenderUserName: requestSenderUserName);
      _firestore
          .collection('requestPosts')
          .doc(userTimeStampId)
          .collection('answerPosts')
          .doc(id)
          .set(answerPosts.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadAnswerHistory(
    String answer,
    String userName,
    String userProfileUrl,
    String userUid,
    String documentUrl,
    String documentName,
    String requestSenderUserName,
  ) async {
    String res = "Some error occurs";
    try {
      AnswerPosts answerPosts = AnswerPosts(
        answer: answer,
        userUid: userUid,
        userName: userName,
        userProfileUrl: userProfileUrl,
        dateTime: dateTime,
        documentUrl: documentUrl,
        documentName: documentName,
        requestSenderUserName: requestSenderUserName,
      );
      _firestore.collection('history').doc(id).set(answerPosts.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadCourses(
    String courseFileName,
    String courseFileUrl,
    String thumbnailUrl,
    String userUid,
    String documentDescription,
  ) async {
    String res = "Some error occurs";
    try {
      CoursePost coursePost = CoursePost(
        courseFileName: courseFileName,
        courseFileUrl: courseFileUrl,
        thumbnailUrl: thumbnailUrl,
        userUid: userUid,
        documentDescription: documentDescription,
      );
      _firestore.collection('courseVideos').doc(id).set(coursePost.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
