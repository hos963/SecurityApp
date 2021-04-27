import 'package:flutter/material.dart';
import 'package:Metropolitane/Pages/EventScreen/EventScreen.dart';
import 'package:Metropolitane/Pages/HomeScreen/HomeScreen.dart';
import 'package:Metropolitane/Pages/SettingpageScreen/SettingSceen.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(), EventScreen(), SettingScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          iconSize: 40,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          backgroundColor: Color.fromRGBO(51, 51, 51, 100),
          onTap: onTabTapped,
          // new
          currentIndex: _currentIndex,
          // new
          items: [
            new BottomNavigationBarItem(
              icon: new Image.asset('assets/images/homeicon.png',height: 42,width: 42,color:Colors.white,),
              title: Text('Home',style: TextStyle(fontSize: 18),),
            ),
            new BottomNavigationBarItem(
              icon: new Image.asset('assets/images/eventicon.png',height: 42,width: 42,color:Colors.white,),
              title: Text('Event',style: TextStyle(fontSize: 18),),
            ),
            new BottomNavigationBarItem(
              icon: new Image.asset('assets/images/settingicon.png',height: 42,width: 42,color:Colors.white,),
              title: Text('Setting',style: TextStyle(fontSize: 18),),

            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
