import 'dart:convert';

class ReportsModel {
  ReportsModel();

  var Run_time;
  var Status;
  var Fuel;
  var Volt;
  var Sig;
  String devName;
  String deviceid;
  String publishtime;

  Map<String, dynamic> alldata;

  factory ReportsModel.fromJson(Map<String, dynamic> data) {
    ReportsModel orderToFirebase = new ReportsModel();

    orderToFirebase.alldata = jsonDecode(data['data']);
    orderToFirebase.deviceid = data['deviceid'];
    orderToFirebase.publishtime = data['publishtime'];

    orderToFirebase.Run_time = orderToFirebase.alldata["Run_time"];
    orderToFirebase.Status = orderToFirebase.alldata["Status"];

    orderToFirebase.Volt = orderToFirebase.alldata["Volt"];
    orderToFirebase.Fuel = orderToFirebase.alldata["Fuel"];

    orderToFirebase.devName = orderToFirebase.alldata["devName"];
    if(orderToFirebase.alldata.containsKey("Sig")){
      orderToFirebase.Sig = orderToFirebase.alldata["Sig"];
    }

    return orderToFirebase;
  }
}
