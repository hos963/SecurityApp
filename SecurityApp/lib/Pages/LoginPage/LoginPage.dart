import 'dart:convert';

import 'package:Metropolitane/MobileApp/MobileapQuestions/Screens/QuizDashboard.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/AppWidget.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizStrings.dart';
import 'package:Metropolitane/MobileApp/MobileapQuestions/utils/QuizWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/Pages/LoginPage/login_bloc.dart';
import 'package:Metropolitane/Router/router.dart' as Router;
import 'package:Metropolitane/Utilities/LocalAuthenticationService.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/WebArea/LoginWeb/LoginWebPage.dart';
import 'package:Metropolitane/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthenticationService _localAuth =
      locator<LocalAuthenticationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginBloc = BlocProvider.of<LoginBloc>(context);

    String usernamepass =
        PreferenceUtils.getString(PrefKey.UsernamePassword, null);
    if (usernamepass != null && usernamepass != "") {
      Map<String, dynamic> usernamepassmap = jsonDecode(usernamepass);
      _emailController.text = usernamepassmap['username'];
      _passwordController.text = usernamepassmap['password'];
      loginBloc.rememberme = true;
      // _emailController.text = "hans@itssignals.com";
      // _passwordController.text = "NTsdEHW9vpZm52N";

    }
    // _emailController.text = "hans@itssignals.com";
    //_passwordController.text = "NTsdEHW9vpZm52N";
  }

  var progress;

  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            progress = ProgressHUD.of(context);
            progress.showWithText('Loading...');
            progress.show();
          }

          if (state is FailedAuthError) {
            if (progress != null) {
              progress.dismiss();
            }
          }

          if (state is UserDataLoaded) {
            if (progress != null) {
              progress.dismiss();
            }
            //print("User data " + state.userdata);

            if (loginBloc.rememberme == true) {
              String userpassstr = jsonEncode(<String, String>{
                'username': _emailController.text,
                'password': _passwordController.text,
              });

              PreferenceUtils.setString(PrefKey.UsernamePassword, userpassstr);
            } else {
              PreferenceUtils.setString(PrefKey.UsernamePassword, null);
            }

            PreferenceUtils.setString(PrefKey.UserToken, state.userdata).then(
                (value) => Navigator.pushReplacementNamed(
                    context, Router.QuizDashboardRoute));
          }

          if (state is SuccessFull) {
            if (progress != null) {
              progress.dismiss();
            }

            Map<String, dynamic> message = jsonDecode(state.message);

            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                      imagepath: "",
                      title: "Message",
                      description: message['message'],
                      buttonText: "OK",
                    ));

            print("Password Message " + state.message);
          }
        },
        child: Scaffold(
          body: mainBodyWidget(),
        ),
      );
    }));
  }

  // Widget LoadWhichWidget(){
  //
  //
  //   return LayoutBuilder(builder: (context, constraints) {
  //     if (constraints.maxWidth < 700) {
  //       return mainBodyWidget();
  //     } else {
  //       return LoginWebPage();
  //     }
  //   });
  //
  // }

  Widget mainBodyWidget() {
    print("Main run");
    return Container(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Image.asset(
                    "assets/images/metlogo.png",
                    width: 120,
                    height: 120,
                  )),
              Container(
                  margin: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlueAccent.withAlpha(10),
                    border: new OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlueAccent.withAlpha(10),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                print("state changes${state.toString()}");
                return Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Checkbox(
                          value: loginBloc.rememberme,
                          activeColor: Colors.black,
                          onChanged: (bool newValue) {
                            loginBloc.add(RememberMeClick(remeberme: newValue));
                          }),
                      Text('Remember me '),
                    ],
                  ),
                );
              }),
              TextButton(
                onPressed: () {
                  // loginBloc.add(IncrementEvent());
                  _showDialog(context);
                },

                child: Text('Forgot Password?'),
              ),

              Container(
                  margin: EdgeInsets.all(24.0),
                  child: quizButton(
                      textContent: quiz_lbl_continue,
                      onPressed: () {

                        _LoginButtonClick();
                        // setState(() {
                        //   launchScreen(context, QuizDashboard.tag);
                        // });



                      }))


              // Container(
              //     height: 50,
              //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //     child: RaisedButton(
              //       textColor: Colors.white,
              //       color: Colors.black,
              //       child: Text('Login'),
              //       onPressed: () {
              //         //   Navigator.pushNamed(context, Router.HomeScreenRoute);
              //         _LoginButtonClick();
              //       },
              //     )),
              // Container(
              //     padding: EdgeInsets.all(30),
              //     margin: EdgeInsets.only(top: 30),
              //     child: Row(
              //       children: <Widget>[
              //         Text(''),
              //         FlatButton.icon(
              //           icon: Image.asset('assets/images/fingerprint.png'),
              //           textColor: Colors.black,
              //            label: Text(""),
              //           onPressed: () {
              //             print("finderpring");
              //             _showingFingerPrintDialog();
              //           },
              //         )
              //       ],
              //       mainAxisAlignment: MainAxisAlignment.center,
              //     )),
            ],
          )),
    );
  }

  _showingFingerPrintDialog() async {
    await _localAuth.authenticate();
    if (_localAuth.isAuthenticated == true) {
      _emailController.text = PreferenceUtils.getString(PrefKey.Useremailbio);
      _passwordController.text = PreferenceUtils.getString(PrefKey.Userpassbio);
      _LoginButtonClick();
    }else{


    }
// //     // showDialog(
// //     //   context: context,
// //     //   builder: (BuildContext context) => CustomDialog(
// //     //     imagepath: "assets/images/fingerprinticon.png",
// //     //     title: "Sign in",
// //     //     description:
// //     //         "Confirm fingerprint to continue\n touch the fingerprint sensor",
// //     //     buttonText: "Cancel",
// //     //   ),
// //     // );
//
 //Navigator.pushNamed(context, Router.BioMatricAuthRoute);

  }

  _LoginButtonClick() {
    if (!_emailController.text.toString().isEmpty &&
        !_passwordController.text.toString().isEmpty) {
      loginBloc.add(LoginWithCredentialsPressed(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString()));
    }
  }

  _showDialog(BuildContext context) async {
    final TextEditingController _emailController = TextEditingController();
    await showDialog<String>(
      context: context,
      builder: (_) => new AlertDialog(
        content: Container(
          height: 120,
          child: new Column(
            children: <Widget>[
              Container(
                  child: Text(
                      "Enter Your email address and you will receive the password on your email address")),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 40,
                child: Center(
                  child: new TextField(
                    controller: _emailController,
                    autofocus: true,
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      hintText: 'Email Address',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                String emailaddress = _emailController.text;

                loginBloc.add(ForgetPassword(email: emailaddress));
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
