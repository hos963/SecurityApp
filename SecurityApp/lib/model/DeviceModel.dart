
class DeviceModel {
  String devicename;
  String deviceid;
  int id;
  DeviceModel({ this.id, this.devicename, this.deviceid });
  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'devicename': devicename,
      'deviceid': deviceid
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static DeviceModel fromMap(Map<String, dynamic> map) {

    return DeviceModel(
     //   id: map['id'],
        devicename: map['devicename'],
        deviceid: map['deviceid']
    );
  }

}