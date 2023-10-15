import 'package:e_learn/Screens/video_description_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/decoration.dart';

class VideoCourseCard extends StatelessWidget {
  final String? videoThumbnailUrl;
  final String videoDocumentUrl;
  final String documentName;
  final Color videoCardBgColor;
  final String documentDescription;
  const VideoCourseCard({
    super.key,
    required this.videoThumbnailUrl,
    required this.documentName,
    required this.videoDocumentUrl,
    required this.videoCardBgColor,
    required this.documentDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoDescriptionScreen(
                videoCardBgColor: videoCardBgColor,
                videoDocumentUrl: videoDocumentUrl,
                documentName: documentName,
                videoThumbnailUrl: videoThumbnailUrl,
                documentDescription: documentDescription,
              ),
            ));
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                documentName,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: videoCourseNameTextStyle(Theme.of(context).primaryColor),
              ),
            ),
            const Icon(
              Icons.play_circle_outline,
              size: 50,
              color: videoIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
