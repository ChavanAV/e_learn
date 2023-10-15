import 'package:e_learn/Screens/bottom_tab_screens/all_video_courses_page.dart';
import 'package:e_learn/Screens/setting_screen.dart';
import 'package:e_learn/Screens/splash_screen.dart';
import 'package:e_learn/method_provider/auth_method.dart';
import 'package:e_learn/model/user.dart';
import 'package:e_learn/utils/toast_msg.dart';
import 'package:e_learn/widgets/floating_action_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../method_provider/methods.dart';
import '../resources/user_provider.dart';
import '../utils/decoration.dart';
import 'bottom_tab_screens/all_request_builder.dart';
import 'bottom_tab_screens/my_request_history_builder.dart';
import 'drawer_screens/my_contribution_screen.dart';
import 'drawer_screens/upload_course_screen.dart';
import 'post_request_screen.dart';
import 'search_screens/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Widget> pages = [
    AllRequestBuilder(),
    const AllVideoCoursePage(),
    MyRequestHistoryBuilder(),
  ];
  @override
  Widget build(BuildContext context) {
    final AllUser? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            width: 270,
            backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .floatingActionButtonTheme
                              .backgroundColor),
                      margin: EdgeInsets.zero,
                      currentAccountPicture: (auth.currentUser != null)
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user!.userProfileUrl),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(user!.userProfileUrl),
                            ),
                      accountName: Text(
                        user.userName,
                      ),
                      accountEmail: Text(user.userEmail),
                    ),
                    (auth.currentUser == null)
                        ? Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: TextButton(
                                onPressed: () {
                                  MethodProvider().loginBottomSheet(context);
                                },
                                child: const Text(
                                  "Sign in",
                                )),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UploadCourseScreen(),
                        ));
                  },
                  style: ListTileStyle.drawer,
                  title: const Text("Upload Course",
                      style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.cloud_upload_outlined, size: 25),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyContributionScreen(),
                        ));
                  },
                  style: ListTileStyle.drawer,
                  title: const Text("My Contribution",
                      style: TextStyle(fontSize: 16)),
                  leading: const Icon(
                    Icons.handshake_outlined,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingScreen()),
                    );
                  },
                  style: ListTileStyle.drawer,
                  title: const Text("Settings", style: TextStyle(fontSize: 16)),
                  leading:
                      const Icon(Icons.settings_suggest_outlined, size: 30),
                ),
                ListTile(
                  onTap: () {
                    if (auth.currentUser != null) {
                      AuthMethod().signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false,
                        );
                      }).onError((error, stackTrace) {
                        Utils().toastMsg("Something went wrong");
                      });
                    } else {
                      Utils().toastMsg("You are not Signed in !!!");
                    }
                  },
                  style: ListTileStyle.drawer,
                  title: const Text("Sign out", style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          color: Theme.of(context).indicatorColor,
          strokeWidth: 3,
          displacement: 70,
          onRefresh: () async {
            await MethodProvider().refreshAllUserData();
          },
          child: pages[currentIndex],
        ),
        bottomNavigationBar: StylishBottomBar(
          hasNotch: true,
          fabLocation: StylishBarFabLocation.end,
          currentIndex: currentIndex,
          elevation: 20,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          onTap: (index) async {
            setState(() {
              currentIndex = index;
            });
          },
          option: AnimatedBarOptions(
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
          ),
          items: [
            BottomBarItem(
              unSelectedColor: Colors.grey,
              selectedColor: orangeColor,
              icon: const Icon(
                Icons.house_outlined,
              ),
              title: const Text('Home'),
            ),
            BottomBarItem(
              unSelectedColor: Colors.grey,
              selectedColor: orangeColor,
              icon: const Icon(
                Icons.app_registration_rounded,
              ),
              title: const Text('Courses'),
            ),
            BottomBarItem(
                unSelectedColor: Colors.grey,
                selectedColor: orangeColor,
                icon: const Icon(
                  Icons.history,
                ),
                title: const Text('History')),
          ],
        ),
        floatingActionButton: FloatingActionBtn(
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostScreen(),
                ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }
}
