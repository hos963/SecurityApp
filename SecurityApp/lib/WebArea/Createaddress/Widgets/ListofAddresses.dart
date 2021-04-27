import 'package:Metropolitane/WebArea/Createaddress/createAddresswebbloc/web_create_address_boc_bloc.dart';
import 'package:Metropolitane/model/AddressAlarmModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebBloc/Weblogin_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/model/project_model.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

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
  WebCreateAddressBocBloc webMainBloc;

  @override
  void initState() {
    super.initState();
    webMainBloc = BlocProvider.of<WebCreateAddressBocBloc>(context);
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
        width: widget._media.width / 3 + 20,
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
                          'List of Locations',
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
    return BlocBuilder<WebCreateAddressBocBloc, WebCreateAddressBocState>(builder: (context, state) {
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
      BuildContext context, AddressAlarmModel addressAlarmModel, int position) {
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
            )
          ],


        ),
      ),
    );
  }
}
