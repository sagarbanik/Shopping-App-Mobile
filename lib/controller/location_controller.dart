import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/location_repo.dart';
import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{

  final LocationRepo repo;
  LocationController({required this.repo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList = [];
  List<String> _addressTypeList = ["home","office","others"];
  int _addressTypeIndex = 0;
  late Map<String,dynamic> _getAddress;
  Map<String,dynamic> get getAddress => _getAddress;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;


  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;

  void setMapController(GoogleMapController controller){
    _mapController = controller;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async{
    if(_updateAddressData){
      _loading = true;
      update();
      try{
        if(fromAddress){
          _position = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        }else{
          _pickPosition = Position(
              longitude: cameraPosition.target.longitude,
              latitude: cameraPosition.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1
          );
        }

        if(_changeAddress){
          String _address = await getAddressFromGeocode(
            LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude)
          );
        }

      }catch(e){
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async{
    String _address = "Unknown Location Found!";
    Response response = await repo.getAddressFromGeocode(latLng);
    print("Code : "+response.body!.toString());
    if(response.body["status"] == "OK"){
      _address = response.body["results"][0]["formatted_address"].toString();
      print("Printing address : "+_address);
    }else{
      print("Error getting the google api.");
    }
    return _address;
  }

}