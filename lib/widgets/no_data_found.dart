import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String? showTextForLogin;
  const NoDataFound({super.key, this.showTextForLogin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(children: [
      (showTextForLogin == 'Yes')
          ? Padding(
              padding: EdgeInsets.only(top: size.height - 650),
              child: const Text(
                "Sign in to see your content",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            )
          : Container(padding: EdgeInsets.only(top: size.height - 670)),
      (showTextForLogin == 'Yes')
          ? Container()
          : const Text(
              "No data found...",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
      Center(child: Image.asset("assets/images/course_not_found_icon.png")),
    ]);
  }
}
