import 'package:e_learn/Screens/search_screens/all_response_list_builder.dart';
import 'package:flutter/material.dart';

import '../bottom_tab_screens/all_course_video_builder.dart';
import '../bottom_tab_screens/all_request_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textEditingController = TextEditingController();
  String searchText = '';
  final List<Tab> tabs = [
    const Tab(text: 'Requests'),
    const Tab(text: 'Courses'),
    const Tab(text: 'Resources'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  searchText = '';
                  textEditingController.clear();
                });
              },
              icon: const Icon(Icons.close),
            ),
          ],
          title: TextField(
            controller: textEditingController,
            autofocus: true,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            AllRequestBuilder(searchText: searchText),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AllCourseVideoBuilder(searchText: searchText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AllResponseListBuilder(searchText: searchText),
            ),
          ],
        ),
      ),
    );
  }
}
