class AddressAlarmModel{
  String adressId;
  String locationName;
  String latitude;
  String longitude;
  bool isactive;

  AddressAlarmModel({this.adressId,this.locationName,this.latitude,this.longitude,this.isactive});
  factory AddressAlarmModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddressAlarmModel(
      adressId: parsedJson['adressId'],
      locationName: parsedJson['locationName'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
      isactive: parsedJson['isactive']
    );
  }
}