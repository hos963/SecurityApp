import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//import 'dart:js' as js;

class Reportpdfpreview extends StatefulWidget {
  Uint8List sshotimg;
  String title;
  Reportpdfpreview(this.sshotimg, this.title);

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
            appBar: AppBar(
              title: Text(widget.title),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
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
            // isloading
            // ? Center(
            //     child: CircularProgressIndicator(),
            //   )
            // : PdfPreview(
            //     build: (format) async {
            //       print(isloading);
            //       print('This is called');

            //       return await _generatePdf(widget.sshotimg);
            //     },
            //   )

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
