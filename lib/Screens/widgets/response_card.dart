import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learn/utils/decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResponseCard extends StatelessWidget {
  final String userName;
  final String answer;
  final Timestamp dateTime;
  final String profileUrl;
  final String? requestSenderUserName;
  final Widget myChild;
  const ResponseCard(
      {super.key,
      required this.userName,
      required this.answer,
      required this.dateTime,
      required this.profileUrl,
      required this.myChild,
      this.requestSenderUserName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.surfaceTintColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (requestSenderUserName != null)
                    ? const Text(
                        "To :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    : CircleAvatar(
                        radius: 25, backgroundImage: NetworkImage(profileUrl)),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: Text(
                      (requestSenderUserName != null)
                          ? requestSenderUserName.toString()
                          : userName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16)),
                ),
                Expanded(child: Container()),
                Text(
                  DateFormat.yMMMd().format(dateTime.toDate()),
                  style: const TextStyle(color: dateTimeColor),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(answer,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: myChild,
          )
        ],
      ),
    );
  }
}
