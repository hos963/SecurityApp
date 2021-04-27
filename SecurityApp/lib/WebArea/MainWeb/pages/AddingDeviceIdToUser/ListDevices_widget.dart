import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebBloc/Weblogin_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/model/project_model.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

class ListDevices_Widget extends StatefulWidget {
  FirebaseUserData firebaseUserData;

  ListDevices_Widget(
    this.firebaseUserData, {
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _ListDevices_WidgetState createState() => _ListDevices_WidgetState();
}

class _ListDevices_WidgetState extends State<ListDevices_Widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: widget._media.height / 1.9,
        width: widget._media.width / 3 + 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Devices List  ${widget.firebaseUserData.email}',
                          style: cardTitleTextStyle,
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 80.0, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          Text(
                            'Device Name',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Device ID',
                            style: TextStyle(color: Colors.grey),
                          ),

                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      ListingEventsDetail(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ListingEventsDetail() {
    return BlocBuilder<WebMainBloc, WebMainState>(builder: (context, state) {
      return Container(
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.firebaseUserData.devicesList != null ? widget.firebaseUserData.devicesList.length:0,
          itemBuilder: (context, position) {
            return getRowDetail(
                context,  widget.firebaseUserData.devicesList[position], position);
          },
        ),
      );
    });
  }

  Widget getRowDetail(
      BuildContext context, String devicedetail, int position) {
    Map<String, dynamic> devicesdto = jsonDecode(devicedetail);
    //print(devicesdto.toString());

    return InkWell(
      onTap: () {
        // AddingDevideIdtoUser


      },
      child: Container(
        margin: EdgeInsets.only(left: 6, right: 6, bottom: 10),
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Text("${devicesdto["devicename"]}"),

                Text("${devicesdto["deviceid"]}"),
              ],
            ),

      ),
    );
  }
}
