import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/TopAraeAvatar.dart';
import 'package:Metropolitane/model/DeviceModel.dart';
import 'package:Metropolitane/model/EventsModel.dart';

import 'event_bloc.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventBloc homebloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homebloc = BlocProvider.of<EventBloc>(context);
    homebloc.add(GetListOfDevices());

    homebloc.add(GettingStreamDataFirestoreEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<EventBloc, EventState>(builder: (context, state) {
            List<DropdownMenuItem<String>> getDropDownMenuItems() {
              List<DropdownMenuItem<String>> items = new List();
              for (DeviceModel city in homebloc.DevicesList) {
                items.add(new DropdownMenuItem(
                    value: city.devicename, child: new Text(city.devicename)));
              }
              return items;
            }

            return (TopAreaAvatar(
                getDropDownMenuItems(), homebloc.selecteddevice, "event"));
          }),
          SizedBox(
            height: 10,
          ),
          ListingEventsDetail(),
        ],
      ),
    );
  }

  Map<String, EventsModel> eventmodelListMap;

  Widget ListingEventsDetail() {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      List<EventsModel> listevent = new List();

      if (state is EventListMapState) {
        eventmodelListMap = state.eventmaplist;

        eventmodelListMap.entries.forEach((e) {
          listevent.add(e.value);
        });

        Comparator<EventsModel> datecomparison =
            (a, b) => b.publishtime.compareTo(a.publishtime);

        listevent.sort(datecomparison);
      }

      return ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listevent.length,
        itemBuilder: (context, position) {
          return getindDeviceListRow(context, position, listevent);
        },
      );
    });
  }

  // BlocBuilder<EventBloc, EventState>(builder: (context, state) {
  //   List<EventsModel> listevent = new List();
  //   listevent.add(new EventsModel());
  //   if (state is EventListMapState) {
  //     eventmodelListMap = state.eventmaplist;
  //
  //     eventmodelListMap.entries.forEach((e) {
  //       listevent.add(e.value);
  //     });
  //   }
  //
  //   return ListView.builder(
  //     scrollDirection: Axis.vertical,
  //     shrinkWrap: true,
  //     itemCount: listevent.length,
  //     itemBuilder: (context, position) {
  //       return getindDeviceListRow(context, position,listevent);
  //     },
  //   );
  // });

  Widget getindDeviceListRow(
      BuildContext context, int index, List<EventsModel> listmodel) {
    if (index == 0) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          border:
              new Border(bottom: Divider.createBorderSide(context, width: 0.5)),
          color: Colors.black.withAlpha(100),
        ),
        child: Row(children: [
          Expanded(
            child: Text(
              'Time (Y:M:D)',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text('Events\nEvent',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text('Device Name',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center),
          ),
        ]),
      );

      ;
    } else {
      EventsModel eventsModel = listmodel[index - 1];

      String eventnamepri = "";

      if (eventsModel.eventname == "debug" ||
          eventsModel.eventname == "failure") {
        eventnamepri = eventsModel.onlydata;
      } else {
        eventnamepri = eventsModel.eventname;
      }
      return Container(
        height: 40,
        decoration: BoxDecoration(
          border:
              new Border(bottom: Divider.createBorderSide(context, width: 0.5)),
          color: (index % 2) == 0 ? Colors.black : Colors.white,
        ),
        child: Row(children: [
          Expanded(
            child: Text("${eventsModel.publishtime}",
                style: TextStyle(color: CustomColors.orangecolor, fontSize: 16),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text("${eventnamepri}",
                style: TextStyle(color: CustomColors.orangecolor, fontSize: 16),
                textAlign: TextAlign.center),
          ),
          Expanded(
            child: Text("${eventsModel.deviceid}",
                style: TextStyle(color: CustomColors.orangecolor, fontSize: 16),
                textAlign: TextAlign.center),
          ),
        ]),
      );
    }
  }
}

class Tablerowcelldto {
  String cell1;
  String cell2;
  String cell3;
  int type = 0;

  Tablerowcelldto(
      @required this.cell1, @required this.cell2, @required this.cell3,
      {this.type = 0});
}
