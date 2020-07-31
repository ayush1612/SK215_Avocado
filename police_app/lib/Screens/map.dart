//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import '../constants.dart';

class MapActive extends StatefulWidget {
  MapActive({this.p});
  static String id = "/mapactive";

  final p;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapActive> {
  Position p;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      p = widget.p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: FlutterMap(
        options: MapOptions(
//        center: Lat,
          center: new LatLng(p.latitude, p.longitude),
//          center: ,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
//                "https://api.mapbox.com/styles/v1/ayushujjwal/ck261hzxq076g1cpcsld1tx6n/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXl1c2h1amp3YWwiLCJhIjoiY2syNjFiMzE3Mm8xdTNlcXRveXE1ZThpNyJ9.FfcQ13NnrKmGunUdcUrSVw",
                "https://api.mapbox.com/styles/v1/ayushujjwal/ck95adt5v4wcx1iqs4lgfr7ly/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXl1c2h1amp3YWwiLCJhIjoiY2syNjFiMzE3Mm8xdTNlcXRveXE1ZThpNyJ9.FfcQ13NnrKmGunUdcUrSVw",
//                "https://api.mapbox.com/styles/v1/ayushujjwal/ck95adt5v4wcx1iqs4lgfr7ly/wmts?access_token=pk.eyJ1IjoiYXl1c2h1amp3YWwiLCJhIjoiY2syNjFiMzE3Mm8xdTNlcXRveXE1ZThpNyJ9.FfcQ13NnrKmGunUdcUrSVw",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiYXl1c2h1amp3YWwiLCJhIjoiY2syNjFiMzE3Mm8xdTNlcXRveXE1ZThpNyJ9.FfcQ13NnrKmGunUdcUrSVw',
              'id': 'mapbox.mapbox-streets-v7',
            },
          ),
          MarkerLayerOptions(
            markers: [
              new Marker(
                width: 60.0,
                height: 100.0,
                point: LatLng(p.latitude, p.longitude),
//                point: new LatLng(51.5, -0.09),scree
                builder: (ctx) => Container(
                  child: Icon(
                    FontAwesomeIcons.mapMarkerAlt,
//                    semanticLabel: "Here is the location",
                    size: 100,
                    color: Color.fromARGB(255, 220, 20, 60),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
