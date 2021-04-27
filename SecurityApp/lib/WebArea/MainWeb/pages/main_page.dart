import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/DeleteDataArea.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/card_tile.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/chart_card_tile.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/comment_widget.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/profile_Widget.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/UsersList_widget.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/quick_contact.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/responsive_widget.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/sidebar_menu..dart';


class WebMainPage extends StatefulWidget {
  @override
  _WebMainPageState createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {
  WebMainBloc webMainBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webMainBloc = BlocProvider.of<WebMainBloc>(context);
  }
  var progress;
  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {


        return completeBodyWidget() ;
      },
    );
  }

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<WebMainBloc, WebMainState>(
        listener: (context, state) {
          if (state is WebMainLoading) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is FailedToCreateAccount) {
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

          if (state is SuccessfullyCreatedAccountstate) {
            if (progress != null) {
              progress.dismiss();
            }
            // state.userdata
            // print("User data " + state.userdata.email);

            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  imagepath: "",
                  title: "Successfully Created",
                  description: "Successfully Created",
                  buttonText: "OK",
                ));
          }


        },
        child: Mainflutter(context),
      );
    }));
  }



  Widget Mainflutter(BuildContext context){
    final _media = MediaQuery.of(context).size;
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 55,
                  width: _media.width,
                  child: AppBar(
                    elevation: 4,
                    centerTitle: true,
                    title: Text(
                      'Register User / View User',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: drawerBgColor,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                // IntrinsicHeight(
                                //   child: Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment.start,
                                //     crossAxisAlignment:
                                //     CrossAxisAlignment.stretch,
                                //     children: <Widget>[
                                //       CardTile(
                                //         iconBgColor: Colors.orange,
                                //         cardTitle: 'Booking',
                                //         icon: Icons.flight_takeoff,
                                //         subText: 'Todays',
                                //         mainText: '230',
                                //       ),
                                //       SizedBox(width: 20),
                                //       CardTile(
                                //         iconBgColor: Colors.pinkAccent,
                                //         cardTitle: 'Website Visits',
                                //         icon: Icons.show_chart,
                                //         subText:
                                //         'Tracked from Google Analytics',
                                //         mainText: '3.560',
                                //       ),
                                //       SizedBox(width: 20),
                                //       CardTile(
                                //         iconBgColor: Colors.green,
                                //         cardTitle: 'Revenue',
                                //         icon: Icons.home,
                                //         subText: 'Last 24 Hours',
                                //         mainText: '2500',
                                //       ),
                                //       SizedBox(width: 20),
                                //       CardTile(
                                //         iconBgColor:
                                //         Colors.lightBlueAccent,
                                //         cardTitle: 'Followors',
                                //         icon: Icons.unfold_less,
                                //         subText: 'Last 24 Hours',
                                //         mainText: '112',
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: <Widget>[
                                      // Column(
                                      //   mainAxisAlignment:
                                      //   MainAxisAlignment.start,
                                      //   crossAxisAlignment:
                                      //   CrossAxisAlignment.start,
                                      //   children: <Widget>[
                                      //     ChartCardTile(
                                      //       cardColor: Color(0xFF7560ED),
                                      //       cardTitle: 'Bandwidth usage',
                                      //       subText: 'March 2017',
                                      //       icon: Icons.pie_chart,
                                      //       typeText: '50 GB',
                                      //     ),
                                      //     SizedBox(
                                      //       height: 20,
                                      //     ),
                                      //     ChartCardTile(
                                      //       cardColor: Color(0xFF25C6DA),
                                      //       cardTitle: 'Download count',
                                      //       subText: 'March 2017',
                                      //       icon: Icons.cloud_upload,
                                      //       typeText: '35487',
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      ProjectWidget(media: _media),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            QuickContact(media: _media),
                            SizedBox(
                              width:10,
                            ),
                          //  DeleteDataArea(media: _media)
                          ],
                        ),
                      ),
                      // IntrinsicHeight(
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.stretch,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: <Widget>[
                      //       // CommentWidget(media: _media),
                      //       // SizedBox(
                      //       //   width: 20,
                      //       // ),
                      //       ProfileWidget(media: _media),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
