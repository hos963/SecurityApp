import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPatrol/Bloc/add_patrol_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPropertyInspection/Bloc/add_inspection_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:Metropolitane/model/PropertyInspectionQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

class ReportPropertyPage extends StatefulWidget {
  @override
  _ReportPropertyPageState createState() => _ReportPropertyPageState();
}

class _ReportPropertyPageState extends State<ReportPropertyPage> {
  String addressselected;
  AddPropertyInspectionBloc addAlarmBloc;
  DateTimeRange dateTimeRange;

  @override
  void initState() {
    super.initState();

    addAlarmBloc = BlocProvider.of<AddPropertyInspectionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  var progress;

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<AddPropertyInspectionBloc,
          AddPropertyInspectionState>(
        listener: (context, state) {
          if (state is AddPropertyInspectionLoading) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is AddPropertyInspectionFailedToAddDataState) {
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

          if (state is AddPropertyInspectionSuccessfullyPutdatastate) {
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
          'Property Report',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: drawerBgColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlineButton(
              padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
              borderSide: BorderSide(
                color: CustomColors.orangecolor,
              ),
              onPressed: () {
                dateTimeRangePicker();
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Select Data Picker',
                  style: TextStyle(
                      color: CustomColors.orangecolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(dateTimeRange != null
                ? dateTimeRange.start.toString() +
                    " to " +
                    dateTimeRange.end.toString()
                : "-- to --"),
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
    Query firebasequuery = dateTimeRange == null
        ? FirebaseFirestore.instance
            .collection("PropertyInspectionAlert")
            .where("timestamp", isGreaterThan: new DateTime.now())
            .orderBy('timestamp', descending: true)
        : FirebaseFirestore.instance
            .collection("PropertyInspectionAlert")
            .where("timestamp", isGreaterThan: dateTimeRange.start.toUtc())
            .where("timestamp", isLessThanOrEqualTo: dateTimeRange.end.toUtc())
            .orderBy('timestamp', descending: true);

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
                List<AddPropertyInspectionModel> listalarm = snapshot.data.docs
                    .map((e) => AddPropertyInspectionModel.fromDoc(e))
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
                      title: item.inspectionTitle,
                      subtitle: item.inspectionDesc,
                      isselected: isselected,
                      locationnname: item.latlong,
                      inspectionId: item.inspectionId,
                      questionareModel: item.questionareModel,
                      state: item.state,
                      firebaseUserData: item.firebaseUserData,
                    );
                  },
                );
              }
            });
  }

  dateTimeRangePicker() async {
    DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
        start: DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        dateTimeRange = picked;
      });
    }
  }
}

class MyCardViewWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String locationnname;
  final bool isselected;
  final String inspectionId;
  final int state;
  final PropertyInspectionQuestionareModel questionareModel;
  final FirebaseUserData firebaseUserData;

  const MyCardViewWidget(
      {Key key,
      this.title,
      this.subtitle,
      this.isselected,
      this.inspectionId,
      this.locationnname,
      this.questionareModel,
      this.state,
      this.firebaseUserData})
      : super(key: key);

  @override
  _MyCardViewWidgetState createState() => _MyCardViewWidgetState();
}

class _MyCardViewWidgetState extends State<MyCardViewWidget> {
  // bool selected = false;
  @override
  Widget build(BuildContext context) {
    String uuserdat = (widget.firebaseUserData != null
        ? "Email " +
            widget.firebaseUserData.email +
            " name " +
            widget.firebaseUserData.name
        : "");

    return InkWell(
      onTap: () {
        if (widget.questionareModel != null) {
          Navigator.pushNamed(context, Router.PropertyReportsdetailPage,
              arguments: widget.questionareModel);
        }
      },
      child: Container(
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
                        widget.locationnname!=null?widget.locationnname:"",
                      style: TextStyle(
                          fontSize: 20,
                          color: widget.state == 3
                              ? Colors.green
                              : CustomColors.orangecolor),
                    ),
                    widget.isselected
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("PropertyInspectionAlert")
                                          .doc(widget.inspectionId)
                                          .delete();
                                    },
                                    child: Text('Delete'))
                              ],
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
