import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/Pages/EventScreen/event_bloc.dart';
import 'package:Metropolitane/Pages/HomeScreen/home_screen_bloc.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopAreaAvatar extends StatefulWidget {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  String isfromevent;

  TopAreaAvatar(this._dropDownMenuItems, this._currentCity, this.isfromevent);

  @override
  _TopAreaAvatarState createState() => _TopAreaAvatarState();
}

class _TopAreaAvatarState extends State<TopAreaAvatar> {
  String userpic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gettingImageLink();
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
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Devices",
                style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 200,
                height: 38,
                padding: EdgeInsets.all(4),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  style: TextStyle(
                      fontSize: 20,
                      color: CustomColors.orangecolor,
                      fontWeight: FontWeight.w800),
                  underline: SizedBox(),
                  value: widget._currentCity,
                  items: widget._dropDownMenuItems,
                  onChanged: (String change) {
                    changedevice(change, context);
                  },
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(userpic !=null ?userpic :
                "https://cdn2.iconfinder.com/data/icons/avatar-2/512/Fred_man-512.png"),
            backgroundColor: Colors.transparent,
          )
        ],
      ),
    );
  }

  void changedevice(String selectedCity, BuildContext context) {
    widget._currentCity = selectedCity;
    if (widget.isfromevent == "event") {
      BlocProvider.of<EventBloc>(context)
          .add(SelectDeviceinEvents(widget._currentCity));
      BlocProvider.of<EventBloc>(context)
          .add(GettingStreamDataFirestoreEvents());
    } else if (widget.isfromevent == "home") {
      BlocProvider.of<HomeScreenBloc>(context)
          .add(SelectDevice(widget._currentCity));
      BlocProvider.of<HomeScreenBloc>(context)
          .add(GettingStreamDataFirestore());
    }
  }
}
