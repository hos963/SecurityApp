import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPatrol/Bloc/add_patrol_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:Metropolitane/Router/router.dart' as Router;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ReportPatreolPageQR extends StatefulWidget {
  @override
  _ReportPatreolPageState createState() => _ReportPatreolPageState();
}

class _ReportPatreolPageState extends State<ReportPatreolPageQR> {
  String addressselected;
  AddPatrolBloc addAlarmBloc;

  @override
  void initState() {
    super.initState();

    addAlarmBloc = BlocProvider.of<AddPatrolBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  var progress;

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<AddPatrolBloc, AddPatrolState>(
        listener: (context, state) {
          if (state is AddPatrolLoading) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is AddPatrolFailedToAddDataState) {
            if (progress != null) {
              progress.dismiss();
            }

            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      imagepath: "",
                      title: "Message",
                      description: state.errorstr,
                      buttonText: "OK",
                    ));
          }

          if (state is AddPatrolSuccessfullyPutdatastate) {
            if (progress != null) {
              progress.dismiss();
            }
            // state.userdata
            // print("User data " + state.userdata.email);

            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      imagepath: "",
                      title: "Successfully Data Sent",
                      description: "Successfully Created",
                      buttonText: "OK",
                    ));
          }
        },
        child: ReportAlarmBody(context),
      );
    }));
  }

  bool _isLoading = false;

  Widget ReportAlarmBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Patrol Report',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: drawerBgColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 40, bottom: 40),
                  child: getListing()),
            ),
          ],
        ),
      ),
    );
  }

  //  .where("publishtime",isGreaterThan:  dateTimeRange.start.toUtc().toIso8601String()).where("publishtime",isLessThanOrEqualTo:  dateTimeRange.end.toUtc().toIso8601String())
  Widget getListing() {
    Query firebasequuery = FirebaseFirestore.instance.collection("PatrolAlert");

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder<QuerySnapshot>(
            stream: firebasequuery.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.docs.length == 0) {
                return Text("No data founnd");
              } else {
                List<AddPatrolModel> listalarm = snapshot.data.docs
                    .map((e) => AddPatrolModel.fromDoc(e))
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  // Let the ListView know how many items it needs to build.
                  itemCount: listalarm.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    final item = listalarm[index];
                    bool isselected = false;
                    if (item.questionareModel == null) {
                      isselected = false;
                    } else {
                      isselected = true;
                    }

                    return MyCardViewWidget(
                      title: item.patrolTitle,
                      lat: item.Lat,
                      long: item.Long,
                      subtitle: item.patrolDesc,
                      isselected: isselected,
                      locationnname: item.patrolLocation,
                      patrolId: item.patrolId,
                      questionareModel: item.questionareModel,
                      state: item.state,
                      firebaseUserData: item.firebaseUserData,
                    );
                  },
                );
              }
            });
  }
}

class MyCardViewWidget extends StatefulWidget {
  final String title;
  final String lat;
  final String long;
  final String subtitle;
  final String locationnname;
  final bool isselected;
  final String patrolId;
  final int state;
  final PatrolQuestionareModel questionareModel;
  final FirebaseUserData firebaseUserData;

  const MyCardViewWidget(
      {Key key,
      this.title,
      this.lat,
      this.long,
      this.subtitle,
      this.isselected,
      this.locationnname,
      this.patrolId,
      this.questionareModel,
      this.state,
      this.firebaseUserData})
      : super(key: key);

  @override
  _MyCardViewWidgetState createState() => _MyCardViewWidgetState();
}

class _MyCardViewWidgetState extends State<MyCardViewWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imgf;

  String QrJson;

  TakeScreen() async {
    screenshotController.capture().then((capturedImage) async {
      setState(() {
        _imgf = capturedImage;
      });
      print('Captured');

      // ShowCapturedWidget(context, capturedImage);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Reportpdfpreview(_imgf)));
      print('Navigate');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();

    String Lat = widget.lat;
    String Long = widget.long;
    String PatrolId = widget.patrolId;
    String UserId = widget.firebaseUserData.udid;

    QrJson = '{"taskid": $PatrolId, "latitude": $Lat, "longitude": $Long}';
  } // bool selected = false;

  @override
  Widget build(BuildContext context) {
    String uuserdat = (widget.firebaseUserData != null
        ? "Email " +
            widget.firebaseUserData.email +
            " name " +
            widget.firebaseUserData.name
        : "");

    return Container(
      child: new Card(
        shape: widget.isselected
            ? new RoundedRectangleBorder(
                side: new BorderSide(
                    color: widget.state == 3
                        ? Colors.green
                        : CustomColors.orangecolor,
                    width: 2.0),
                borderRadius: BorderRadius.circular(4.0))
            : new RoundedRectangleBorder(
                side: new BorderSide(color: CustomColors.black, width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
        child: new Padding(
          padding: const EdgeInsets.all(4.0),
          child: new Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Title : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "User Information : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                  Text(
                    "" + uuserdat,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Descriptionn : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Location : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                  Text(
                    widget.locationnname,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.state == 3
                            ? Colors.green
                            : CustomColors.orangecolor),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Screenshot(
                                        controller: screenshotController,
                                        child: Container(
                                          child: Center(
                                            child: QrImage(
                                              data: QrJson,
                                              version: QrVersions.auto,
                                              size: 300.0,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          TakeScreen();
                                        },
                                        child: Text("Print"),
                                        color: Colors.white,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Generate QR PDF'))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Reportpdfpreview extends StatefulWidget {
  Uint8List sshotimg;

  Reportpdfpreview(this.sshotimg);

  @override
  _ReportpdfpreviewState createState() => _ReportpdfpreviewState();
}

class _ReportpdfpreviewState extends State<Reportpdfpreview> {
  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FutureBuilder(
      future: _generatePdf(widget.sshotimg),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return PdfPreview(
            build: (format) async {
              print(isloading);
              print('This is Future');
              return snapshot.data;
              // return _generatePdf(widget.sshotimg);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    )
            // isloading
            // ? Center(
            //     child: CircularProgressIndicator(),
            //   )
            // : PdfPreview(
            //     build: (format) async {
            //       print(isloading);
            //       print('This is called');

            //       return await _generatePdf(widget.sshotimg);
            //     },
            //   )

            ));
  }

  Future<Uint8List> _generatePdf(Uint8List image) async {
    print('This is called');
    final pdf = pw.Document();
    final pdfimage = pw.MemoryImage(image);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfimage));
        },
      ),
    );
    print('PDF Rendered');
    return pdf.save();
  }
}
