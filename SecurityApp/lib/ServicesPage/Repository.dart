import 'package:Metropolitane/Pages/HomeScreen/home_screen_bloc.dart';

import 'ApiProvider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<String> AuthenticationUSer(String email, String pass) =>
      appApiProvider.AuthenticationLogin(email, pass);

  Future<String> ForgetPassword(String email) =>
      appApiProvider.ForgetPassword(email);

  Future<String> ResetTimerEventRepo(String deviceid) =>
      appApiProvider.ResetTimeRepo(deviceid);
  Future<String> GeneratorOnEventRepo(String deviceid) =>
      appApiProvider.GenOnAPI(deviceid);
  Future<String> GeneratorOffEventRepo(String deviceid) =>
      appApiProvider.GenOFFAPI(deviceid);

  Future<String> CallingFunctionsWithNameEvents(String deviceid,SelectedEventName eventName,var value) =>
      appApiProvider.GenericEventCall(deviceid,eventName,value);
  Future<String> ReadSettingApiCall(String deviceid) =>
      appApiProvider.ReadSettingApiCall(deviceid);
}
