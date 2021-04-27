import 'package:flutter/material.dart';
import 'package:Metropolitane/WebArea/MainWeb/pages/AddingDeviceIdToUser/AddingDeviceForm.dart';
import 'package:Metropolitane/WebArea/MainWeb/pages/AddingDeviceIdToUser/ListDevices_widget.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

class AddingDevideIdtoUser extends StatefulWidget {
  FirebaseUserData firebaseUserData;

  AddingDevideIdtoUser(this.firebaseUserData);

  @override
  _AddingDevideIdtoUserState createState() => _AddingDevideIdtoUserState();
}

class _AddingDevideIdtoUserState extends State<AddingDevideIdtoUser> {

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding Device detail"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
          child: Row(
        children: [
          ListDevices_Widget(widget.firebaseUserData,media: _media),
          SizedBox(
            width: 40,
          ),
          AddingDeviceForm(widget.firebaseUserData,AfterAddingUSerScreen,media: _media),
        ],
      )),
    );
  }


Function AfterAddingUSerScreen(){

    setState(() {

    });
}

}
