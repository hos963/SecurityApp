import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:Metropolitane/FirebaseService/FirebaseService.dart';
import 'package:Metropolitane/model/FirebaseUserData.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthServices {
  FirebaseAuthServices._privateConstructor();

  static final FirebaseAuthServices _instance =
      FirebaseAuthServices._privateConstructor();

  static FirebaseAuthServices get instance => _instance;

  Future<User> FirebaseAuthentication(String username, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: pass);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String> FirebaseWebCreateUserAccount(
      FirebaseUserData firebaseUserData) async {
    final http.Response response = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAr8N491xUFBVo_4Iq5mOuqoHTrp9DFAKs',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': firebaseUserData.email,
        'password': firebaseUserData.pass,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.



      return jsonDecode(response.body)["localId"];
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed To Create Account');
    }
  }
}
