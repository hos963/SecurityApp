import 'dart:convert';

class EventsModel {
  EventsModel();

  String eventname;
  String deviceid;
  String dataname;
  String onlydata;
  String publishtime;
  Map<String, dynamic> alldata;

  factory EventsModel.fromJson(Map<String, dynamic> data) {
    EventsModel orderToFirebase = new EventsModel();
    orderToFirebase.eventname = data['eventname'];

    if (orderToFirebase.eventname == "debug" ||
        orderToFirebase.eventname == "failure") {
      orderToFirebase.onlydata = data['data'];
    } else {
      orderToFirebase.onlydata =  data['data'];
      orderToFirebase.alldata = jsonDecode(data['data']);
    }
    orderToFirebase.deviceid = data['deviceid'];
    orderToFirebase.publishtime = data['publishtime'];

    return orderToFirebase;
  }
}
