import 'package:consentify/screens/qrcode.dart';
import 'package:consentify/widgets/settings.dart';
import 'package:consentify/widgets/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:consentify/widgets/new_agreement.dart';

bool isNotification = false;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _children = [
    FAQScreen(),
    NewAgreement(),
    SettingsScreen(),
  ];

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getAppBarTitle(),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  getAppBarTitle() {
    if (_selectedIndex == 0) {
      return Text('FAQs');
    } else if (_selectedIndex == 1) {
      return Text('New Agreement');
    } else {
      return Text('Settings');
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined), label: "FAQs"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
