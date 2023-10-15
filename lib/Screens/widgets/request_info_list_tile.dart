import 'package:e_learn/method_provider/methods.dart';
import 'package:e_learn/utils/decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../answer_screen/chat_detail_screen.dart';

class RequestInfoListTile extends StatefulWidget {
  final Map<String, dynamic> snap;
  const RequestInfoListTile({super.key, required this.snap});

  @override
  State<RequestInfoListTile> createState() => _RequestInfoListTileState();
}

class _RequestInfoListTileState extends State<RequestInfoListTile> {
  navToChatDetailScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailScreen(
            request: widget.snap['request'],
            userName: widget.snap['userName'],
            userProfileUrl: widget.snap['userProfileUrl'],
            dateTime: widget.snap['dateTime'],
            userTimeStampId: widget.snap['userTimeStampId'],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await MethodProvider()
            .refreshOneUserData(widget.snap['userTimeStampId']);
        navToChatDetailScreen();
      },
      leading: CircleAvatar(
          radius: 30,
          backgroundColor: greyColor,
          backgroundImage:
              NetworkImage(widget.snap['userProfileUrl'].toString())),
      title: Text(widget.snap['userName'].toString()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.snap['request'].toString()),
        ],
      ),
      isThreeLine: true,
      trailing: Text(
        DateFormat.yMMMd().format(widget.snap['dateTime'].toDate()),
      ),
    );
  }
}
