import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

class AddingDeviceForm extends StatefulWidget {
  FirebaseUserData firebaseUserData;
  Function afterAddingUserData;
   AddingDeviceForm(
      this.firebaseUserData,
       this.afterAddingUserData,
      {
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _QAddingDeviceFormState createState() => _QAddingDeviceFormState();
}

class _QAddingDeviceFormState extends State<AddingDeviceForm> {
  final TextEditingController _devicenameController = TextEditingController();
 
  final TextEditingController _deviceIDController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
bool isenable = true;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              'Successfully',
              style: TextStyle(
                color: Colors.greenAccent,
              ),
            ),
            content: Text('Your Message has been sent.'),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        height: widget._media.height / 1.38 - 5,
        width: widget._media.width / 5 - 12,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Add Device',
                style: cardTitleTextStyle,
              ),
              SizedBox(height: 50),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: TextFormField(
                  controller: _deviceIDController,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.format_indent_decrease, color: Color(0xff224597)),
                      ),
                      hintText: 'Device ID',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 15.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0))),
                ),
              ),
              SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: TextFormField(
                  controller: _devicenameController,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.drive_file_rename_outline, color: Color(0xff224597)),
                      ),
                      hintText: 'Device Name',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0))),
                ),
              ),


              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    //Send Button

                    _createUSerAccount();
                  },
                  child: Material(
                    shadowColor: Colors.grey,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: Colors.greenAccent,
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 80,
                      child: Text(
                        'Adding Device',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUSerAccount() async {

    if(isenable == true) {
      if (!_deviceIDController.text.isEmpty &&

          !_devicenameController.text.isEmpty) {
        isenable = false;
        FirebaseService firebaseService = new FirebaseService();

        if (widget.firebaseUserData.devicesList == null) {
          widget.firebaseUserData.devicesList = new List();
        }

        Map<String, dynamic> parsedJson = new HashMap<String, dynamic>();

        parsedJson["devicename"] = _devicenameController.text;
        parsedJson["deviceid"] = _deviceIDController.text;

        String str = json.encode(parsedJson);
        widget.firebaseUserData.devicesList.add(str);

        await firebaseService.AddingDataToArrayListUSer(
            widget.firebaseUserData.devicesList, widget.firebaseUserData.udid);
        widget.afterAddingUserData();

        _devicenameController.text = "";
        _deviceIDController.text = "";
        isenable = true;

      }
    }
  }
}
