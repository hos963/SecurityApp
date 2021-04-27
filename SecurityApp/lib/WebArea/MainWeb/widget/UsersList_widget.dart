import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebBloc/Weblogin_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/model/project_model.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  WebMainBloc webMainBloc;

  @override
  void initState() {
    super.initState();
    webMainBloc = BlocProvider.of<WebMainBloc>(context);
    webMainBloc.add(getFirebaseUserslistevetn());
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
                          'Users List',
                          style: cardTitleTextStyle,
                        ),
                        RaisedButton.icon(
                            onPressed: () {
                              webMainBloc.add(getFirebaseUserslistevetn());
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(width: 2),
                          Text(
                            'Name',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Email',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
    return BlocBuilder<WebMainBloc, WebMainState>(builder: (context, state) {
      return Container(
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: webMainBloc.listfb.length,
          itemBuilder: (context, position) {
            return getRowDetail(
                context, webMainBloc.listfb[position], position);
          },
        ),
      );
    });
  }

  Widget getRowDetail(
      BuildContext context, FirebaseUserData firebaseUserData, int position) {
    return InkWell(
      onTap: () {

        Navigator.pushNamed(context, Router.AddingDevideIdtoUserRoute,
            arguments: firebaseUserData);
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
                CircleAvatar(
                  child: Text(firebaseUserData.name.substring(0, 2)),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(firebaseUserData.name),
              ],
            ),
            Text(
              firebaseUserData.email,
              textAlign: TextAlign.justify,
            ),
            Text('${firebaseUserData.phonenumber.toString()}'),
            Checkbox(
                value: firebaseUserData.isactive,
                activeColor: Colors.green,
                onChanged: (bool newValue) {
                  webMainBloc.add(setcheckisActiveUser(
                      newValue, position, firebaseUserData.udid));
                }),
          ],
        ),
      ),
    );
  }
}
