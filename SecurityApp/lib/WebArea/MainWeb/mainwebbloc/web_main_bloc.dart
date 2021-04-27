import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/ServicesPage/Repository.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';

part 'web_main_event.dart';

part 'web_main_state.dart';

class WebMainBloc extends Bloc<WebMainEvent, WebMainState> {
  Repository _repository = Repository();
  bool isactiveuser = true;

  FirebaseService _firebaseService = new FirebaseService();
  List<FirebaseUserData> listfb = new List();


  HashMap checkbox = new HashMap<int,bool>();
  WebMainBloc() : super(WebMainInitial());

  @override
  Stream<WebMainState> mapEventToState(
    WebMainEvent event,
  ) async* {
    if (event is CreateUserAccountEvent) {
      yield* _mapLoginWithCredentialsPressedToState(
          firebaseUserData: event.userdata);
    }

    if (event is getFirebaseUserslistevetn) {
      yield* _mapgetListUserToState();
    }


    if (event is setcheckisActiveUser) {


      yield* _maptoActivieUser(event.userid,event.isactive,event.position);

    }


    if(event is DeletingDataweb){


      yield* _mapDeletingData(dateTimeRange:event.dateTimeRange);

    }


  }



  Stream<WebMainState> _maptoActivieUser(String userid,bool isactive,int position) async* {
    yield WebMainLoading();
    var response = await _firebaseService.settinguseractive(isactive,userid);

    checkbox[position] = isactive;

    this.isactiveuser = isactive;
   add(getFirebaseUserslistevetn());

    yield SuccessfullyCreatedAccountstate(
        "Successfully Updated" );


  }



  Stream<WebMainState> _mapLoginWithCredentialsPressedToState(
      {FirebaseUserData firebaseUserData}) async* {
    yield WebMainLoading();
    try {
      var responseauth = await FirebaseAuthServices.instance
          .FirebaseWebCreateUserAccount(firebaseUserData);

      if (responseauth != null) {
        firebaseUserData.udid = responseauth;



        var response = _firebaseService.AddingUserData(firebaseUserData);

        // FirebaseUserData firebaseUserData =  await  _firebaseService.GettingUserData(userfirebase);

        if (response != null) {
          yield SuccessfullyCreatedAccountstate(
              "Successfully Created" + response.toString());
        } else {
          yield FailedToCreateAccount("Server Error");
        }
      } else {
        yield FailedToCreateAccount("Server Error");
      }
    } catch (e) {
      yield FailedToCreateAccount(e.toString());
    }
  }

  Stream<WebMainState> _mapgetListUserToState() async* {
  //  yield WebMainLoading();
    try {
      var response = await _firebaseService.gettingAllUsersData();

      if (response.isNotEmpty) {
        listfb.clear();

        listfb = response;


      }
      // FirebaseUserData firebaseUserData =  await  _firebaseService.GettingUserData(userfirebase);

      if (response != null) {
        yield gettinglistdatastate();
      } else {
        yield FailedToCreateAccount("Server Error");
      }
    } catch (e) {
      yield FailedToCreateAccount(e.toString());
    }
  }

  int i = 0;
  List<String> liststringidss;
  Stream<WebMainState> _mapDeletingData(
      {DateTimeRange dateTimeRange}) async* {
    yield WebMainLoading();


      FirebaseService firebaseService = new FirebaseService();

    liststringidss =   await  firebaseService.GetAllReadingdata(dateTimeRange);
    i = liststringidss.length-1;
   // await  FirebaseFirestore.instance.collection("Readingdata").doc(liststringidss[liststringidss.length-1]).delete();

   await  DeletingDatawithid(liststringidss);


    yield SuccessfullyCreatedAccountstate(
        "Successful" );

  }

  Future<Function> DeletingDatawithid(List<String> ids)  {

    WriteBatch batch = FirebaseFirestore.instance.batch();


    for(int i=ids.length -1;i<0 ; i--){

      batch.delete(FirebaseFirestore.instance.collection("Readingdata").doc(liststringidss[i]));
    }
     batch.commit();
    // await  FirebaseFirestore.instance.collection("Readingdata").doc(id).delete();
    // i--;
    // if(i <= 0){
    //
    //   DeletingDatawithid(liststringidss[i]);
    // }
  }



}
