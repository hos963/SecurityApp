
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/Questions/HaveKeysOrCodeScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:progress_indicator_button/progress_button.dart';

class ExternalImageScreen extends StatefulWidget {

  @override
  _ExternalImageScreenState createState() => _ExternalImageScreenState();
}

class _ExternalImageScreenState extends State<ExternalImageScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //return Container(child: Text(widget.isinternal == true ? "Internal building pictuure": "External Building picture"),);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: Text('Survey'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          color: quiz_app_background,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                text("Take External Picture of the Building.", textColor: quiz_textColorPrimary,
                    isLongText: true,
                    isCentered: true,
                    fontSize: 22.0).center(),

                SizedBox(height: 30),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Container(
                            height: width * 0.85,
                            width: width * 0.85,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: quiz_white, width: 4)),
                            child: _image == null
                                ? Text('No image selected.').center()
                                : Image.file(_image, fit: BoxFit.fill),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: quiz_white, width: 4),
                                color: quiz_white),
                            child: Icon(Icons.edit, size: 20).onTap(() {

                            }),
                          ).paddingOnly(top: 16).onTap(() {
                            //print("Edit profile");
                          })
                        ],
                      ),

                    ],
                  ),
                ).onTap(() {
                  //  Navigator.of(context).pop();
                  getImage();
                }),
                SizedBox(height: 20),
                // Container(
                //   margin: EdgeInsets.all(40.0),
                //   child: quizButton(
                //     textContent: quiz_lbl_continue,
                //     onPressed: () {
                //       uploadFile( _image);
                //     },
                //   ),
                // )

                Container(

                  width: 200,
                  height: 50,
                  child: ProgressButton(
                    color: quiz_colorPrimaryDark,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    strokeWidth: 2,
                    child: Text(
                      quiz_lbl_continue,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: (AnimationController controller) {
                      if (controller.isCompleted) {
                        //   controller.reverse();
                      } else {
                        controller.forward();
                        //     uploadFile(_image);
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => HaveKeysOrCodeScreen()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}