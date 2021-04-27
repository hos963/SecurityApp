import 'package:Metropolitane/WebArea/MainDashBoardWeb/DashBoardButton.dart';
import 'package:Metropolitane/WebArea/MainDashBoardWeb/SideMenu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class MainDashBoardWeb extends StatefulWidget {
  @override
  _MainDashBoardWebState createState() => _MainDashBoardWebState();
}

class _MainDashBoardWebState extends State<MainDashBoardWeb> {
  var ref = FirebaseStorage.instance
      .ref()
      .child('buuilding')
      .child("084a6f7b-51c8-46c2-aacb-be1c3904e7773607146362878351087.jpg");

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
          title: Text(
        "Admin DashBoard",
        style: TextStyle(color: Colors.white),
      )),
      drawer: MediaQuery.of(context).size.width < 500
          ? Drawer(
              child: SideMenu(),
            )
          : null,
      body: SafeArea(
          child: Center(
              child: MediaQuery.of(context).size.width < 500
                  ? DashBoardButtonsContent()
                  : Row(children: [
                      Container(width: 200.0, child: SideMenu()),
                      Container(
                          width: MediaQuery.of(context).size.width - 200.0,
                          child: DashBoardButtonsContent())
                    ]))));
}
