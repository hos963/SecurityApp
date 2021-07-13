
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/CreateQr/createAddresswebbloc/web_create_QR_boc_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/AddQRModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ListofAddressesWidget extends StatefulWidget {
  const ListofAddressesWidget({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _ListofAddressesWidgetState createState() => _ListofAddressesWidgetState();
}

class _ListofAddressesWidgetState extends State<ListofAddressesWidget> {
  WebCreateQRBocBloc webMainBloc;

  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imgf;

  String QrJson ;

  TakeScreen() async {
    screenshotController.capture().then((capturedImage) async {
      setState(() {
        _imgf = capturedImage;
      });
      print('Captured');

      // ShowCapturedWidget(context, capturedImage);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Reportpdfpreview(_imgf)));
      print('Navigate');
    }).catchError((onError) {
      print(onError);
    });
  }


  @override
  void initState() {
    super.initState();
    webMainBloc = BlocProvider.of<WebCreateQRBocBloc>(context);
    webMainBloc.add(getAddresseslistevetn());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: widget._media.height / 1.9,
        width: widget._media.width/2,
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
                          'List of Qr',
                          style: cardTitleTextStyle,
                        ),
                        RaisedButton.icon(
                            onPressed: () {
                              webMainBloc.add(getAddresseslistevetn());
                            },
                            icon: Icon(
                              Icons.autorenew,
                              color: CustomColors.orangecolor,
                            ),
                            label: Text("Refresh")),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Text(
                            'Number',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Address',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'QR',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
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
    return BlocBuilder<WebCreateQRBocBloc, WebCreateAddressBocState>(builder: (context, state) {
      return Container(
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: webMainBloc.listfb != null ? webMainBloc.listfb.length :0 ,
          itemBuilder: (context, position) {
            return getRowDetail(
                context, webMainBloc.listfb[position], position);
          },
        ),
      );
    });
  }

  Widget getRowDetail(
      BuildContext context, AddQRModel addressAlarmModel, int position) {

    String id  ;
    String lat ;
    String long;

  //  QrJson = '{"taskid": "$id", "latitude": "$lat", "longitude": "$long"}';
    //QrJson = '{"name":"Mary","age":30}';

    return InkWell(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.only(left: 6, right: 6, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Row(
              children: <Widget>[

                Text("${position}"),
              ],
            ),
            Text(
              addressAlarmModel.locationName,
              textAlign: TextAlign.justify,
            ),
            SizedBox.fromSize(
              size: Size(36, 36), // button width and height
              child: ClipOval(
                child: Material(
                  color: CustomColors.orangecolor, // button color
                  child: InkWell(
                    splashColor: CustomColors.RedPrimaryValue, // splash color
                    onTap: () {
                      webMainBloc.add(DeleteUserAdress(addressAlarmModel));


                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete,color: Colors.white,size: 10,), // icon
                        Text("Delete",style: TextStyle(color: Colors.white,fontSize: 8),), // text


                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size(36, 36), // button width and height
              child: ClipOval(
                child: Material(
                  color: CustomColors.sometextgreycolor, // button color
                  child: InkWell(
                    splashColor: CustomColors.RedPrimaryValue, // splash color
                    onTap: () {
                      // webMainBloc.add(DeleteUserAdress(addressAlarmModel));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {


                          id  =  addressAlarmModel.qrId;
                          lat  =  addressAlarmModel.latitude;
                          long  =  addressAlarmModel.longitude;

                          return Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                              Screenshot(
                                controller: screenshotController,
                                child: Container(
                                  child: Center(
                                    child: QrImage(

                                      data: '{"taskid": "$id", "latitude": "$lat", "longitude": "$long"}',
                                      version: QrVersions.auto,
                                      size: 300.0,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  TakeScreen();
                                },
                                child: Text("Print"),
                                color: Colors.white,
                              )
                            ],
                          );
                        },
                      );

                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.qr_code,color: Colors.white,size: 10,), // icon
                        Text("QR",style: TextStyle(color: Colors.white,fontSize: 8),), // text

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],


        ),
      ),
    );
  }

}


class Reportpdfpreview extends StatefulWidget {
  Uint8List sshotimg;

  Reportpdfpreview(this.sshotimg);

  @override
  _ReportpdfpreviewState createState() => _ReportpdfpreviewState();
}

class _ReportpdfpreviewState extends State<Reportpdfpreview> {
  bool isloading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FutureBuilder(
              future: _generatePdf(widget.sshotimg),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return PdfPreview(
                    build: (format) async {
                      print(isloading);
                      print('This is Future');
                      return snapshot.data;
                      // return _generatePdf(widget.sshotimg);
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
        ));
  }

  Future<Uint8List> _generatePdf(Uint8List image) async {
    print('This is called');
    final pdf = pw.Document();
    final pdfimage = pw.MemoryImage(image);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(pdfimage));
        },
      ),
    );
    print('PDF Rendered');
    return pdf.save();
  }
}
