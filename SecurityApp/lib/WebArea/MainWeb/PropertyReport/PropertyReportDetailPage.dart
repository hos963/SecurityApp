import 'package:Metropolitane/model/PropertyInspectionQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PropertyReportDetailPage extends StatelessWidget {


  PropertyInspectionQuestionareModel questionareModel;
  PropertyReportDetailPage(@required this.questionareModel);

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            centerTitle: true,
            title: Text(
              'Report Detail',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: drawerBgColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.print,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something

                  //   //printAllData();
                  // ///  Navigator.push(context, pdfpreview());
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Reportpdfpreview(questionareModel)));
                  //  // MaterialPageRoute(builder: (context) => pdfpreview());

                  Screenshotclick();

                },
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child:  Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                          child: Text(
                            "On the way Survey",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.onwayModel == null ? "" :  questionareModel.onwayModel.ontheWay.toString()  + " at time "+    questionareModel.onwayModel.onawytimestamp.toDate().toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Reached On Site",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      //  "yes reached at time 12/12/12 12:12 pm",

                      questionareModel.reachedonSiteModel == null ? "" :  questionareModel.reachedonSiteModel.reachedonsite.toString() + " at time "+  questionareModel.reachedonSiteModel.reachedtimestamp.toDate().toString(),

                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "External Building Picture ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.externalImageScreenModel
                              !=
                              null
                              ? questionareModel.externalImageScreenModel.externalImageScreenModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),
                    // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.externalImageScreenModel
                          !=
                          null
                          ? questionareModel.externalImageScreenModel.timestampextpic.toDate().toString()
                          :"",

                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Do You Have Keys or Code for Access.?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.havekeys != null ? questionareModel.havekeys.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Is Building Secure?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.isbuildingsecure != null ? questionareModel.isbuildingsecure.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Is Building has working alarm.?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.isbuildingsecure != null ? questionareModel.isbuildingsecure.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Water Leakage.?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.anyWaterLeaking != null ? questionareModel.anyWaterLeaking.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Is Electric Meter Present.?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.electricMeterPresent != null ? questionareModel.electricMeterPresent.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Electric Meter Picture ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.electricMeterPictureModel
                              !=
                              null
                              ? questionareModel.electricMeterPictureModel.electricMeterPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),

                    // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Is There any Gas Meter .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.gasMeterPresent != null ? questionareModel.gasMeterPresent.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Gas Meter Picture ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.gasMeterPictureModel
                              !=
                              null
                              ? questionareModel.gasMeterPictureModel.gasMeterPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Is There any Water Meter .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.waterMeterPresent != null ? questionareModel.waterMeterPresent.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Water Meter Picture ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.waterMeterPictureModel
                              !=
                              null
                              ? questionareModel.waterMeterPictureModel.waterMeterPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Damage to Property .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.anyDamageToProperty != null ? questionareModel.anyDamageToProperty.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Property Damage Picture ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.anyDamageToPropertyPicModel
                              !=
                              null
                              ? questionareModel.anyDamageToPropertyPicModel.anyDamageToPropertyPicModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Introders Outside .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.AnyIntrudersOutside != null ? questionareModel.AnyIntrudersOutside.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Worker Outside .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.AnyWorkerOutside != null ? questionareModel.AnyWorkerOutside.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Graftii Needs Removal .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.AnyGraffitiNeedRemoval != null ? questionareModel.AnyGraffitiNeedRemoval.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Drug Use Onsite .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.AnyDrugUseOutside != null ? questionareModel.AnyDrugUseOutside.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Any Health And Safety Issue .?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.AnyHealthAndSafetyIssues != null ? questionareModel.AnyHealthAndSafetyIssues.toString() :" ",
                      style: TextStyle(fontSize: 20),
                    ),




                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Internal  Pictures ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.take1stInternalPicturesModel
                              !=
                              null
                              ? questionareModel.take1stInternalPicturesModel.take1stInternalPicturesModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.take2ndInternalPictureModel
                              !=
                              null
                              ? questionareModel.take2ndInternalPictureModel.take2ndInternalPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.take3rdInternalPictureModel
                              !=
                              null
                              ? questionareModel.take3rdInternalPictureModel.take3rdInternalPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.take4thInternalPictureModel
                              !=
                              null
                              ? questionareModel.take4thInternalPictureModel.take4thInternalPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        width: 400,
                        child: FadeInImage(
                          width: 400,
                          height: 400,
                          image: NetworkImage(questionareModel.take5thInternalPictureModel
                              !=
                              null
                              ? questionareModel.take5thInternalPictureModel.take5thInternalPictureModel
                              : ""),
                          placeholder: AssetImage("assets/images/placeholder.png"),
                        )),



                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Specific Insructions ",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.SpecificInstructions == null ? "" :  questionareModel.SpecificInstructions .toString() ,

                      style: TextStyle(fontSize: 20),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Job Completed.?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.jobCompletedModel == null ? "" :  questionareModel.jobCompletedModel.jobcompleted.toString() +" at time"+ questionareModel.jobCompletedModel.onawytimestamp.toDate().toString()  ,

                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),


                  ],
                ),
              ))),
    );
  }


  Screenshotclick() async {



    // screenshotController.capture().then((Uint8List image) {
    //Capture Done
    // js.context.callMethod("webSaveAs", [html.Blob([image], "image.png")]);
    //}).catchError((onError) {
    // print(onError);
    //});
  }




}
