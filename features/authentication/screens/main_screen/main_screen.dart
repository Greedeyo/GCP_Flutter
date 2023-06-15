import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:gcp/src/features/authentication/screens/plants_list_screen/plants_list_screen.dart';
import 'package:gcp/src/features/authentication/screens/user_screen/user_screen.dart';
import '../../../../constants/text_strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;

  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    PlantsListScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      if (_selectedIndex != 0) {
        _onItemTapped(0);
        return Future.value(false);
      } else {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("'뒤로' 버튼을 한 번 더 누르면 종료됩니다",
                style: TextStyle(color: Colors.white, fontSize: 15)),
            duration: Duration(seconds: 3),
            elevation: 6.0,
            margin: EdgeInsets.symmetric(horizontal: 43, vertical: 20),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house, size: 20.0),
            label: tBottomNavigationHome,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pagelines, size: 25.0),
            label: tBottomNavigationList,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser, size: 20.0),
            label: tBottomNavigationUser,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    ));
  }
}
