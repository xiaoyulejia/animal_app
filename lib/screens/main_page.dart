import 'package:animal_app/screens/community_pages/community_page.dart';
import 'package:animal_app/screens/user_pages/account_screen.dart';
import 'package:animal_app/screens/animal_pages/favorite_screen.dart';
import 'package:animal_app/screens/animal_pages/home_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    CommunityPage(),
    // Center(
    //   child: Text("message person"),
    // ),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed, // 修复底栏icon大于3个无法显示的bug
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "主页"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "喜爱"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountScreen())),
                  child: Icon(Icons.person)),
              label: "账号"),
        ],
      ),
    );
  }
}
