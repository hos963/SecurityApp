/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';


class GoogleMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text('This is a map that is showing (51.5, -0.9).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09),
                  zoom: 5.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),

                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}*/

import 'dart:html';

import 'package:Metropolitane/WebArea/MainWeb/commons/theme.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps/google_maps.dart' hide Icon;
import 'dart:ui' as ui;

class GoogleMaps extends StatefulWidget {
  var myLatlng = new LatLng(30.2669444, -97.7427778);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = new MapOptions()
        ..zoom = 8
        ..center = new LatLng(30.2669444, -97.7427778);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = new GMap(elem, mapOptions);

      final marker = Marker(MarkerOptions()
        ..position = widget.myLatlng
        ..map = map
        ..draggable = true
        ..title = 'Select Location');

      String contentString = "Selected point";

      var infoWindow =
      InfoWindow(InfoWindowOptions()..content = contentString);

     marker.onClick.listen((event) => infoWindow.open(map, marker));

      marker.onDragend.listen((event) {
        widget.myLatlng = event.latLng;
        print(event.latLng.lat.toString());
        print(event.latLng.lng.toString());
        print(widget.myLatlng);



      });

      return elem;
    });




    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Select Location',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(widget.myLatlng.toString());
            },
            child: Icon(
              Icons.save,
              color: Colors.white, // add custom icons also
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: drawerBgColor,
      ),
      body: HtmlElementView(viewType: htmlId),
    );
  }


/*  Future<Address> reverseGeocoding({double latitude, double longitude}){


  }*/





  /*
  getMap() {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {


      final mapOptions = new MapOptions()
        ..zoom = 8
        ..center = new LatLng(30.2669444, -97.7427778);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = new GMap(elem, mapOptions);

      final marker = Marker(MarkerOptions()
        ..position = this.myLatlng
        ..map = map
        ..draggable = true
        ..title = 'Hello World!');

      String contentString = "Hello $myLatlng";

      final infoWindow = InfoWindow(InfoWindowOptions()..content = contentString);

      marker.onClick.listen((event) => infoWindow.open(map, marker));

      marker.onDrag.listen((event) {

        this.myLatlng = event.latLng;
        print(event.latLng.lat.toString());
        print(event.latLng.lng.toString());
        print(this.myLatlng);


      });

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }*/

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
