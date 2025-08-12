import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AppProvider with ChangeNotifier {
  var location = Location();
  String locationMessage = '';
  late GoogleMapController mapController;
  Set<Marker> markers = {
    // Marker(markerId: MarkerId('current_location'), position: LatLng(0, 0)),
  };
  LatLng? eventLocation;

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 20,
  );

  Future<void> getLocation() async {
    notifyListeners();
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) {
      notifyListeners();
      return;
    }
    bool locationServiceEnabled = await _locationServiceEnabled();
    if (!locationServiceEnabled) {
      notifyListeners();
      return;
    }

    notifyListeners();
    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData);
    notifyListeners();
  }

  Future<bool> _getLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      notifyListeners();
    }
    return locationServiceEnabled;
  }

  void changeLocationOnMap(LocationData locationData) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
      ),
    );
    notifyListeners();
  }

  /*  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    location.onLocationChanged.listen((LocationData newLocation) {
      changeLocationOnMap(newLocation);
    });
  }*/

  void setEventLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;

    notifyListeners();
  }
}
