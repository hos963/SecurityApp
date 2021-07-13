import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/CreateQr/createAddresswebbloc/web_create_QR_boc_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/model/AddQRModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdressFields extends StatefulWidget {
  const AddAdressFields({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _AddAdressFieldsState createState() => _AddAdressFieldsState();
}

class _AddAdressFieldsState extends State<AddAdressFields> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _LongiController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactnumberController =
      TextEditingController();

  WebCreateQRBocBloc webMainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webMainBloc = BlocProvider.of<WebCreateQRBocBloc>(context);
    _latController.text = "0.0";
    _LongiController.text = "0.0";
  }

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
                color: CustomColors.orangecolor,
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
        width: widget._media.width / 3 - 12,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Save QR',
                style: cardTitleTextStyle,
              ),
              SizedBox(height: 50),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.location_city,
                            color: CustomColors.orangecolor),
                      ),
                      hintText: 'Address',
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
                  controller: _latController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.gps_fixed,
                            color: CustomColors.orangecolor),
                      ),
                      hintText: 'Latitude',
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
              SizedBox(height: 20),
              Material(
                elevation: 8.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: TextFormField(
                  controller: _LongiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.gps_fixed,
                            color: CustomColors.orangecolor),
                      ),
                      hintText: 'Longitude',
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0))),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: OutlineButton(
                  padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                  borderSide: BorderSide(
                    color: CustomColors.orangecolor,
                  ),
                  onPressed: () {
                    _createUSerAccount();
                  },
                  child: Text(
                    'Save QR',
                    style: TextStyle(
                        color: CustomColors.orangecolor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUSerAccount() {
    if (!_addressController.text.isEmpty &&
        !_LongiController.text.isEmpty &&
        !_latController.text.isEmpty) {
      AddQRModel addressAlarmModel = new AddQRModel(
          locationName: _addressController.text,
          latitude: _latController.text,
          longitude: _LongiController.text);
      webMainBloc.add(CreateAddressEvent(addressAlarmModel));
      _addressController.text = "";
    }
  }
}
