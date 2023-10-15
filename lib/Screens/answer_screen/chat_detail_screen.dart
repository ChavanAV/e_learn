import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learn/Screens/answer_screen/send_answer_screen.dart';
import 'package:e_learn/method_provider/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/decoration.dart';
import 'response_list_builder_For_one_user.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userName;
  final String userProfileUrl;
  final String request;
  final String userTimeStampId;
  final Timestamp dateTime;
  ChatDetailScreen({
    super.key,
    required this.userName,
    required this.userProfileUrl,
    required this.request,
    required this.dateTime,
    required this.userTimeStampId,
  });

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(userProfileUrl),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).indicatorColor,
        strokeWidth: 3,
        displacement: 70,
        onRefresh: () async {
          await MethodProvider().refreshOneUserData(userTimeStampId);
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Request', style: requestResourceTextStyle),
                      Text(
                        DateFormat.yMMMd().format(dateTime.toDate()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(request,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(thickness: 2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Resources', style: requestResourceTextStyle),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ResourceListBuilderForOneRequestSender(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    auth.currentUser == null
                        ? MethodProvider().loginBottomSheet(context)
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SendAnswerScreen(
                                  requestSenderUserName: userName,
                                  userTimeStampId: userTimeStampId),
                            ));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Contribute"),
                      Icon(
                        Icons.send_outlined,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
