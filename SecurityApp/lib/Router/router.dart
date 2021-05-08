import 'package:Metropolitane/MobileApp/MobileapQuestions/FillSurvayQuestions/FilledQuestionsSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/LockSurveyQuestion/LockQuestionsSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PatrolSurveyQuestion/PatrolQuestionSurvey.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/PropertyInspectionQuestions/PropertyInspectionQuestions.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizDashboard.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizHomeDashboard.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizNewList.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizSearch.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/UnLockSurveyQuestion/UnLockQuestionsSurvey.dart';
import 'package:Metropolitane/WebArea/Createaddress/CreateAddress.dart';
import 'package:Metropolitane/WebArea/MainDashBoardWeb/MainDashBoardWeb.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddAlarm/AddAlarmPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddAlarm/ListUsersSelection.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddLock/AddLockPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPatrol/AddPatrolPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddPropertyInspection/AddPropertyInspectionPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/AddUnLock/AddUnLockPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/LockReport/ReportPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/ReportPage/ReportPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/ReportPage/ReportdetailPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/LockReport/LockReportdetailPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/UnLockReport/ReportPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/UnLockReport/UnLockReportdetailPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/PatrolReport/PatrolReportdetailPage.dart';
import 'package:Metropolitane/WebArea/MainWeb/PatrolReport/ReportPage.dart';
import 'package:Metropolitane/model/AddAlarmModel.dart';
import 'package:Metropolitane/model/AddLockModel.dart';
import 'package:Metropolitane/model/AddPatrolModel.dart';
import 'package:Metropolitane/model/AddPropertyInspectionModel.dart';
import 'package:Metropolitane/model/AddUnlockModel.dart';
import 'package:Metropolitane/model/LockQuestionareModel.dart';
import 'package:Metropolitane/model/PropertyInspectionQuestionareModel.dart';
import 'package:Metropolitane/model/QuestionareModel.dart';
import 'package:Metropolitane/model/UnLockQuestionareModel.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/Pages/BioMatricAuth.dart';
import 'package:Metropolitane/Pages/LoginPage/LoginPage.dart';
import 'package:Metropolitane/Pages/MainHomeScreen.dart';
import 'package:Metropolitane/Pages/SignupPage.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebPage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:Metropolitane/WebArea/MainWeb/pages/AddingDeviceIdToUser/AddingDeviceIdtoUser.dart';
import 'package:Metropolitane/WebArea/MainWeb/pages/main_page.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

const String HomeScreenRoute = 'homescreen';
const String LoginPageRoute = 'LoginPageroute';

const String signupPageRoute = 'SignupScreen';
const String creditCardPageroute = 'CreditCardPage';

const String dashboardPageroute = 'DashBoardPage';

const String chargenowpagePageroute = 'ChargeNowPage';
const String maplocationPageroute = 'maplocationPage';
const String WEBHomeScreenRoute = 'WEBHomeScreenRoute';
const String BioMatricAuthRoute = 'BioMatricAuthRoute';

const String MainDashBoardWebRoute = 'MainDashBoardWeb';

const String AddingDevideIdtoUserRoute = 'AddingDevideIdtoUser';

const String CreateAddressRoute = 'CreateAddressroute';

const String AddAlarmPageRoute = 'AddAlarmPageroute';

const String AddPatrolPageRoute = 'AddPatrolPageroute';

const String AddLockPageRoute = 'AddLockPageroute';

const String AddUnLockPageRoute = 'AddUnLockPageroute';

const String AddPropertyInspectionPageRoute = 'AddPropertyInspectionPageroute';

const String ReportLockPageRoute = 'addReportLockPageRoute';
const String ReportDetailLockPageRoute = 'addReportDetailLockPageRoute';


const String ReportUnLockPageRoute = 'addReportUnLockPageRoute';
const String ReportDetailUnLockPageRoute = 'addReportDetailUnLockPageRoute';

const String ReportsPatreolPage = 'addReportPatreolPage';
const String PatrolReportsdetailPage = 'addPatrolReportdetailPage';

const String ReportAlarmPageRoute = 'addReportRoutePage';
const String ReporDetailtAlarmPageRoute = 'addReportDetailRoutePage';

const String ListUsersSelectionRoutePage = 'ListUsersSelectionRoutePage';
const String QuizDashboardRoute = 'QuizDashboard';

