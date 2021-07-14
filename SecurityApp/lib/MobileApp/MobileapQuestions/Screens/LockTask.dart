import 'dart:convert';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/Questions/OnWayScreen.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:Metropolitane/model/AddLockModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizDetails.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizNewList.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizSearch.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/LockQuestionsSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/model/QuizModels.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizConstant.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizDataGenerator.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizExtension.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:Metropolitane/Router/router.dart' as Router;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LockTask extends StatefulWidget {
  static String tag = '/QuizHome';

  @override
  _QuizLockState createState() => _QuizLockState();

}

class _QuizLockState extends State<LockTask> {
  List<NewQuizModel> mListings;

  // FirebaseUserData firebaseUserData;
  // String dateselected;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // gettingData();
    //dateselected = gettingdateTodaydate();
    mListings = getQuizData();
    super.initState();
  }

  String gettingdateTodaydate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  Future<FirebaseUserData> gettingData() async {
    String usercompletedata =
    await PreferenceUtils.getString(PrefKey.UserCompleteData, null);

    Map<String, dynamic> user = jsonDecode(usercompletedata);

    FirebaseUserData firebaseUserData = new FirebaseUserData.fromJson(user);
    return firebaseUserData;
  }

  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  var progress;

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      progress = ProgressHUD.of(context);
      return Builder(builder: (context) => getingBodyMain(context));
    }));
  }

  Widget getingBodyMain(BuildContext context) {
    return Scaffold(
      backgroundColor: quiz_app_background,
      body: FutureBuilder(
          future: gettingData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
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
                              isLongText: true,
                              isCentered: true),
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.all(16.0),
                            decoration: boxDecoration(
                                radius: 10,
                                showShadow: true,
                                bgColor: quiz_white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: quizEditTextStyle(
                                        selectedDate.toLocal().toString(),
                                        isPassword: false,
                                        isenable: false)),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: boxDecoration(
                                      radius: 10,
                                      showShadow: false,
                                      bgColor: quiz_colorPrimary),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.calendar_today,
                                      color: quiz_white),
                                ).onTap(() {
                                  // launchScreen(context, QuizSearch.tag);
                                  // setState(() {});

                                  // Navigator.pushNamed(
                                  //     context, Router.QuizSearchroute);

                                  _selectDate(context);
                                })
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                text(quiz_lbl_new_quiz,
                                    textAllCaps: true,
                                    fontFamily: fontMedium,
                                    fontSize: textSizeNormal),
                                text(
                                  quiz_lbl_view_all,
                                  textColor: quiz_textColorSecondary,
                                ).onTap(() {
                                  // setState(() {
                                  //   launchScreen(context, QuizListing.tag);
                                  // });

                                  // Navigator.pushNamed(
                                  //     context, Router.QuizListingroute);
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            //height: MediaQuery.of(context).size.width * 0.8,
                            height: 350,
                            child: GettingListFinallyy(snapshot.data.udid),
                          ).paddingOnly(bottom: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text("");
            }
          }),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    var formatter = new DateFormat('yyyy-MM-dd');

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        String formattedDate = formatter.format(picked);
        //dateselected = formattedDate;
        selectedDate = picked;
      });
  }

  ListView GettingListCards(List<AddLockModel> listofalrm) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: listofalrm.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          // launchScreen(context, QuizDetails.tag);
        },
        child: AlarmCard(listofalrm[index], index),
      ),
    );
  }

  Widget GettingListFinallyy(String userid) {
    var nextdate = new DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day + 1);
    var currentdate =
    new DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('LockAlert')
            .where("firebaseUserData.udid", isEqualTo: userid)
            .where("futuretask", isGreaterThanOrEqualTo: currentdate.toUtc())
            .where("futuretask", isLessThan: nextdate.toUtc())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              if (snapshot.data.docChanges.length == 0) {
                return Text("No Records Found");
              }
              int index = 0;

              List<AddLockModel> listofalrm =
              List<AddLockModel>.empty(growable: true);
              snapshot.data.docChanges.forEach((element) {
                //UsersPost.fromDoc(element.doc);


                AddLockModel addLockModel =      AddLockModel.fromDoc(element.doc);
                if(addLockModel.state != 3){
                  listofalrm.add(addLockModel);

                }

                index++;
              });

              return GettingListCards(listofalrm);
          }
        });
  }
}

class AlarmCard extends StatelessWidget {
  AddLockModel model;

  Color bordercolor = Colors.white;

  AlarmCard(AddLockModel model, int pos) {
    this.model = model;
    if (model.state == 2) {
      bordercolor = CustomColors.orangecolor;
    } else if (model.state == 3) {
      bordercolor = Colors.green;
    } else {
      bordercolor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 16),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: boxDecoration(
          radius: 16,
          showShadow: true,
          bgColor: quiz_white,
          color: bordercolor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                Text(
                  "Title:",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: quiz_textColorSecondary),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    model.lockTitle,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: quiz_textColorSecondary),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                Text(
                  "Location:",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: quiz_textColorSecondary),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    model.latlong,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: quiz_textColorSecondary),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                Text(
                  "Description:",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: quiz_textColorSecondary),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    model.lockDesc,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: quiz_textColorSecondary),
                  ),
                ),
              ],
            ),
          ),
          // Stack(
          //   alignment: Alignment.topRight,
          //   children: <Widget>[
          //     ClipRRect(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(16.0),
          //           topRight: Radius.circular(16.0)),
          //       child: CachedNetworkImage(
          //           imageUrl: "https://i.guim.co.uk/img/media/99e1d9cd17c07db550e430f7924612624b700ec0/0_0_5558_3335/master/5558.jpg?width=1020&quality=45&auto=format&fit=max&dpr=2&s=fa90e62e4f067c9a7d2a59f80426d5bb",
          //           height: w * 0.4,
          //           width: MediaQuery.of(context).size.width * 0.75,
          //           fit: BoxFit.cover),
          //     ),
          //   ],
          // ),

          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          AddingdataToStartquestionare(model, context);

                        },
                        child: Text(
                          'Select Task',
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: quiz_colorPrimary,
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: quiz_colorPrimary)),
                            textStyle: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.normal)),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextButton(
                        onPressed: () async {
                          /*AddingdataToStartquestionare(model, context);*/

                          String location = model.latlong.toString();

                          String label = "Shanghai Tower",
                              query = '$location($label)';
                          final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

                          await launch(uri.toString());
                        },
                        child: Text(
                          'View track',
                        ),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: quiz_colorPrimary,
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: quiz_colorPrimary)),
                            textStyle: TextStyle(
                                fontSize: 20, fontStyle: FontStyle.normal)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> AddingdataToStartquestionare(
      AddLockModel addLockModel, BuildContext context) async {

    if(addLockModel.state == 3){

    }else {
      if (addLockModel.state == 1) {
        final progress = ProgressHUD.of(context);
        progress.show();
        FirebaseService firebaseService = new FirebaseService();
        addLockModel.state = 2;
        await firebaseService.UpdateLock(addLockModel);
        progress.dismiss();

        MovetoDetailPutScreen(addLockModel, context);
      } else {
        MovetoDetailPutScreen(addLockModel, context);
      }
    }
  }


  void MovetoDetailPutScreen( AddLockModel addLockModel, BuildContext context){

    Navigator.pushNamed(context, Router.LockQuestionsSurveyroute,arguments: addLockModel);

  }

}
