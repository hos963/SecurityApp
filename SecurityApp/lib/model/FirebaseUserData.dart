import 'dart:collection';

class FirebaseUserData {
  FirebaseUserData(
      {this.udid,
      this.name,
      this.email,
      this.phonenumber,
      this.typeofuser,
      this.pic,
      this.pass,
      this.isactive = true,
      this.devicesList});

  String name;
  String email;
  String pass;
  String udid;
  String phonenumber;
  int typeofuser;
  bool isactive = true;
  String pic;
  List<dynamic> devicesList = new List();

  factory FirebaseUserData.fromJson(Map<String, dynamic> parsedJson) {
    return FirebaseUserData(
      udid: parsedJson['udid'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      phonenumber: parsedJson['contactnumber'],
      isactive: parsedJson['isactive'],
      devicesList: parsedJson.containsKey("devicesList")
          ? parsedJson['devicesList']
          : null,
      typeofuser:
          parsedJson.containsKey("typeofuser") ? parsedJson['typeofuser'] : 0,
      pic: parsedJson['pic'],
    );
  }

  Map<String, dynamic> FirebaseUSertoMap(FirebaseUserData firebaseUserData){
    Map<String, dynamic> map = new HashMap<String, dynamic>();

   map['udid']= firebaseUserData.udid;
   map['name'] = firebaseUserData.name;
   map['email'] = firebaseUserData.email;
   map['contactnumber'] = firebaseUserData.phonenumber;
   map['isactive']= firebaseUserData.isactive;

   map['pic']= firebaseUserData.pic != null ? firebaseUserData.pic : "";

    map['devicesList']= firebaseUserData.devicesList != null ? firebaseUserData.devicesList : null;
    map['typeofuser']= firebaseUserData.typeofuser != null ? firebaseUserData.typeofuser : 0;

    return map;

  }


}
