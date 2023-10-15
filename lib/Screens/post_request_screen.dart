import 'package:e_learn/model/user.dart';
import 'package:e_learn/resources/user_provider.dart';
import 'package:e_learn/utils/toast_msg.dart';
import 'package:e_learn/widgets/floating_action_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../method_provider/methods.dart';
import '../resources/firestore_methods.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController requestController = TextEditingController();
  bool isLoading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    requestController.dispose();
  }

  void sendRequest(
    String request,
    String userName,
    String userProfileUrl,
    String userUid,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods()
          .uploadRequest(request, userName, userProfileUrl, userUid);
      if (res == "success") {
        setState(() {
          isLoading = false;
          requestController.clear();
        });
        Utils().toastMsg("Posted Successfully");
      } else {
        setState(() {
          isLoading = false;
        });
        Utils().toastMsg(res);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().toastMsg(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final AllUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "What things you want to learn enter below",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextField(
                  controller: requestController,
                  maxLines: null, // Allow multiple lines
                  decoration: const InputDecoration(
                    hintText: 'Enter statement',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionBtn(
          press: () {
            if (requestController.text.isNotEmpty) {
              auth.currentUser == null
                  ? MethodProvider().loginBottomSheet(context)
                  : sendRequest(
                      requestController.text.toString(),
                      user!.userName,
                      user.userProfileUrl,
                      user.userUid,
                    );
            } else {
              Utils().toastMsg("Enter Request");
            }
          },
        ));
  }
}
