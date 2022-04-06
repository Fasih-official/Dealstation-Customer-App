import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
    LatLng currentLatLng = LatLng(52.2165157, 6.9437819);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      extendBodyBehindAppBar: true,
      body: getBody(size),
      appBar: getAppBar(),
      backgroundColor: Colors.white,
    );
  }

  getBody(Size size) {
   return GoogleMap(
     mapType: MapType.normal,
     initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 16),
     onMapCreated: (GoogleMapController controller) {
       // _controller.complete(controller);
     },
   );
  }
  getAppBar() {
    return PreferredSize(
      child: MyAppBar(),
      preferredSize: Size.fromHeight(65),
    );
  }
}
