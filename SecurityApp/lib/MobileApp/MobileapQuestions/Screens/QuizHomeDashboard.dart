import 'dart:convert';
import 'dart:io';

import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/PatolTask.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/PropertyInspection.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizDashboard.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizHome.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/UnLockTask.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppConstant.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizColors.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/LockTask.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:Metropolitane/Router/router.dart' as Router;

class QuizHomeDashboard extends StatefulWidget {
  @override
  _QuizHomeDashboardState createState() => _QuizHomeDashboardState();
}


Future<FirebaseUserData> gettingData() async {
  String usercompletedata =
  await PreferenceUtils.getString(PrefKey.UserCompleteData, null);

  Map<String, dynamic> user = jsonDecode(usercompletedata);

  FirebaseUserData firebaseUserData = new FirebaseUserData.fromJson(user);
  return firebaseUserData;
}

class _QuizHomeDashboardState extends State<QuizHomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: gettingData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SafeArea(
              child: Column(
                children:<Widget> [
                  SizedBox(height: 50),
                  text(
                      quiz_lbl_hi_antonio +
                          " " +
                          (snapshot.data == null
                              ? ""
                              : snapshot.data.name),
                      fontFamily: fontBold,
                      fontSize: textSizeXLarge),
                  text(
                      quiz_lbl_what_would_you_like_to_learn_n_today_search_below,
                      textColor: quiz_textColorSecondary,
                      isCentered: true),
                  SizedBox(height: 50),
                  Expanded(child:  GridView.count(
                    //using gridview so that the buttons will show every screen. If they exceed the screen height the button are scrollable.
                    childAspectRatio: 1.27,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 0.0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: [
                      HomeTileButton(
                          text: 'Alarm',
                          icon: Image.asset(
                            "assets/images/AddAlarm.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => QuizDashboard()));
                          }),
                      HomeTileButton(
                          text: 'Patrol',
                          icon: Image.asset(
                            "assets/images/shield.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => PatrolTask()));
                          }),
                      HomeTileButton(
                          text: 'Lock',
                          icon: Image.asset(
                            "assets/images/lock.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => LockTask()));
                          }),
                      HomeTileButton(
                          text: 'UnLock',
                          icon: Image.asset(
                            "assets/images/unlock.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  {
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => UnLockTask()));
                          }),
                      HomeTileButton(
                          text: 'Property Inspection',
                          icon: Image.asset(
                            "assets/images/building.png",
                            width: 60,
                            height: 60,
                          ),
                          onPressed: ()  { //PropertyInspection
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => PropertyInspection()));
                          }),

                      MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return QrCode();
                              }));
                        },
                        child: Text('Scan QR'),
                      ),


                    ],
                  ),),
                ],
              ),
            );
          }
          else {
            return Text("");
          }
        },
      )
    );
  }

}

class HomeTileButton extends StatelessWidget {
  const HomeTileButton({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120.0,
        width: 140.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, 5),
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
class QrCode extends StatefulWidget {
  const QrCode({Key key}) : super(key: key);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(

              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                  else
                    Text('Scan a code'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
