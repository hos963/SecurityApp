import 'dart:io';
import 'dart:typed_data';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//import 'dart:js' as js;


import 'package:screenshot/screenshot.dart';
class ReportdetailPage extends StatelessWidget {
  QuestionareModel questionareModel;
  ScreenshotController screenshotController = ScreenshotController();
  ReportdetailPage(@required this.questionareModel);

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
                        "Do you have keys?",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      questionareModel.havekeys == null ? "" :  questionareModel.havekeys .toString() ,

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
                        "External Picture Of Building",
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
                        image: NetworkImage(questionareModel.externalPictureOfBuildingModel
                                     !=
                                null
                            ? questionareModel.externalPictureOfBuildingModel.externalbuildingpic
                            : ""),
                        placeholder: AssetImage("assets/images/placeholder.png"),
                      )),
                 // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    questionareModel.externalPictureOfBuildingModel
                        !=
                        null
                        ? questionareModel.externalPictureOfBuildingModel.timestampextpic.toDate().toString()
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
                        "Are you able to unset Alarm?",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    questionareModel.areyouabletounsetAlarmModel != null ? questionareModel.areyouabletounsetAlarmModel.unsetalarm.toString()+ " at time "+ questionareModel.areyouabletounsetAlarmModel.unsetalarmtimestamp.toDate().toString() :" ",
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
                        "Picture of Alarm Panel?",
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
                        image: NetworkImage(questionareModel.pictureOfAlarmPanelModel !=
                                null
                            ? questionareModel.pictureOfAlarmPanelModel.picalarmpanel
                            : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081"),
                        placeholder: AssetImage("assets/images/placeholder.png"),
                      )),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    questionareModel.pictureOfAlarmPanelModel != null ? questionareModel.pictureOfAlarmPanelModel.timestamp.toDate().toString() :" ",
                    style: TextStyle(fontSize: 20),
                  ),

                  Container(
                    height: 50,
                    width: double.infinity,
                    color: CustomColors.orangecolor,
                    child: Center(
                      child: Text(
                        "Message on panel?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    questionareModel.messageOnPanel != null ? questionareModel.messageOnPanel.toString() :" ",
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
                        "Picture of Internal building",
                        style: TextStyle(fontSize: 20,color: Colors.white),
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
                        image: NetworkImage(questionareModel.internalPictureOfBuildingModel!=
                                null
                            ? questionareModel.internalPictureOfBuildingModel.internalbuildingpic
                            : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081"),
                        placeholder: AssetImage("assets/images/placeholder.png"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    questionareModel.internalPictureOfBuildingModel != null ? questionareModel.internalPictureOfBuildingModel.timestamp.toDate().toString() :" ",
                    style: TextStyle(fontSize: 20),
                  ),



                  Container(
                    height: 50,
                    width: double.infinity,
                    color: CustomColors.orangecolor,
                    child: Center(
                      child: Text(
                        "Action Taken",
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    questionareModel.actionTaken != null ? questionareModel.actionTaken.toString() : "",
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
                        "Are you able to set Alarm?",
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      questionareModel.areyouabletosetAlarmModel != null ? questionareModel.areyouabletosetAlarmModel.setalarm.toString()+ " at time "+ questionareModel.areyouabletosetAlarmModel.timestamp.toDate().toString() :" ",

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
                        "Leave Building at",
                        style: TextStyle(fontSize: 20,color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      questionareModel.leaveBuildingModel != null ? questionareModel.leaveBuildingModel.leavebuilding.toString()+ " at time "+ questionareModel.leaveBuildingModel.timestamp.toDate().toString() :" ",

                    style: TextStyle(fontSize: 20),
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

class Reportpdfpreview extends StatelessWidget{
  QuestionareModel questionareModel;
  Reportpdfpreview(this.questionareModel);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("title")),
        body: PdfPreview(
          build: (format) => _generatePdf(format, "title",questionareModel),
        ),
      ),
    );

}
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title, QuestionareModel questionareModel) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return  pw.ListView(



          );
        },
      ),
    );

    return pdf.save();
  }

}
