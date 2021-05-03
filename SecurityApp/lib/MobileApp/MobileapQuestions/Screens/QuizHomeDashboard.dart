import 'dart:convert';

import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/PatolTask.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/PropertyInspection.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizDashboard.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizHome.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/UnLockTask.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppConstant.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/LockTask.dart';

import 'package:Metropolitane/Router/router.dart' as Router;

class QuizHomeDashboard extends StatefulWidget {
  @override
  _QuizHomeDashboardState createState() => _QuizHomeDashboardState();
}


Future<FirebaseUserData> gettingData() async {
  String usercompletedata =
  await PreferenceUtils.getString(PrefKey.UserCompleteData, null);

  Map<String, dynamic> user = jsonDecode(usercompletedata);

  FirebaseUserData firebaseUserData = new FirebaseUserData.fromJson(user);
  return firebaseUserData;
}

class _QuizHomeDashboardState extends State<QuizHomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: gettingData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SafeArea(
              child: Column(
                children:<Widget> [
                  SizedBox(height: 50),
                  text(
                      quiz_lbl_hi_antonio +
                          " " +
                          (snapshot.data == null
                              ? ""
                              : snapshot.data.name),
                      fontFamily: fontBold,
                      fontSize: textSizeXLarge),
                  text(
                      quiz_lbl_what_would_you_like_to_learn_n_today_search_below,
                      textColor: quiz_textColorSecondary,
                      isCentered: true),
                  SizedBox(height: 50),
                  Expanded(child:  GridView.count(
                    //using gridview so that the buttons will show every screen. If they exceed the screen height the button are scrollable.
                    childAspectRatio: 1.27,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 0.0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: [
                      HomeTileButton(
                          text: 'Alarm',
                          icon: Image.asset(
                            "assets/images/AddAlarm.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => QuizDashboard()));
                          }),
                      HomeTileButton(
                          text: 'Patrol',
                          icon: Image.asset(
                            "assets/images/shield.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => PatrolTask()));
                          }),
                      HomeTileButton(
                          text: 'Lock',
                          icon: Image.asset(
                            "assets/images/lock.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => LockTask()));
                          }),
                      HomeTileButton(
                          text: 'UnLock',
                          icon: Image.asset(
                            "assets/images/unlock.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => UnLockTask()));
                          }),
                      HomeTileButton(
                          text: 'Property Inspection',
                          icon: Image.asset(
                            "assets/images/building.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  { //PropertyInspection
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => PropertyInspection()));
                          }),
                    ],
                  ),),
                ],
              ),
            );
          }
          else {
            return Text("");
          }
        },
      )
    );
  }

}

class HomeTileButton extends StatelessWidget {
  const HomeTileButton({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120.0,
        width: 140.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, 5),
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}