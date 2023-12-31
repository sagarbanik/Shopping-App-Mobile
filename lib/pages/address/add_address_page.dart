import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/controller/location_controller.dart';
import 'package:shopping_app/controller/user_controller.dart';
import 'package:shopping_app/utils/colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLoggedIn;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      23.8103,90.4125
  ),zoom: 17);

  late LatLng _initialPosition = LatLng(
        23.8103,90.4125
  );

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isUserLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userModel == null){
      Get.find<UserController>().getUserInfo();
    }

    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["langitude"])
      ));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["langitude"])
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Address Page'
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 2,
                      color: Theme.of(context).primaryColor
                  )
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 17,
                    ),
                    zoomControlsEnabled: true,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: false,
                    onCameraIdle: (){
                      locationController.updatePosition(_cameraPosition,true);
                    },
                    onCameraMove: ((position)=>_cameraPosition = position),
                    onMapCreated: (GoogleMapController controller){
                      locationController.setMapController(controller);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}
