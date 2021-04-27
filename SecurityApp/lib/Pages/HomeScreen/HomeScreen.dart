import 'dart:convert';

import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/CustomWidget/TopAraeAvatar.dart';

import 'package:Metropolitane/Pages/HomeScreen/home_screen_bloc.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:Metropolitane/model/EventsModel.dart';
import 'package:Metropolitane/model/GraphModelDto.dart';
import 'package:Metropolitane/model/ReadSettingModel.dart';
import 'package:Metropolitane/model/ReportsModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chartIndex = 0;
  HomeScreenBloc homebloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homebloc = BlocProvider.of<HomeScreenBloc>(context);
    homebloc.add(GetListOfDevices());
    homebloc.add(GettingStreamDataFirestore());
  }

  LineChart chart;
  var progress;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is ShowProgressState) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is HideProgressState) {
            if (progress != null) {
              progress.dismiss();
              if (state.messgage != null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                          imagepath: "",
                          title: "Message",
                          description: state.messgage,
                          buttonText: "OK",
                        ));
              }
            }
          }
        },
        child: Scaffold(
          body: _CompleteHomeScreenWidget(context),
        ),
      );
    }));
  }

  Widget _CompleteHomeScreenWidget(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //Top Area
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
            List<DropdownMenuItem<String>> getDropDownMenuItems() {
              List<DropdownMenuItem<String>> items = new List();
              for (DeviceModel city in homebloc.DevicesList) {
                items.add(new DropdownMenuItem(
                    value: city.devicename, child: new Text(city.devicename)));
              }
              return items;
            }

            return (TopAreaAvatar(
                getDropDownMenuItems(), homebloc.selecteddevice, "home"));
          }),
          SizedBox(
            height: 10,
          ),
          ControllButtonArea(),
          SizedBox(
            height: 10,
          ),

          BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
            return MonitorsArea(state);
          }),

          SizedBox(
            height: 10,
          ),
          // BlocBuilder<HomeScreenBloc, HomeScreenState>(
          //     builder: (context, state) {
          //       return SetupAreaWidget();
          //     });

          BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
            return (SetupAreaWidget(state));
          }),
        ],
      ),
    );
  }

  Widget ControllButtonArea() {
    return Container(
      child: Column(children: [
        Container(
          color: CustomColors.black,
          width: double.infinity,
          child: Center(
            child: Text("Control",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900)),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: () {
                    homebloc.add(GenOnEvent());
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/generatoronicon.png",
                        width: 34,
                        height: 34,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text("Gen On",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  homebloc.add(GenOffEvent());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/generatorofficon.png",
                      width: 34,
                      height: 34,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text("Gen Off",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  homebloc.add(ResetTimerEvent());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/reseticon.png",
                      width: 34,
                      height: 34,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text("Reset Timer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ReportsModel reportsModel;

  Widget MonitorsArea(HomeScreenState homeScreenState) {
    // if (homeScreenState is RerportDataState) {
    //   reportsModel = homeScreenState.reportsModel;
    // }

    if (homeScreenState is AllListMapState) {
      // reportlistrep = homeScreenState.reportmaplist;
      if (homeScreenState.reportsMap != null) {
        var sortedlist = homeScreenState.reportsMap.values.toList();
        Comparator<ReportsModel> datecomparison =
            (a, b) => b.publishtime.compareTo(a.publishtime);

        sortedlist.sort(datecomparison);

        reportsModel = sortedlist.first;
      }
    }

    return Container(
        child: Column(children: [
      Container(
        color: CustomColors.black,
        width: double.infinity,
        child: Center(
          child: Text("Monitor",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900)),
        ),
      ),
      SizedBox(
        height: 6,
      ),
      Center(
        child: Text(
            "${reportsModel == null ? "" : (reportsModel.Status == false ? "Device OFF" : "Device is connected")}",
            style: TextStyle(
                color: reportsModel == null
                    ? Colors.red
                    : (reportsModel.Status == false
                        ? Colors.red
                        : Colors.green),
                fontSize: 20,
                fontWeight: FontWeight.w900)),
      ),
      Container(
        padding: EdgeInsets.all(0),
        height: 200,
        child: ChartWidgetLine(homeScreenState),
      ),
      Container(
          color: Colors.black,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      margin:
                          EdgeInsets.only(top: 4, left: 4, right: 2, bottom: 2),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Fuel",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${reportsModel == null ? 0 : reportsModel.Fuel}%",
                              style: TextStyle(
                                  color: CustomColors.orangecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      margin:
                          EdgeInsets.only(top: 4, left: 4, right: 2, bottom: 2),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Volt",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${reportsModel == null ? 0 : reportsModel.Volt}%",
                              style: TextStyle(
                                  color: CustomColors.orangecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      margin:
                          EdgeInsets.only(top: 4, left: 4, right: 2, bottom: 2),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Runtime",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${reportsModel == null ? 0 : (reportsModel.Run_time / 60).round()} hrs",
                              style: TextStyle(
                                  color: CustomColors.orangecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      margin:
                          EdgeInsets.only(top: 4, left: 4, right: 2, bottom: 2),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Gen state",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${reportsModel == null ? 0 : (reportsModel.Status == false ? "OFF" : "ON")}",
                              style: TextStyle(
                                  color: CustomColors.orangecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6, top: 6),
                      margin:
                          EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 2),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text("Signal",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "${reportsModel == null ? "0" : (reportsModel.Sig == null ? "0" : reportsModel.Sig)}",
                              style: TextStyle(
                                  color: CustomColors.orangecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text("Setup",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900)),
              SizedBox(
                height: 4,
              ),
            ],
          ))
    ]));
  }

  ReadSettingModel readSettingModel;
  Map<String, ReportsModel> reportlistrep;
  DateTime currentdate;

  Widget ChartWidgetLine(HomeScreenState homeScreenState) {
    var myData = [
      ["0", "0"],
    ];

    // if (homeScreenState is ReportListMapState) {
    //   reportlistrep = homeScreenState.reportmaplist;
    //   int count = 1;
    //   reportlistrep.entries.forEach((e) {
    //     myData.add(["${e.value.Volt}", "${count}"]);
    //     count++;
    //   });
    //
    //
    // }
    if (homeScreenState is AllListMapState) {
      if (homeScreenState.reportsMap != null) {
        reportlistrep = homeScreenState.reportsMap;
        int count = 1;

        reportlistrep.entries.forEach((e) {
          DateTime todayDate = DateTime.parse(e.value.publishtime);
          if (count < 7) {
            currentdate = todayDate;

            myData.add([
              "${e.value.Volt}",
              "${todayDate.day}/${todayDate.month}/${todayDate.year}"
            ]);
            count++;
          }
        });
      }
    }

    return new LineChart(
      lines: [
        new Line<List<String>, String, String>(
          data: myData,
          xFn: (datum) => datum[1],
          yFn: (datum) => datum[0],
        ),
      ],
      chartPadding: new EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
    );
  }

  Widget SetupAreaWidget(HomeScreenState homeScreenState) {
    if (homeScreenState is AllListMapState) {
      var sortedlist = homeScreenState.alleventsmap.values.toList();
      Comparator<EventsModel> datecomparison =
          (a, b) => b.publishtime.compareTo(a.publishtime);

      sortedlist.sort(datecomparison);

      for (var item in sortedlist) {
        if (item.eventname == "Var_Payload") {
          readSettingModel = ReadSettingModel.fromJson2(item.alldata);
          readSettingModel.deviceid = item.deviceid;
          readSettingModel.publishtime = item.publishtime;
          break;
        }
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  homebloc.add(ReadSetting());
                },
                child: Container(
                    padding:
                        EdgeInsets.only(top: 4, left: 6, right: 6, bottom: 4),
                    color: Colors.black,
                    child: Text(
                      "Read Config",
                      style: TextStyle(
                          fontSize: 14, color: Colors.lightGreenAccent),
                    )),
              ),
              InkWell(
                onTap: () {
                  homebloc.add(GettingStreamDataFirestore());
                },
                child: Container(
                    padding:
                        EdgeInsets.only(top: 4, left: 6, right: 6, bottom: 4),
                    color: Colors.black,
                    child: Text(
                      "Send Config",
                      style: TextStyle(
                          fontSize: 14, color: Colors.lightGreenAccent),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _showDialogAlert(
                  context,
                  "Start Volt \n Low : 11.5 to Hight : 12",
                  true,
                  11.5,
                  12.0,
                  SelectedEventName.StartVolt);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Start Volt: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${readSettingModel == null ? 0 : readSettingModel.genStartVolt}",
                      style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.orangecolor,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    _showDialogAlert(
                        context,
                        "OFF Volt \n Low : 13 to Hight : 15",
                        false,
                        13,
                        15,
                        SelectedEventName.OffVolt);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Off Volt: ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${readSettingModel == null ? 0 : readSettingModel.genStopVoltage}",
                        style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.orangecolor,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _showDialogAlert(
                      context,
                      "Ignition Attempt \n Low : 1 to Hight : 20",
                      false,
                      1,
                      14,
                      SelectedEventName.IgnitionAttemp);
                },
                child: Row(
                  children: [
                    Text(
                      "Ignition Attempt: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${readSettingModel == null ? 0 : readSettingModel.ignAttempt}x",
                      style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.orangecolor,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showDialogAlert(
                      context,
                      "Report Time \n Low : 1 to Hight : 999",
                      false,
                      1,
                      999,
                      SelectedEventName.ReportTime);
                },
                child: Row(
                  children: [
                    Text(
                      "Report Time: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${(readSettingModel == null ? 0 : (readSettingModel.reporting_pd / 60))} min",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.orangecolor,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _showDialogAlert(
                      context,
                      "Ignition Delay \n Low : 3 to Hight : 500",
                      false,
                      3,
                      500,
                      SelectedEventName.IgnitionDelay);
                },
                child: Row(
                  children: [
                    Text(
                      "Ignition Delay: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${(readSettingModel == null ? 0 : readSettingModel.ignitionSettle)} min",
                      style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.orangecolor,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showDialogAlert(
                      context,
                      "Time Zone \n Low : -12 to Hight : 12",
                      false,
                      -12,
                      12,
                      SelectedEventName.TimeZone);
                },
                child: Row(
                  children: [
                    Text(
                      "TimeZone: ",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${readSettingModel == null ? 0 : readSettingModel.timeZone} ",
                      style: TextStyle(
                          fontSize: 14,
                          color: CustomColors.orangecolor,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  _showDialogAlert(BuildContext context, String title, bool isdecimal,
      var mininput, var maxinput, SelectedEventName eventName) async {
    final myController = TextEditingController();
    await showDialog<String>(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text(title),
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                keyboardType: TextInputType.numberWithOptions(
                    decimal: isdecimal, signed: !isdecimal),
                controller: myController,
                maxLength: 5,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Enter Value',
                    hintText: ' $mininput  to $maxinput'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                String valustr = myController.text.toString();
                print("value is $valustr");
                if (isdecimal == true) {
                  double valuedouble = double.parse(valustr);

                  if (valuedouble >= mininput && valuedouble <= maxinput) {
                    homebloc.add(
                        CallingfunctionsWithDifferentName(eventName, valustr));
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "Values are not in range so process cannot be created",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                } else {
                  int intvalue = int.parse(valustr);

                  if (intvalue >= mininput && intvalue <= maxinput) {
                    homebloc.add(
                        CallingfunctionsWithDifferentName(eventName, valustr));
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            "Values are not in range so process cannot be created",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }

                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homebloc?.streamquery?.cancel();
  }
}

// SfCartesianChart(
// borderWidth: 2,
//
// zoomPanBehavior: ZoomPanBehavior(
// enablePinching: false, enableDoubleTapZooming: false),
// margin: EdgeInsets.all(0),
// primaryXAxis: CategoryAxis(),
// // Chart title
// title: ChartTitle(text: 'VOLTS'),
// // Enable legend
// plotAreaBorderColor: CustomColors.orangecolor,
// series: <ChartSeries<GraphModelDto, String>>[
// LineSeries<GraphModelDto, String>(
// dataSource: <GraphModelDto>[
// GraphModelDto('a', 10),
// GraphModelDto('b', 28),
// GraphModelDto('c', 34),
// GraphModelDto('d', 32),
// GraphModelDto('e', 40)
// ],
// xValueMapper: (GraphModelDto sales, _) => sales.year,
// yValueMapper: (GraphModelDto sales, _) => sales.sales,
// // Enable data label
// dataLabelSettings: DataLabelSettings(isVisible: false))
// ])
