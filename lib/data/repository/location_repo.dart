import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences preference;
  LocationRepo({required this.apiClient,required this.preference});

  Future<Response> getAddressFromGeocode(LatLng latLng) async{
    return await apiClient.getData('${Constants.GEOCODE_URL}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

}