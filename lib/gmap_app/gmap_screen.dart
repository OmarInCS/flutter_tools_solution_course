
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapScreen extends StatefulWidget {
  const GMapScreen({Key? key}) : super(key: key);

  @override
  _GMapScreenState createState() => _GMapScreenState();
}

class _GMapScreenState extends State<GMapScreen> {

  late Future<Position> userLocation;
  late GoogleMapController mapController;
  Set<Marker> myLocations = Set();

  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("GPS is closed");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permission denied forever");
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userLocation = getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Map"),
      ),
      body: FutureBuilder(
        future: userLocation,
        builder: (context, AsyncSnapshot<Position> snapshot) {
          if(snapshot.hasData) {
            myLocations.add(Marker(
              markerId: MarkerId("0"),
              position: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
              infoWindow: InfoWindow(title: "My Location")
            ));
            return Column(
              children: [
                Center(
                  child: Text(
                    "User Location:\n${snapshot.data!.latitude}, ${snapshot.data!.longitude}",
                    style: TextStyle(
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                      zoom: 16
                    ),
                    markers: myLocations,
                    onMapCreated: (controller) => mapController = controller,
                  ),
                )
              ],
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
