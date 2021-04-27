import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:flutter/material.dart';

import '../commons/theme.dart';

class ListUsersSelection extends StatefulWidget {
  @override
  _ListUsersSelectionState createState() => _ListUsersSelectionState();
}

class _ListUsersSelectionState extends State<ListUsersSelection> {
  FirebaseService firebaseService = new FirebaseService();
int selectedpposition = -1;
FirebaseUserData firebaseUserData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Select User',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {

              if(selectedpposition != -1){

                Navigator.of(context).pop(this.firebaseUserData);
              }

            },
            child: Icon(
              Icons.save,
              color: Colors.white,// add custom icons also
            ),
          ),

        ],

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: drawerBgColor,
      ),
      body: FutureBuilder<List>(
        future: firebaseService.gettingAllUsersData(),
        initialData: List.empty(),
        builder: (context, snapshot) {
          return snapshot.hasData ?
          new ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {

              bool isselected = false;

              if(selectedpposition == i){
                isselected = true;

              }else{

                isselected = false;
              }
              return UserSelection(snapshot.data[i],gettinPositionselected,i,isselected);
            },
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      )

    );
  }


  Function gettinPositionselected(int position,FirebaseUserData firebaseUserData){
    this.firebaseUserData = firebaseUserData;
   setState(() {
     selectedpposition = position;
   });

  }
}

class UserSelection extends StatelessWidget {
  FirebaseUserData firebaseUserData;
  Function selectionPosition;
  int position = -1;
  UserSelection(this.firebaseUserData,this.selectionPosition,this.position,this.checkBoxValue);

  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Container(
        padding: new EdgeInsets.only(left: 0.0, bottom: 8.0, right: 16.0),
        decoration: new BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [ Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Name :           '+firebaseUserData.name,
                  style: TextStyle(color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Contact No:      '+firebaseUserData.phonenumber,
                  style: TextStyle(color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Email Address:       '+firebaseUserData.email,
                  style: TextStyle(color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),

              ],
            ),
          )
            ,new Checkbox(value: checkBoxValue,
                activeColor: Colors.green,
                onChanged:(bool newValue){
                    if(newValue == true){
                      checkBoxValue = newValue;
                      selectionPosition(position,firebaseUserData);
                    }else{

                      selectionPosition(-1,null);
                    }



                }),
        ],


        ),
      ),
    );

  }
}


