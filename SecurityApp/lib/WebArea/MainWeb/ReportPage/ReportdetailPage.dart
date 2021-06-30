import 'dart:io';
import 'dart:typed_data';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/MainWeb/GeneratePDF/GeneratePDF.dart';
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

class ReportdetailPage extends StatefulWidget {
  QuestionareModel questionareModel;

  ReportdetailPage(@required this.questionareModel);

  @override
  _ReportdetailPageState createState() => _ReportdetailPageState();
}

class _ReportdetailPageState extends State<ReportdetailPage> {
  ScreenshotController screenshotController = ScreenshotController();

  Uint8List _imgf;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isloading = true;

  TakeScreen() async {
    screenshotController.capture().then((capturedImage) async {
      setState(() {
        _imgf = capturedImage;
      });
      print('Captured');
      setState(() {
        isloading = false;
      });
      // ShowCapturedWidget(context, capturedImage);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Reportpdfpreview(_imgf, 'Report Detail')));
      print('Navigate');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
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

                isloading == true ? CircularProgressIndicator() : Text('');

                TakeScreen();
              },
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Screenshot(
            controller: screenshotController,
            child: Container(
              width: double.infinity,
              child: Column(
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
                    widget.questionareModel.onwayModel == null
                        ? ""
                        : widget.questionareModel.onwayModel.ontheWay == true
                            ? "Yes" +
                                " at time " +
                                widget
                                    .questionareModel.onwayModel.onawytimestamp
                                    .toDate()
                                    .toString()
                            : "No",
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

                    widget.questionareModel.reachedonSiteModel == null
                        ? ""
                        : widget.questionareModel.reachedonSiteModel
                                    .reachedonsite ==
                                true
                            ? "Yes" +
                                " at time " +
                                widget.questionareModel.reachedonSiteModel
                                    .reachedtimestamp
                                    .toDate()
                                    .toString()
                            : "No",

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
                    widget.questionareModel.havekeys == null
                        ? ""
                        : widget.questionareModel.havekeys == true
                            ? "Yes"
                            : "No",
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
                    child: Image.network(
                      widget.questionareModel.externalPictureOfBuildingModel !=
                              null
                          ? widget
                              .questionareModel
                              .externalPictureOfBuildingModel
                              .externalbuildingpic
                          : "",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),

                  // Container(
                  //     height: 400,
                  //     width: 400,
                  //     child: FadeInImage(
                  //       width: 400,
                  //       height: 400,
                  //       image: NetworkImage(widget.questionareModel
                  //                   .externalPictureOfBuildingModel !=
                  //               null
                  //           ? widget
                  //               .questionareModel
                  //               .externalPictureOfBuildingModel
                  //               .externalbuildingpic
                  //           : ""),
                  //       placeholder:
                  //           AssetImage("assets/images/placeholder.png"),
                  //     )),
                  // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.questionareModel.externalPictureOfBuildingModel !=
                            null
                        ? widget.questionareModel.externalPictureOfBuildingModel
                            .timestampextpic
                            .toDate()
                            .toString()
                        : "",
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
                    widget.questionareModel.areyouabletounsetAlarmModel != null
                        ? widget.questionareModel.areyouabletounsetAlarmModel
                                    .unsetalarm ==
                                true
                            ? "Yes" +
                                " at time " +
                                widget
                                    .questionareModel
                                    .areyouabletounsetAlarmModel
                                    .unsetalarmtimestamp
                                    .toDate()
                                    .toString()
                            : "No"
                        : " ",
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
                    child: Image.network(
                      widget.questionareModel.pictureOfAlarmPanelModel != null
                          ? widget.questionareModel.pictureOfAlarmPanelModel
                              .picalarmpanel
                          : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //     height: 400,
                  //     width: 400,
                  //     child: FadeInImage(
                  //       image: NetworkImage(widget.questionareModel
                  //                   .pictureOfAlarmPanelModel !=
                  //               null
                  //           ? widget.questionareModel.pictureOfAlarmPanelModel
                  //               .picalarmpanel
                  //           : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081"),
                  //       placeholder:
                  //           AssetImage("assets/images/placeholder.png"),
                  //     )),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    widget.questionareModel.pictureOfAlarmPanelModel != null
                        ? widget
                            .questionareModel.pictureOfAlarmPanelModel.timestamp
                            .toDate()
                            .toString()
                        : " ",
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
                    widget.questionareModel.messageOnPanel != null
                        ? widget.questionareModel.messageOnPanel.toString()
                        : " ",
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
                    child: Image.network(
                      widget.questionareModel.internalPictureOfBuildingModel !=
                              null
                          ? widget
                              .questionareModel
                              .internalPictureOfBuildingModel
                              .internalbuildingpic
                          : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081",
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //     height: 400,
                  //     width: 400,
                  //     child: FadeInImage(
                  //       image: NetworkImage(widget.questionareModel
                  //                   .internalPictureOfBuildingModel !=
                  //               null
                  //           ? widget
                  //               .questionareModel
                  //               .internalPictureOfBuildingModel
                  //               .internalbuildingpic
                  //           : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081"),
                  //       placeholder:
                  //           AssetImage("assets/images/placeholder.png"),
                  //     )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.questionareModel.internalPictureOfBuildingModel !=
                            null
                        ? widget.questionareModel.internalPictureOfBuildingModel
                            .timestamp
                            .toDate()
                            .toString()
                        : " ",
                    style: TextStyle(fontSize: 20),
                  ),

                  Container(
                    height: 50,
                    width: double.infinity,
                    color: CustomColors.orangecolor,
                    child: Center(
                      child: Text(
                        "Action Taken",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.questionareModel.actionTaken != null
                        ? widget.questionareModel.actionTaken == true
                            ? "Yes"
                            : "No"
                        : "",
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.questionareModel.areyouabletosetAlarmModel != null
                        ? widget.questionareModel.areyouabletosetAlarmModel
                                    .setalarm ==
                                true
                            ? "Yes" +
                                " at time " +
                                widget.questionareModel
                                    .areyouabletosetAlarmModel.timestamp
                                    .toDate()
                                    .toString()
                            : "No"
                        : " ",
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.questionareModel.leaveBuildingModel != null
                        ? widget.questionareModel.leaveBuildingModel
                                    .leavebuilding ==
                                true
                            ? "Yes" +
                                " at time " +
                                widget.questionareModel.leaveBuildingModel
                                    .timestamp
                                    .toDate()
                                    .toString()
                            : "No"
                        : " ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          )),
        ));
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
