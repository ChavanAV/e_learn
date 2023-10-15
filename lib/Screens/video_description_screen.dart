import 'package:flutter/material.dart';

import '../method_provider/methods.dart';
import '../utils/decoration.dart';

class VideoDescriptionScreen extends StatelessWidget {
  final String? videoThumbnailUrl;
  final String videoDocumentUrl;
  final String documentName;
  final Color videoCardBgColor;
  final String documentDescription;
  const VideoDescriptionScreen(
      {super.key,
      this.videoThumbnailUrl,
      required this.videoDocumentUrl,
      required this.documentName,
      required this.videoCardBgColor,
      required this.documentDescription});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enjoy The Course !!!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                MethodProvider().openDocument(videoDocumentUrl);
              },
              child: Container(
                width: size.width,
                height: 200,
                // margin: const EdgeInsets.all(10),
                decoration: (videoThumbnailUrl == null)
                    ? BoxDecoration(
                        color: videoCardBgColor,
                        borderRadius: BorderRadius.circular(20),
                      )
                    : BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(videoThumbnailUrl!),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                child: const Icon(
                  Icons.play_circle_outline,
                  size: 50,
                  color: videoIconColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Text(
              documentName,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  documentDescription,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
