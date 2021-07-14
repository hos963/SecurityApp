import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddAlarm/Widgets/InputField.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPatrol/Bloc/add_patrol_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

class AddPatrolPage extends StatefulWidget {
  @override
  _AddPatrolPageState createState() => _AddPatrolPageState();
}

class _AddPatrolPageState extends State<AddPatrolPage> {
  String latlong;
  AddPatrolBloc addPatrolBloc;

  final TextEditingController _TittleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  FirebaseUserData firebaseUserData;
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateTime selectdate = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    addPatrolBloc = BlocProvider.of<AddPatrolBloc>(context);
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
            _TittleController.text = "";
            _detailController.text = "";

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
        child: AddPatrolBody(context),
      );
    }));
  }

  Widget AddPatrolBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add Patrol',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: drawerBgColor,
      ),
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 5.0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                      child: Column(
                        children: <Widget>[
                          //InputField Widget from the widgets folder
                          InputField(
                              controller: this._TittleController,
                              label: "Titles",
                              content: "Titles"),

                          SizedBox(height: 20.0),

                          //Gender Widget from the widgets folder

                          //InputField Widget from the widgets folder
                          InputField(
                              controller: this._detailController,
                              label: "Detail",
                              content: "Detail",
                              numberoflines: 6),

                          SizedBox(height: 20.0),

                          Row(
                            children: [
                              Container(
                                width: 80.0,
                                child: Text(
                                  "Select Date",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 3.7,
                                color: Colors.blue[50],
                                child: OutlinedButton(
                                  onPressed: () async {
                                    final startdate =
                                        await _showStartDatePicker(context);

                                    print(startdate);

                                    setState(() {
                                      this.selectdate = DateTime(
                                        startdate.year,
                                        startdate.month,
                                        startdate.day,
                                      );
                                    });
                                    print(selectdate);
                                  },
                                  child: Text(
                                    dateFormat.format(selectdate),
                                    // style: TextStyle(color: Colors.white),
                                  ),
                                  // color: Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.0),

                          Row(children: <Widget>[
                            Container(
                              width: 80.0,
                              child: Text(
                                "Select User",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context,
                                        Router.ListUsersSelectionRoutePage)
                                    .then((value) {
                                  setState(() {
                                    firebaseUserData = value;
                                  });
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width / 3.7,
                                color: Colors.blue[50],
                                child: Center(
                                    child: Text(this.firebaseUserData != null
                                        ? this.firebaseUserData.name
                                        : "Select User")),
                              ),
                            ),
                          ]),
                          SizedBox(height: 20.0),

                          Row(children: <Widget>[
                            Container(
                              width: 80.0,
                              child: Text(
                                "Select Address",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                           /* Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width / 3.7,
                              color: Colors.blue[50],
                              child: ListOfAddresses(this.SelectedAdressfunc,this.SelectedAdressLat,this.SelectedAdressLong),
                            ),*/
                            OutlineButton(
                              padding:
                              EdgeInsets.fromLTRB(100, 15, 100, 15),
                              borderSide: BorderSide(
                                color: CustomColors.orangecolor,
                              ),
                              onPressed: () {

                                Navigator.pushNamed(context,
                                    Router.maplocationPageroute)
                                    .then((value) {
                                  setState(() {
                                    latlong = value;
                                    print("YYYEEESSSS");
                                    print(latlong);
                                  });
                                });

                              },
                              child: Text(
                                'Select location',
                                style: TextStyle(
                                    color: CustomColors.orangecolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),

                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Selected Address Name:",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  latlong == null
                                      ? " ----"
                                      : "  " + latlong,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: CustomColors.orangecolor,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 40.0,
                          ),

                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 170.0,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: OutlineButton(
                                  padding:
                                      EdgeInsets.fromLTRB(100, 15, 100, 15),
                                  borderSide: BorderSide(
                                    color: CustomColors.orangecolor,
                                  ),
                                  onPressed: () {
                                    SubmittedAddPatrol(context);
                                  },
                                  child: Text(
                                    'Add Patrol',
                                    style: TextStyle(
                                        color: CustomColors.orangecolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> _showStartDatePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime(2013),
      lastDate: DateTime(2100),
    );
  }

  void SubmittedAddPatrol(BuildContext context) {
    //
    String title = _TittleController.text;
    String detail = _detailController.text;

    if (firebaseUserData != null &&
        latlong != null &&
        latlong.isNotEmpty &&
        title != null &&
        title.isNotEmpty &&
        detail != null &&
        detail.isNotEmpty) {
      AddPatrolModel addPatrolModel = new AddPatrolModel(
          patrolTitle: title,
          patrolDesc: detail,
          futuretask: selectdate,
          latlong: latlong,
          type: "Patrol",
          firebaseUserData: firebaseUserData,
          isactive: true);

      addPatrolBloc.add(SavingPatrolDataToFirebaseEvent(addPatrolModel));

      //firebaseService.addAlarm(addressselected, title, detail);

    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Some Field Missing"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

/* Function SelectedAdressfunc(String address) {
    print(address);
    setState(() {
      addressselected = address;
    });
  }*/

/*Function SelectedAdressLat(String Lat) {
    print(Lat);
    setState(() {
      addressLatitude = Lat;
    });
  }

  Function SelectedAdressLong(String Long) {
    print(Long);
    setState(() {
      addressLongitute = Long;
    });
  }
}*/

/*
class ListOfAddresses extends StatelessWidget {
  FirebaseFirestore fireStoreDataBase = FirebaseFirestore.instance;
  Function SelectedAdress;
  Function SelectedLat;
  Function SelectedLong;

  ListOfAddresses(this.SelectedAdress,this.SelectedLat,this.SelectedLong);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: fireStoreDataBase.collection("Addresses").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: new CircularProgressIndicator(
                  backgroundColor: CustomColors.orangecolor,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ));
        return new ListView(
          children: snapshot.data.docs.map((document) {
            return Card(
              child: new ListTile(
                title: new Text(document['locationName']),
                onTap: () {
                  SelectedAdress(document['locationName']);
                  SelectedLat(document['latitude']);
                  SelectedLong(document['longitude']);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

*/

}
