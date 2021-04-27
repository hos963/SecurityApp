import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/WebArea/Createaddress/Widgets/AddAdressFields.dart';
import 'package:Metropolitane/WebArea/Createaddress/Widgets/ListofAddresses.dart';
import 'package:Metropolitane/WebArea/Createaddress/createAddresswebbloc/web_create_address_boc_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/DeleteDataArea.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/UsersList_widget.dart';
import 'package:Metropolitane/WebArea/MainWeb/widget/quick_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CreateAddress extends StatefulWidget {
  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  WebCreateAddressBocBloc webMainBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webMainBloc = BlocProvider.of<WebCreateAddressBocBloc>(context);
  }

  var progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return completeBodyWidget();
        },
      ),
    );
  }
  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<WebCreateAddressBocBloc, WebCreateAddressBocState>(
        listener: (context, state) {
          if (state is WebMainLoading) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is FailedToCreateAddress) {
            if (progress != null) {
              progress.dismiss();
            }


            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  imagepath: "",
                  title: "Message",
                  description: state.errorstr,
                  buttonText: "OK",
                ));
          }

          if (state is SuccessfullyCreatedAddressstate) {
            if (progress != null) {
              progress.dismiss();
            }
            // state.userdata
            // print("User data " + state.userdata.email);

            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  imagepath: "",
                  title: "Successfully Created",
                  description: "Successfully Created",
                  buttonText: "OK",
                ));
          }


        },
        child: Mainflutter(context),
      );
    }));
  }



  Widget Mainflutter(BuildContext context){
    final _media = MediaQuery.of(context).size;
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Flexible(
            fit: FlexFit.loose,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 55,
                  width: _media.width,
                  child: AppBar(
                    elevation: 4,
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      'Add Address',style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    children: <Widget>[
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[

                                SizedBox(
                                  height: 20,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: <Widget>[

                                      ListofAddressesWidget(media: _media),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AddAdressFields(media: _media),

                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }


}