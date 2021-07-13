import 'dart:convert';
import 'dart:io';

import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/PatrolQuestionareModel.dart';
import 'package:Metropolitane/model/QrCodes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../PatrolQuestionSurvey.dart';

class QrCode extends StatefulWidget {
  //const QrCode({Key key}) : super(key: key);

  final MyCallbackToback callback;

  AddPatrolModel addPatrolModel;

  QrCode(this.addPatrolModel, this.callback);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  String resultData = "";

  bool isUpload=false;

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
                    resultData != "" ? Text("Task Complete", style: TextStyle(fontSize: 12),) : Text("Please Scan a Qr", style: TextStyle(fontSize: 12),)

                  else
                    Text('Scan a Qr code', style: TextStyle(fontSize: 12),),
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
        printData(result.code.toString());
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  printData(String data) async {
    print("OOOKK");

    Map<String, dynamic> map = jsonDecode(data); // import 'dart:convert';

    if (map.containsKey('taskid')) {
      String name = map['taskid'].toString();

      print("OOOKK");
      print(name);

      var collection = FirebaseFirestore.instance.collection('QrCodes');
      var docSnapshot = await collection.doc(name).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data();
        var value = data['qrId'];

        setState(() {
          resultData = value;
        });

        Updatinngdata();

      }
    }

  }

  Future<void> Updatinngdata() async {

    if(isUpload==false){

    QrScan reachedonSiteModel = new QrScan();
    reachedonSiteModel.scanned = true;

    if (widget.addPatrolModel.questionareModel == null) {
      widget.addPatrolModel.questionareModel = new PatrolQuestionareModel();
    }
    widget.addPatrolModel.questionareModel.qrScan = reachedonSiteModel;

    FirebaseService firebaseService = new FirebaseService();
    await firebaseService.updateScannedPatrol(
        widget.addPatrolModel.patrolId, widget.addPatrolModel.questionareModel);

    setState(() {
      isUpload ==true;
    });

    widget.callback(1);


  }

  }

}
