import 'dart:convert';

class ReadSettingModel{
  ReadSettingModel();
  var genStartVolt;
  var ignAttempt;
  var ignitionSettle;
  var genStopVoltage;
  var reporting_pd;
  var timeZone ;

  String devName;
  String deviceid;
  String publishtime;
  Map<String, dynamic> alldata;

  factory ReadSettingModel.fromJson(Map<String, dynamic> data) {
    ReadSettingModel orderToFirebase = new ReadSettingModel();

    orderToFirebase.alldata = jsonDecode(data['data']);
    orderToFirebase.deviceid = data['deviceid'];
    orderToFirebase.publishtime = data['publishtime'];

    orderToFirebase.genStartVolt = orderToFirebase.alldata["genStartVolt"];
    orderToFirebase.ignAttempt = orderToFirebase.alldata["ignAttempt"];

    orderToFirebase.ignitionSettle = orderToFirebase.alldata["ignitionSettle"];

    orderToFirebase.genStopVoltage = orderToFirebase.alldata["genStopVoltage"];
    orderToFirebase.reporting_pd = orderToFirebase.alldata["reporting_pd"];
    orderToFirebase.timeZone = orderToFirebase.alldata["timeZone"];

    orderToFirebase.devName = orderToFirebase.alldata["devName"];

    return orderToFirebase;
  }
  factory ReadSettingModel.fromJson2(Map<String, dynamic> data) {
    ReadSettingModel orderToFirebase = new ReadSettingModel();

    orderToFirebase.alldata =data;
    orderToFirebase.deviceid = data['deviceid'];
    orderToFirebase.publishtime = data['publishtime'];

    orderToFirebase.genStartVolt = orderToFirebase.alldata["genStartVolt"];
    orderToFirebase.ignAttempt = orderToFirebase.alldata["ignAttempt"];

    orderToFirebase.ignitionSettle = orderToFirebase.alldata["ignitionSettle"];

    orderToFirebase.genStopVoltage = orderToFirebase.alldata["genStopVoltage"];
    orderToFirebase.reporting_pd = orderToFirebase.alldata["reporting_pd"];
    orderToFirebase.timeZone = orderToFirebase.alldata["timeZone"];

    orderToFirebase.devName = orderToFirebase.alldata["devName"];

    return orderToFirebase;
  }



   double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value;
    }
  }

}

