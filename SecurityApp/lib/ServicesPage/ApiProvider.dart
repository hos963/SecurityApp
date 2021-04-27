import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:Metropolitane/Pages/HomeScreen/home_screen_bloc.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';

class ApiProvider {
  final _baseUrl = "https://api.particle.io";

  Future<String> AuthenticationLogin(String username, String password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get('$_baseUrl/v1/access_tokens',
        headers: <String, String>{'Authorization': basicAuth});
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception('Failed to Load User Code');
    }
  }

  Future<String> ForgetPassword(String username) async {
    Map<String, dynamic> body = {'username': username};

    final response = await http.post('$_baseUrl/v1/user/password-reset',
        //body: body,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception('Failed to Load User Code');
    }
  }

  String GetBasicAuth() {
    String usertokens = PreferenceUtils.getString(PrefKey.UserToken, null);

    List<dynamic> usernamepassmap = jsonDecode(usertokens);
    String lasttoken = usernamepassmap.last['token'];

    return 'Bearer $lasttoken';
  }

  Future<String> ResetTimeRepo(String deviceId) async {
    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/resetTimer',
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }

  Future<String> GenOnAPI(String deviceId) async {
    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/generatorOn',
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }

  Future<String> GenOFFAPI(String deviceId) async {
    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/generatorOff',
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }

  //readSetting
  Future<String> readSetting(String deviceId) async {
    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/readSetting',
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20));
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }

  Future<String> GenericEventCall(
      String deviceId, SelectedEventName eventName, var valuen) async {
    String nameevent;
    if (eventName == SelectedEventName.TimeZone) {
      nameevent = "tmz";
    } else if (eventName == SelectedEventName.StartVolt) {
      nameevent = "GenStartVolt";
    } else if (eventName == SelectedEventName.IgnitionAttemp) {
      nameevent = "ign_attmpt";
    } else if (eventName == SelectedEventName.IgnitionDelay) {
      nameevent = "ign_dly";
    } else if (eventName == SelectedEventName.ReportTime) {
      nameevent = "report_pd";
    } else if (eventName == SelectedEventName.OffVolt) {
      nameevent = "funGenOff_volt";
    } else {
      nameevent = "report_pd";
    }
    Map<String, dynamic> formMap = {
      "nameevent": valuen,
    };

    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/$nameevent',
        body: formMap,
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20),
      onTimeout: () {
        // time has run out, do what you wanted to do
        return  throw Exception("Exception Timeout");
      },);

   

    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }

  Future<String> ReadSettingApiCall(
      String deviceId) async {
    String nameevent = "readSetting";

    Map<String, dynamic> formMap = {
      nameevent: "1",
    };

    final response = await http.post(
        '$_baseUrl/v1/devices/$deviceId/$nameevent',
        body: formMap,
        headers: <String, String>{'Authorization': GetBasicAuth()}).timeout(Duration(seconds: 20),
      onTimeout: () {
        // time has run out, do what you wanted to do
        return  throw Exception("Exception Timeout");
      },);;
    print(response.body.toString());

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String errrr = "Some error From Server";
      if (response.body != null) {
        errrr = response.body;
      }
      throw Exception(errrr);
    }
  }


}
