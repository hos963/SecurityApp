import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/Utilities/PreferenceUtils.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:Metropolitane/model/JsonAuthstr.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repository _repository = Repository();
  FirebaseService firebaseService = FirebaseService();

  LoginBloc() : super(LoginInitial());

  bool rememberme = false;

  int count = 0;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
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

    if (event is IncrementEvent) {
      count++;

      yield IncrementStatus(count);
    }

    if (event is ForgetPassword) {
      yield* _mapForgetPasswordPressedToState(email: event.email);
    }
  }

  Stream<LoginState> _mapForgetPasswordPressedToState({
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

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginLoading();
    try {
      //  String userjson = await _repository.AuthenticationUSer(email, password);
      var fibaseuser = await FirebaseAuthServices.instance
          .FirebaseAuthentication(email, password);
      if (fibaseuser != null) {
        FirebaseUserData firebaseuser =
            await firebaseService.gettingNormalUsersData(fibaseuser);
        if (firebaseuser != null) {
          if (firebaseuser.isactive) {
            if (firebaseuser.pic != null) {
              PreferenceUtils.setString(PrefKey.UserPic, firebaseuser.pic);
            } else {
              PreferenceUtils.setString(PrefKey.UserPic, null);
            }

         String userdatacomplete =  jsonEncode(firebaseuser.FirebaseUSertoMap(firebaseuser));

            PreferenceUtils.setString(PrefKey.UserCompleteData, userdatacomplete);
            yield UserDataLoaded(JsonAuthStr.jsonauth);
          } else {
            yield FailedAuthError("You have been blocked from server");
          }
        } else {
          yield FailedAuthError("Authentication error");
        }
      } else {
        yield FailedAuthError("Authentication error");
      }
    } catch (e) {
      yield FailedAuthError(e.toString());
    }
  }
}
