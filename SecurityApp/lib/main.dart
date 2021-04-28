import 'package:Metropolitane/WebArea/Createaddress/createAddresswebbloc/web_create_address_boc_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddLock/Bloc/add_lock_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPatrol/Bloc/add_patrol_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPropertyInspection/Bloc/add_inspection_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddUnLock/Bloc/add_unlock_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:Metropolitane/Database/DeviceDatabase.dart';
import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:Metropolitane/Pages/EventScreen/event_bloc.dart';
import 'package:Metropolitane/Pages/HomeScreen/home_screen_bloc.dart';
import 'package:Metropolitane/Pages/SettingpageScreen/setting_bloc.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebBloc/Weblogin_bloc.dart';
import 'package:Metropolitane/WebArea/MainWeb/mainwebbloc/web_main_bloc.dart';
import 'CustomColors/CustomColors.dart' as customcolor;
import 'Pages/LoginPage/login_bloc.dart';
import 'Router/router.dart' as router;
import 'Utilities/LocalAuthenticationService.dart';
import 'WebArea/MainWeb/AddAlarm/Blocs/add_alarm_bloc.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => LocalAuthenticationService());
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await DeviceDatabase.init();
  await PreferenceUtils.init();
   setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        BlocProvider(
          create: (_) => EventBloc(),
        ),
        BlocProvider(
          create: (_) => SettingBloc(),
        ),
        BlocProvider(
          create: (_) => HomeScreenBloc(),
        ),
        BlocProvider(
          create: (_) => WebLoginBloc(),
        ),
        BlocProvider(
          create: (_) => WebCreateAddressBocBloc(),
        ),

        BlocProvider(
          create: (_) => WebMainBloc(),
        ),

        BlocProvider(
          create: (_) => AddAlarmBloc(),
        ),

        BlocProvider(
          create: (_) => AddPatrolBloc(),
        ),
        BlocProvider(
          create: (_) => AddLockBloc(),
        ),

        BlocProvider(
          create: (_) => AddUnLockBloc(),
        ),
        BlocProvider(
          create: (_) => AddPropertyInspectionBloc(),
        ),

      ],
      child: MaterialApp(
          title: 'International Traffic',
          theme: customcolor.CompanyThemeData,
          initialRoute: router.LoginPageRoute,
          onGenerateRoute: router.generateRoute),
    );

  }

}
