import 'package:flutter/material.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LeftSide.dart';
import 'package:Metropolitane/WebArea/LoginWeb/rightSide.dart';

class LoginWebPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0)),
        elevation: 5.0,
        child: Container(
          height: 700,
          width: 1500,
          child: RightSide()
        ),
      ),
    );
  }
}
