import 'package:Metropolitane/WebArea/MainDashBoardWeb/DashboardModel.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

class DashBoardButtonsContent extends StatelessWidget {
  final List<DashBoardModel> elements = [
    DashBoardModel(
        namebutton: "Register User", icon: "UserRegistration.png", iconhex: ""),

    DashBoardModel(namebutton: "View User", icon: "contacts.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Create Address", icon: "AddressPicker.png", iconhex: ""),

    DashBoardModel(namebutton: "Add Alarm", icon: "AddAlarm.png", iconhex: ""),


    DashBoardModel(
        namebutton: "Add Petroleum", icon: "shield.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Add Lock", icon: "lock.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Add UnLock", icon: "unlock.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Add Property inspection", icon: "building.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Alarm Reports", icon: "ReportsHistory.png", iconhex: ""),


    DashBoardModel(
        namebutton: "Lock Reports", icon: "lockreport.png", iconhex: ""),

    DashBoardModel(
        namebutton: "UnLock Reports", icon: "unlockreport.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Patrol Reports", icon: "patrolreport.png", iconhex: ""),

    DashBoardModel(
        namebutton: "Inspection Reports", icon: "inspectionreport.png", iconhex: ""),
  ];

  @override
  Widget build(context) {
    {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: elements.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, i) => FlatButton(
                        onPressed: () {
                          print("Button Click");
                          switch (i) {
                            case 0:
                              Navigator.pushNamed(
                                  context, Router.WEBHomeScreenRoute);
                              break;
                            case 1:
                              // do something else
                              break;
                            case 2:
                              Navigator.pushNamed(
                                  context, Router.CreateAddressRoute);
                              break;
                            case 3:
                              Navigator.pushNamed(
                                  context, Router.AddAlarmPageRoute);
                              break;
                            case 4:
                              Navigator.pushNamed(
                                  context, Router.AddPatrolPageRoute);
                              break;
                            case 5:
                              Navigator.pushNamed(
                                  context, Router.AddLockPageRoute);
                              break;

                              case 6:
                              Navigator.pushNamed(
                                  context, Router.AddUnLockPageRoute);

                              // do something else
                              break;
                            case 7:
                              Navigator.pushNamed(
                                  context, Router.AddPropertyInspectionPageRoute);

                              // do something else
                              break;

                            case 8:
                              Navigator.pushNamed(
                                  context, Router.ReportAlarmPageRoute);

                              // do something else
                              break;

                              case 9:
                              Navigator.pushNamed(
                                  context, Router.ReportLockPageRoute);

                              // do something else
                              break;

                              case 10:
                              Navigator.pushNamed(
                                  context, Router.ReportUnLockPageRoute);

                              // do something else
                              break;

                            case 11:
                              Navigator.pushNamed(
                                  context, Router.ReportsPatreolPage);

                              break;

                              case 12:
                              Navigator.pushNamed(
                                  context, Router.ReportsPropertyPage);

                              // do something else
                              break;

                          }
                        },
                        child: Card(
                            elevation: 10,
                            child: Container(
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/" + elements[i].icon,
                                    width: 60,
                                    height: 60,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(elements[i].namebutton)),
                                ],
                              )),
                            )),
                      )),
            ),
          )
        ],
      );
    }
  }
}
