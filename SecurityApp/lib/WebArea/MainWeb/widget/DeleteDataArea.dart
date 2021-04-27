import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
class DeleteDataArea extends StatefulWidget {
  const DeleteDataArea({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _DeleteDataState createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteDataArea> {
 

  WebMainBloc webMainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    webMainBloc = BlocProvider.of<WebMainBloc>(context);
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
                'Create Account',
                style: cardTitleTextStyle,
              ),
              SizedBox(height: 50),

              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    //Send Button
                    _DeleteData();
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
                        'Delete Data',
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

  void _DeleteData() {

    dateTimeRangePicker();
  }
  dateTimeRangePicker() async {
    DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: DateTimeRange(
        end: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
        start: DateTime.now(),
      ),
    );
    if(picked != null){
      webMainBloc.add(DeletingDataweb(picked));
    }

  }
}
