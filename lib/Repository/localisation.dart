import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mydirectcash/Models/geofancing.dart';

class Localisation extends ChangeNotifier {
  LatLng? _location;
  LatLng? get location => _location;
  Location locat = Location();
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  bool? isStart = false, _serviceEnabled;

  dynamic _address = {'country': '', 'locality': '', 'name': ''};
  dynamic get addres => _address;

  initLocation() async {
    _serviceEnabled = await locat.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await locat.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await locat.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locat.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await locat.getLocation();
    _location = new LatLng(_locationData!.latitude!, _locationData!.longitude!);
    decodeAddress(location!).then((value) => _address = value);
    print(_address);
    notifyListeners();
  }

  currentLocation() {
    locat.onLocationChanged.listen((position) {
      _location = LatLng(position.longitude!, position.latitude!);
      notifyListeners();
      print(position.latitude.toString() +
          ',' +
          position.longitude.toString() +
          ',' +
          position.altitude.toString());
    });
  }
}
