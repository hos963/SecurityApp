import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

part 'Weblogin_event.dart';

part 'Weblogin_state.dart';

class WebLoginBloc extends Bloc<WebLoginEvent, WebLoginState> {
  Repository _repository = Repository();
  FirebaseService _firebaseService = new FirebaseService();
  WebLoginBloc() : super(LoginInitial());

  bool rememberme = false;

  int count = 0;

  @override
  WebLoginState get initialState => LoginInitial();

  @override
  Stream<WebLoginState> mapEventToState(
      WebLoginEvent event,
  ) async* {
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }

    if (event is RememberMeClick) {
      if (rememberme == true) {
        rememberme = false;

        yield CheckboxStatus(rememberme);
      } else {
        rememberme = true;
        yield CheckboxStatus(rememberme);
      }

    }

    if(event is IncrementEvent){

      count++;

      yield IncrementStatus(count);
    }

    if (event is ForgetPassword) {
      yield* _mapForgetPasswordPressedToState(email: event.email);
    }
  }

  Stream<WebLoginState> _mapForgetPasswordPressedToState({
    String email,
  }) async* {
    yield LoginLoading();
    try {
      String successfull = await _repository.ForgetPassword(email);
      yield SuccessFull(successfull);
    } catch (e) {
      yield FailedAuthError(e.toString());
    }
  }

  Stream<WebLoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,

  }) async* {


    yield LoginLoading();
    try {
      User userfirebase =  await FirebaseAuthServices.instance.FirebaseAuthentication(email,password);
      if(userfirebase != null){

        FirebaseUserData firebaseUserData =  await  _firebaseService.GettingUserData(userfirebase);

        yield UserDataLoaded(firebaseUserData);
      }else{

        yield FailedAuthError("Server Error");
      }



    } catch (e) {
      yield FailedAuthError(e.toString());
    }
  }
}
