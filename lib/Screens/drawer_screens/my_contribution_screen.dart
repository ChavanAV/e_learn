import 'package:e_learn/Screens/bottom_tab_screens/all_course_video_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../../resources/user_provider.dart';
import '../search_screens/all_response_list_builder.dart';

class MyContributionScreen extends StatefulWidget {
  const MyContributionScreen({super.key});

  @override
  State<MyContributionScreen> createState() => _MyContributionScreenState();
}

class _MyContributionScreenState extends State<MyContributionScreen> {
  final TextEditingController textEditingController = TextEditingController();
  int selectedIndex = 0;
  final List<Tab> tabs = [
    const Tab(text: 'Responses'),
    const Tab(text: 'Video Courses'),
  ];

  @override
  Widget build(BuildContext context) {
    final AllUser? user = Provider.of<UserProvider>(context).getUser;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Contribution",
              style: TextStyle(fontWeight: FontWeight.w400)),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AllResponseListBuilder(userUid: user!.userUid),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AllCourseVideoBuilder(userUid: user.userUid),
            ),
          ],
        ),
      ),
    );
  }
}
