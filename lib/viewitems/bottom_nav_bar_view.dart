import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/chat_page.dart';
import 'package:we_chat_app/pages/contact_page.dart';
import 'package:we_chat_app/pages/moment_page.dart';
import 'package:we_chat_app/pages/profile_page.dart';
import 'package:we_chat_app/pages/setting_page.dart';
import 'package:we_chat_app/resources/colors.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  void initState() {
    _pages = [
      const MomentPage(),
      const ChatPage(),
      const ContactPage(),
      const ProfilePage(),
      const SettingPage()
    ];
    super.initState();
  }

  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: PRIMARY_COLOR,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "Moment",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/chat_icon.png",
              width: 25, color: _currentIndex == 1 ? PRIMARY_COLOR : null,
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/contact_icon.png",
              width: 25, color: _currentIndex == 2 ? PRIMARY_COLOR : null,
            ),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/profile_icon.png",
              width: 25, color: _currentIndex == 3 ? PRIMARY_COLOR : null,
            ),
            label: "Me",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/setting_icon.png",
              width: 25, color: _currentIndex == 4 ? PRIMARY_COLOR : null,
            ),
            label: "Setting",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
