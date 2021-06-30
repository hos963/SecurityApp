import 'package:Metropolitane/FirebaseService/FirebaseAuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Metropolitane/Router/router.dart' as Router;
class SideMenu extends StatelessWidget {
  @override
  Widget build(context) => ListView(
      children: [
        TextButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("DashBoard"),
            )
        ),
        TextButton(
            onPressed: () {

FirebaseAuth.instance.signOut();
Navigator.pushReplacementNamed(context, Router.LoginPageRoute);
            },
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            )
        )
      ]
  );
}
