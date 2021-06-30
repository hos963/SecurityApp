import 'dart:io';
import 'dart:typed_data';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/MainWeb/GeneratePDF/GeneratePDF.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//import 'dart:js' as js;

import 'package:screenshot/screenshot.dart';

class PatrolReportdetailPage extends StatefulWidget {
  PatrolQuestionareModel questionareModel;

  PatrolReportdetailPage(@required this.questionareModel);

  @override
  _PatrolReportdetailPageState createState() => _PatrolReportdetailPageState();
}

class _PatrolReportdetailPageState extends State<PatrolReportdetailPage> {
  ScreenshotController screenshotController = ScreenshotController();
  static GlobalKey screen = new GlobalKey();
  Uint8List _imgf;
  bool isloadingimg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TakeScreen();
  }

  bool isloading = false;

  TakeScreen() async {
    screenshotController.capture().then((capturedImage) async {
      setState(() {
        _imgf = capturedImage;
      });
      print('Captured');

      // ShowCapturedWidget(context, capturedImage);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Reportpdfpreview(_imgf, "Patrol Report")));
      print('Navigate');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
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
                onPressed: () async {
                  TakeScreen();
                  // }
                }),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Screenshot(
                controller: screenshotController,
                child: Container(
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
                            : widget.questionareModel.onwayModel.ontheWay ==
                                    true
                                ? "Yes" +
                                    " at time " +
                                    widget.questionareModel.onwayModel
                                        .onawytimestamp
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
                            "External Patrol Done?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.externalpatroldone == null
                            ? ""
                            : widget.questionareModel.externalpatroldone == true
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
                            "Is Building Present .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.isBuildingPresent == null
                            ? ""
                            : widget.questionareModel.isBuildingPresent == true
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
                            "Building Picture ",
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
                          widget.questionareModel
                                      .externalPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .externalPictureOfBuildingModel
                                  .externalbuildingpic
                              : '',
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //           : ''),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel
                                    .externalPictureOfBuildingModel !=
                                null
                            ? widget.questionareModel
                                .externalPictureOfBuildingModel.timestampextpic
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
                            "Do You Have Keys.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.havekeys != null
                            ? widget.questionareModel.havekeys == true
                                ? "Yes"
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
                            "Keys Picture ",
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
                          //     height: 400,
                          //     width: 400,

                          widget.questionareModel.takePictureOfKeys != null
                              ? widget.questionareModel.takePictureOfKeys
                                  .takePictureOfKeys
                              : '',
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //       image: NetworkImage(
                      //           widget.questionareModel.takePictureOfKeys !=
                      //                   null
                      //               ? widget.questionareModel.takePictureOfKeys
                      //                   .takePictureOfKeys
                      //               : '',
                      //           scale: 2),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
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
                            "Do Key Give Access.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.dokeygiveAccess != null
                            ? widget.questionareModel.dokeygiveAccess == true
                                ? "Yes"
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
                            "Alarm Unset",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.alarmUnset != null
                            ? widget.questionareModel.alarmUnset == true
                                ? "Yes"
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
                            "5 Building pictures .?",
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
                          widget.questionareModel
                                      .internalPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .internalPictureOfBuildingModel
                                  .internalbuildingpic
                              : "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //       image: NetworkImage(
                      //           widget.questionareModel
                      //                       .internalPictureOfBuildingModel !=
                      //                   null
                      //               ? widget
                      //                   .questionareModel
                      //                   .internalPictureOfBuildingModel
                      //                   .internalbuildingpic
                      //               : "",
                      //           scale: 2),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel
                                      .internalFirstPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .internalFirstPictureOfBuildingModel
                                  .internalbuildingpic
                              : "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //       image: NetworkImage(
                      //           widget.questionareModel
                      //                       .internalFirstPictureOfBuildingModel !=
                      //                   null
                      //               ? widget
                      //                   .questionareModel
                      //                   .internalFirstPictureOfBuildingModel
                      //                   .internalbuildingpic
                      //               : "",
                      //           scale: 2),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel
                                      .internalSecondPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .internalSecondPictureOfBuildingModel
                                  .internalbuildingpic
                              : "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //                   .internalSecondPictureOfBuildingModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .internalSecondPictureOfBuildingModel
                      //               .internalbuildingpic
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel
                                      .internalThirdPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .internalThirdPictureOfBuildingModel
                                  .internalbuildingpic
                              : "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //                   .internalThirdPictureOfBuildingModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .internalThirdPictureOfBuildingModel
                      //               .internalbuildingpic
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel
                                      .internalFourthPictureOfBuildingModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .internalFourthPictureOfBuildingModel
                                  .internalbuildingpic
                              : "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                      //                   .internalFourthPictureOfBuildingModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .internalFourthPictureOfBuildingModel
                      //               .internalbuildingpic
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel
                                    .internalPictureOfBuildingModel !=
                                null
                            ? widget.questionareModel
                                .internalPictureOfBuildingModel.timestamp
                                .toDate()
                                .toString()
                            : "",
                        style: TextStyle(fontSize: 20),
                      ),

                      /*    Container(
                      height: 50,
                      width: double.infinity,
                      color: CustomColors.orangecolor,
                      child: Center(
                        child: Text(
                          "Specific Instructions?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      questionareModel.specialInstruction == null ? "" :  questionareModel.specialInstruction .toString() ,

                      style: TextStyle(fontSize: 20),
                    ),*/
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        width: double.infinity,
                        color: CustomColors.orangecolor,
                        child: Center(
                          child: Text(
                            "Lock And Alarmed.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.lockAndAlarmed == null
                            ? ""
                            : widget.questionareModel.lockAndAlarmed.toString(),
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
                            "Additional comments.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.specialInstruction == null
                            ? ""
                            : widget.questionareModel.specialInstruction
                                .toString(),
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
                            "Complete Survey at.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.leaveBuildingModel == null
                            ? ""
                            : widget.questionareModel.leaveBuildingModel
                                        .leavebuilding ==
                                    true
                                ? "Yes"
                                : "No",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
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

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      // useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
