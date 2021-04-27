import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/Pages/SettingpageScreen/setting_bloc.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingBloc settingBloc;

  final TextEditingController _deviceName = TextEditingController();
  final TextEditingController _deviceId = TextEditingController();

  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  File _image;
  String userpic;

  @override
  void initState() {
    super.initState();

    settingBloc = BlocProvider.of<SettingBloc>(context);
    settingBloc.add(ShowDeviceList());
  }

  @override
  void dispose() {
    super.dispose();
    _deviceId.dispose();
    _deviceName.dispose();
  }

  Future<void> gettingImageLink()async{

    String   userpicnew = await  PreferenceUtils.getString(PrefKey.UserPic);
    setState(() {
      if(userpicnew != null){

        userpic = userpicnew;
      }
    });

  }



  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  var progress;

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state is LoadingPage) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is DismissProgressPagestate) {
            if (progress != null) {
              progress.dismiss();
            }
          }

          if (state is ImageLinkUploaded) {
            if (progress != null) {
              progress.dismiss();

              //state.imagelink
            }
          }
        },
        child: Scaffold(
          body: mainbodyWidget(),
        ),
      );
    }));
  }

  Widget mainbodyWidget() {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(
                    "Setting",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(userpic != null ?userpic:
                    "https://cdn2.iconfinder.com/data/icons/avatar-2/512/Fred_man-512.png"),
                backgroundColor: Colors.transparent,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Device List",
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Container(
            color: Colors.white,
            height: 200,
            child: _deviceListView(context),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(top: 10),
            color: Colors.black,
            child: Row(
              children: [
                Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: 20,
                  margin: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ProfileDetail(),
        ],
      ),
    );
  }

  Widget ProfileDetail() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('Add Bio Matric Credentials',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center),


          // Column(children: [
          //
          //   Container(
          //     margin: EdgeInsets.only(top: 10, bottom: 10),
          //     child: Row(
          //       children: [
          //         Text('Devce ID:',
          //             style: TextStyle(color: Colors.black, fontSize: 18),
          //             textAlign: TextAlign.center),
          //         Expanded(
          //           child: Container(
          //             margin: EdgeInsets.only(left: 20),
          //             height: 40,
          //             child: TextField(
          //               controller: _deviceId,
          //               autofocus: true,
          //               decoration: new InputDecoration(
          //                 focusedBorder: OutlineInputBorder(
          //                   borderSide:
          //                   BorderSide(color: Colors.black, width: 1.0),
          //                 ),
          //                 enabledBorder: OutlineInputBorder(
          //                   borderSide:
          //                   BorderSide(color: Colors.black, width: 1.0),
          //                 ),
          //                 hintText: 'Device ID',
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   OutlineButton(
          //     shape: new RoundedRectangleBorder(
          //         borderRadius: new BorderRadius.circular(0.0)),
          //     onPressed: () {
          //       _AddingNewDevice();
          //     },
          //     child: Text("Save Device Info"),
          //   ),
          // ],),

          Column(children: [
            Row(
              children: [
                Text('User Email',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 40,
                    child: TextField(
                      controller: _useremail,
                      autofocus: true,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        hintText: 'User Email for bio matric',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text('Password:',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.center),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 40,
                      child: TextField(
                        controller: _userpassword,
                        autofocus: true,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'User password for biomateric',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OutlineButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0)),
              onPressed: () {
                if(_useremail.text.length > 4 && _userpassword.text.length > 5){
                  PreferenceUtils.setString(PrefKey.Useremailbio, _useremail.text);
                  PreferenceUtils.setString(PrefKey.Userpassbio, _userpassword.text);

                  Fluttertoast.showToast(
                      msg: "Data has been saved successfylly",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                }

              },
              child: Text("Save BioMateric"),
            ),
          ],),


          SizedBox(
            height: 40,
          ),
          Text('Change Password',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text('Change Password',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 40,
                    child: Text("abc@gmail.com",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
          OutlineButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0.0)),
            onPressed: () {},
            child: Text("Click to change Password"),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('Change Avatar',
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    chooseFile();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image != null
                              ? FileImage(_image)
                              : NetworkImage(
                                  'https://cdn2.iconfinder.com/data/icons/avatar-2/512/Fred_man-512.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(0.0)),
                    onPressed: () {
                      if (_image != null) {
                        settingBloc.add(new UploadImage(_image));
                      } else {}
                    },
                    child: Text("Upload Image"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _deviceListView(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(builder: (context, state) {
      if (state is ListDevicesGetState || state is AddDeviceList) {
        var listfecteddevicestate;
        if (state is ListDevicesGetState) {
          listfecteddevicestate = state as ListDevicesGetState;
        } else {
          listfecteddevicestate = state as AddDeviceList;
        }
        final listdevices = listfecteddevicestate.devicelist;

        return ListView.builder(
          itemCount: listdevices.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center),
                        Text('Device ID',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            textAlign: TextAlign.center),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 1,
                  color: Colors.black,
                )
              ]);
            } else {
              int currentindex = index - 1;
              return Container(
                padding: EdgeInsets.only(left: 0, right: 20),
                height: 40,
                decoration: BoxDecoration(
                  color: (currentindex % 2) == 0 ? Colors.black : Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // FlatButton.icon(
                          //   onPressed: () {
                          //     settingBloc.add(
                          //         RemovedDeviceList(listdevices[currentindex]));
                          //   },
                          //   icon: Icon(
                          //     Icons.delete,
                          //     color: (currentindex % 2) == 0
                          //         ? Colors.white
                          //         : Colors.black,
                          //   ),
                          //   label: Text(""),
                          // ),
                          Text(
                            '${listdevices[currentindex].devicename}',
                            style: TextStyle(
                                color: (currentindex % 2) == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11),
                          ),
                        ],
                      ),
                      Row(children: [
                        Text(
                          '${listdevices[currentindex].deviceid}',
                          style: TextStyle(
                            color: (currentindex % 2) == 0
                                ? Colors.white
                                : Colors.black,
                            fontSize: 11,
                          ),
                        ),
                      ]),
                    ]),
              );
            }
          },
        );
      } else {
        return Container(
          child: Text(""),
        );
      }
    });
  }

  Future chooseFile() {
    ImagePicker.platform.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = File(image.path);
      });
    });
  }

  _AddingNewDevice() {
    String devicename = _deviceName.text;
    String deviceid = _deviceId.text;
    if (devicename.length > 2 && deviceid.length > 2) {
      _deviceName.text = "";
      _deviceId.text = "";
      settingBloc.add(AddingDeviceData(
          DeviceModel(deviceid: deviceid, devicename: devicename)));
    }
  }
}
