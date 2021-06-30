import 'package:Metropolitane/WebArea/MainWeb/GeneratePDF/GeneratePDF.dart';
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

class PropertyReportDetailPage extends StatefulWidget {
  PropertyInspectionQuestionareModel questionareModel;

  PropertyReportDetailPage(@required this.questionareModel);

  @override
  _PropertyReportDetailPageState createState() =>
      _PropertyReportDetailPageState();
}

class _PropertyReportDetailPageState extends State<PropertyReportDetailPage> {
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
              builder: (context) =>
                  Reportpdfpreview(_imgf, 'Property Report')));
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
              scrollDirection: Axis.vertical,
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
                        child: Image.network(
                          widget.questionareModel.externalImageScreenModel !=
                                  null
                              ? widget.questionareModel.externalImageScreenModel
                                  .externalImageScreenModel
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
                      //                   .externalImageScreenModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .externalImageScreenModel
                      //               .externalImageScreenModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      // Image.network("https://firebasestorage.googleapis.com/v0/b/metropolitan-3d0c1.appspot.com/o/buuilding%2F2806f1de-aaf2-4d36-89d0-d7a596e118941150819418339817137.jpg?alt=media&token=3ba0e77f-87a8-427d-914d-6857e47dfee5"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.externalImageScreenModel != null
                            ? widget.questionareModel.externalImageScreenModel
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
                            "Do You Have Keys or Code for Access.?",
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
                            "Is Building Secure?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.isbuildingsecure != null
                            ? widget.questionareModel.isbuildingsecure == true
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
                            "Is Building has working alarm.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.isbuildingsecure != null
                            ? widget.questionareModel.isbuildingsecure == true
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
                            "Any Water Leakage.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.anyWaterLeaking != null
                            ? widget.questionareModel.anyWaterLeaking == true
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
                            "Is Electric Meter Present.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.electricMeterPresent != null
                            ? widget.questionareModel.electricMeterPresent ==
                                    true
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
                        child: Image.network(
                          widget.questionareModel.electricMeterPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .electricMeterPictureModel
                                  .electricMeterPictureModel
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
                      //                   .electricMeterPictureModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .electricMeterPictureModel
                      //               .electricMeterPictureModel
                      //           : ""),
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
                            "Is There any Gas Meter .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.gasMeterPresent != null
                            ? widget.questionareModel.gasMeterPresent == true
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
                        child: Image.network(
                          widget.questionareModel.gasMeterPictureModel != null
                              ? widget.questionareModel.gasMeterPictureModel
                                  .gasMeterPictureModel
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
                      //           widget.questionareModel.gasMeterPictureModel !=
                      //                   null
                      //               ? widget
                      //                   .questionareModel
                      //                   .gasMeterPictureModel
                      //                   .gasMeterPictureModel
                      //               : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),

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
                        widget.questionareModel.waterMeterPresent != null
                            ? widget.questionareModel.waterMeterPresent == true
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
                        child: Image.network(
                          widget.questionareModel.waterMeterPictureModel != null
                              ? widget.questionareModel.waterMeterPictureModel
                                  .waterMeterPictureModel
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
                      //                   .waterMeterPictureModel !=
                      //               null
                      //           ? widget.questionareModel.waterMeterPictureModel
                      //               .waterMeterPictureModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),

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
                        widget.questionareModel.anyDamageToProperty != null
                            ? widget.questionareModel.anyDamageToProperty ==
                                    true
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
                        child: Image.network(
                          widget.questionareModel.anyDamageToPropertyPicModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .anyDamageToPropertyPicModel
                                  .anyDamageToPropertyPicModel
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
                      //                   .anyDamageToPropertyPicModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .anyDamageToPropertyPicModel
                      //               .anyDamageToPropertyPicModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),

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
                        widget.questionareModel.AnyIntrudersOutside != null
                            ? widget.questionareModel.AnyIntrudersOutside ==
                                    true
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
                            "Any Worker Outside .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.AnyWorkerOutside != null
                            ? widget.questionareModel.AnyWorkerOutside == true
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
                            "Any Graftii Needs Removal .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.AnyGraffitiNeedRemoval != null
                            ? widget.questionareModel.AnyGraffitiNeedRemoval ==
                                    true
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
                            "Any Drug Use Onsite .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.AnyDrugUseOutside != null
                            ? widget.questionareModel.AnyDrugUseOutside == true
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
                            "Any Health And Safety Issue .?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.AnyHealthAndSafetyIssues != null
                            ? widget.questionareModel
                                        .AnyHealthAndSafetyIssues ==
                                    true
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
                        child: Image.network(
                          widget.questionareModel
                                      .take1stInternalPicturesModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take1stInternalPicturesModel
                                  .take1stInternalPicturesModel
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
                      //                   .take1stInternalPicturesModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .take1stInternalPicturesModel
                      //               .take1stInternalPicturesModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel.take2ndInternalPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take2ndInternalPictureModel
                                  .take2ndInternalPictureModel
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
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel.take2ndInternalPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take2ndInternalPictureModel
                                  .take2ndInternalPictureModel
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
                      //                   .take2ndInternalPictureModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .take2ndInternalPictureModel
                      //               .take2ndInternalPictureModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel.take3rdInternalPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take3rdInternalPictureModel
                                  .take3rdInternalPictureModel
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
                      //                   .take3rdInternalPictureModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .take3rdInternalPictureModel
                      //               .take3rdInternalPictureModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel.take4thInternalPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take4thInternalPictureModel
                                  .take4thInternalPictureModel
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
                      //                   .take4thInternalPictureModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .take4thInternalPictureModel
                      //               .take4thInternalPictureModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 400,
                        width: 400,
                        child: Image.network(
                          widget.questionareModel.take5thInternalPictureModel !=
                                  null
                              ? widget
                                  .questionareModel
                                  .take5thInternalPictureModel
                                  .take5thInternalPictureModel
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
                      //                   .take5thInternalPictureModel !=
                      //               null
                      //           ? widget
                      //               .questionareModel
                      //               .take5thInternalPictureModel
                      //               .take5thInternalPictureModel
                      //           : ""),
                      //       placeholder:
                      //           AssetImage("assets/images/placeholder.png"),
                      //     )),

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
                        widget.questionareModel.SpecificInstructions == null
                            ? ""
                            : widget.questionareModel.SpecificInstructions
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
                            "Job Completed.?",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.questionareModel.jobCompletedModel == null
                            ? ""
                            : widget.questionareModel.jobCompletedModel
                                        .jobcompleted ==
                                    true
                                ? "Yes" +
                                    " at time" +
                                    widget.questionareModel.jobCompletedModel
                                        .onawytimestamp
                                        .toDate()
                                        .toString()
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
}
