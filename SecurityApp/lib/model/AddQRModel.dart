
class AddQRModel{

  String qrId;
  String locationName;
  String latitude;
  String longitude;
  bool isactive;

  AddQRModel({this.qrId,this.locationName,this.latitude,this.longitude,this.isactive});
  factory AddQRModel.fromJson(Map<String, dynamic> parsedJson) {
    return AddQRModel(
        qrId: parsedJson['qrId'],
        locationName: parsedJson['locationName'],
        latitude: parsedJson['latitude'],
        longitude: parsedJson['longitude'],
        isactive: parsedJson['isactive']
    );
  }
}