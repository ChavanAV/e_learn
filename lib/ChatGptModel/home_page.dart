import 'package:flutter/material.dart';

import 'api_services.dart';
import 'chat_model.dart';
import 'colors.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  AiPageState createState() => AiPageState();
}

class AiPageState extends State<AiPage> {
  TextEditingController textEditingController = TextEditingController();

  bool isListening = false;
  bool isTyping = false;

  var text = "Start conversation";

  final List<ChatMsg> messages = [];

  var scrollController = ScrollController();

  void sendMsg() {
    text = textEditingController.text.toString();
    setState(() {
      textEditingController.clear();
      isTyping = true;
    });
    messages.add(ChatMsg(text: text, type: ChatMsgType.user));
    getMsg();
  }

  void getMsg() async {
    var mesg = await ApiServices.sendMsg(text);
    setState(() {
      messages.add(ChatMsg(text: mesg, type: ChatMsgType.bot));
      isTyping = false;
    });
  }

  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 30,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "What AI Says",
            style: TextStyle(color: Colors.purple),
          ),
        ),
        backgroundColor: chatbgclr,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                    flex: 9,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                        color: chatbgclr,
                      ),
                      child: ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: ((context, index) {
                            var chat = messages[index];
                            return chatBubble(
                              chatText: chat.text,
                              type: chat.type,
                            );
                          })),
                    )),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: 50,
                //   margin: const EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(.7),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         flex: 5,
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 10.0),
                //           child: TextField(
                //             controller: textEditingController,
                //             cursorColor: Colors.black45,
                //             decoration: const InputDecoration(
                //               border: InputBorder.none,
                //               focusedBorder: InputBorder.none,
                //               hintText: "Ask anything !!!",
                //             ),
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: sendMsg,
                //         splashColor: Colors.cyan.shade300,
                //         splashRadius: 25,
                //         icon: const Icon(Icons.send, color: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            if (isTyping) const CircularProgressIndicator(color: Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget chatBubble({required chatText, required ChatMsgType? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: (type == ChatMsgType.user)
              ? const AssetImage("assets/images/images.png")
              : const AssetImage("assets/images/robotnew.jpg"),
          backgroundColor: bgclr,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: (type == ChatMsgType.user)
                    ? Colors.orange.shade100
                    : Colors.teal.shade200,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: Text(chatText),
          ),
        ),
      ],
    );
  }
}
