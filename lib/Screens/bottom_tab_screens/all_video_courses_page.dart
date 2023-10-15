import 'package:e_learn/utils/decoration.dart';
import 'package:flutter/material.dart';

import 'all_course_video_builder.dart';

class AllVideoCoursePage extends StatelessWidget {
  const AllVideoCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Explore Courses.!!!",
            style: exploreCourseTextStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: AllCourseVideoBuilder(),
          ),
        ],
      ),
    );
  }
}
