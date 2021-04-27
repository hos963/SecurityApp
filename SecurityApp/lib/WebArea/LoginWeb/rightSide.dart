import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:Metropolitane/CustomColors/CustomColors.dart';
import 'package:Metropolitane/CustomWidget/CustomDialog.dart';
import 'package:Metropolitane/Router/router.dart' as Router;

import 'package:Metropolitane/WebArea/LoginWeb/LoginWebBloc/Weblogin_bloc.dart';

class RightSide extends StatefulWidget {
  @override
  _RightSideState createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  WebLoginBloc loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loginBloc = BlocProvider.of<WebLoginBloc>(context);

  //   _emailController.text = "admin@gmail.com";
   //  _passwordController.text = "123456";
  }

  var progress;

  @override
  Widget build(BuildContext context) {
    return completeBodyWidget();
  }

  Widget completeBodyWidget() {
    return ProgressHUD(child: Builder(builder: (context) {
      return BlocListener<WebLoginBloc, WebLoginState>(
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


            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  imagepath: "",
                  title: "Message",
                  description: state.errorstr,
                  buttonText: "OK",
                ));
          }

          if (state is UserDataLoaded) {
            if (progress != null) {
              progress.dismiss();
            }
            // state.userdata
            // print("User data " + state.userdata.email);

            if (state.userdata != null) {

              Navigator.pushReplacementNamed(
                  context, Router.MainDashBoardWebRoute);

            }
          }

          if (state is SuccessFull) {
            if (progress != null) {
              progress.dismiss();
            }

           // Map<String, dynamic> message = jsonDecode(state.message);

            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => CustomDialog(
            //           imagepath: "",
            //           title: "Message",
            //           description: message['message'],
            //           buttonText: "OK",
            //         ));

            print("Password Message " + state.message);
          }
        },
        child: mainBodyWidget(),
      );
    }));
  }

  Widget mainBodyWidget() {
    return Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1),
                  ),
                ],
              ),
              Container(
                  width: 120,
                  child: Image.asset('assets/images/metlogo.png')),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Enter your Admin Credential below',
                    style: TextStyle(color: Colors.grey),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 400,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: '',
                    icon: Icon(Icons.person),
                    // prefix: Image.asset('images/user.png'),
                    // prefixIcon: Icon(Icons.person),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              Container(
                width: 400,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.vpn_key),
                    // prefix: Image.asset('images/closed-lock.png'),
                    // prefixIcon: Icon(Icons.person),
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                      borderSide: BorderSide(
                        color: CustomColors.orangecolor,
                      ),
                      onPressed: () {
                        _LoginButtonClick();
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            color: CustomColors.orangecolor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(top: 20),
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: Colors.grey,
                  ))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  )),
            ],
          ),
        ));
  }

  _LoginButtonClick() {
    if (!_emailController.text.toString().isEmpty &&
        !_passwordController.text.toString().isEmpty) {
      loginBloc.add(LoginWithCredentialsPressed(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString()));
    }
  }
}