const String QuizListingroute = 'QuizListingroute';
const String QuizSearchroute = 'QuizSearchroute';
const String FilledQuestionsSurveyroute = 'FilledQuestionsSurveyroute';
const String LockQuestionsSurveyroute = 'LockQuestionsSurveyroute';
const String UnLockQuestionsSurveyroute = 'UnLockQuestionsSurveyroute';
const String PatrolQuestionsSurveyroute = 'PatrolQuestionsSurveyroute';
const String PropertyQuestionsSurveyroute = 'PropertyQuestionsSurveyroute';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      if (kIsWeb) {
        return MaterialPageRoute(builder: (context) => LoginWebPage());
      } else {
        return MaterialPageRoute(builder: (context) => LoginPage());
      }
      break;

    case LoginPageRoute:
      if (kIsWeb) {
        return MaterialPageRoute(builder: (context) => LoginWebPage());
      } else {
        return MaterialPageRoute(builder: (context) => LoginPage());
      }

      break;

    case signupPageRoute:
      return MaterialPageRoute(builder: (context) => SignupPage());
    case HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => MainHomeScreen());
    case WEBHomeScreenRoute:
      return MaterialPageRoute(builder: (context) => WebMainPage());
    case MainDashBoardWebRoute:
      return MaterialPageRoute(builder: (context) => MainDashBoardWeb());

    case BioMatricAuthRoute:
      return MaterialPageRoute(builder: (context) => BioMatricAuth());

    case AddingDevideIdtoUserRoute:
      FirebaseUserData firebaseUserData = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddingDevideIdtoUser(firebaseUserData));

    case CreateAddressRoute:
      return MaterialPageRoute(builder: (context) => CreateAddress());
    case AddAlarmPageRoute:
      return MaterialPageRoute(builder: (context) => AddAlarmPage());

    case AddPatrolPageRoute:
      return MaterialPageRoute(builder: (context) => AddPatrolPage());

    case AddLockPageRoute:
      return MaterialPageRoute(builder: (context) => AddLockPage());

    case AddUnLockPageRoute:
      return MaterialPageRoute(builder: (context) => AddUnLockPage());

    case AddPropertyInspectionPageRoute:
      return MaterialPageRoute(
          builder: (context) => AddPropertyInspectionPage());

    case ReportAlarmPageRoute:
      return MaterialPageRoute(builder: (context) => ReportAlarmPage());

      case ReportLockPageRoute:
      return MaterialPageRoute(builder: (context) => ReportLockPage());

      case ReportDetailLockPageRoute:
        QuestionareModel questionareModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => LockReportdetailPage(questionareModel));


      case ReportUnLockPageRoute:
      return MaterialPageRoute(builder: (context) => ReportUnLockPage());

      case ReportDetailUnLockPageRoute:
        QuestionareModel questionareModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => UnLockReportdetailPage(questionareModel));


      case ReportsPatreolPage:
      return MaterialPageRoute(builder: (context) => ReportPatreolPage());

      case PatrolReportsdetailPage:
        QuestionareModel questionareModel = settings.arguments;
      return MaterialPageRoute(builder: (context) => PatrolReportdetailPage(questionareModel));

    case ReporDetailtAlarmPageRoute:
      QuestionareModel questionareModel = settings.arguments;

      return MaterialPageRoute(
          builder: (context) => ReportdetailPage(questionareModel));

    case ListUsersSelectionRoutePage:
      return MaterialPageRoute(builder: (context) => ListUsersSelection());

    case QuizDashboardRoute:
      return MaterialPageRoute(builder: (context) => QuizHomeDashboard());

    case QuizListingroute:
      return MaterialPageRoute(builder: (context) => QuizListing());

    case QuizSearchroute:
      return MaterialPageRoute(builder: (context) => QuizSearch());

    case FilledQuestionsSurveyroute:
      AddAlarmModel addAlarmModel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FilledQuestionsSurvey(addAlarmModel));

      case LockQuestionsSurveyroute:
      AddLockModel addLockModel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => LockQuestionSurvey(addLockModel));

    case UnLockQuestionsSurveyroute:
      AddUnlockModel addUnlockModel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UnLockQuestionsSurvey(addUnlockModel));

      case PatrolQuestionsSurveyroute:
      AddPatrolModel addPatrolModel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PatrolQuestionSurvey(addPatrolModel));

      case PropertyQuestionsSurveyroute:
        AddPropertyInspectionModel addPropertyInspectionModel = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PropertyInspectionQuestions(addPropertyInspectionModel));

    default:
      return MaterialPageRoute(
          builder: (context) => Center(
                child: Text("Route not found"),
              ));
  }
}
