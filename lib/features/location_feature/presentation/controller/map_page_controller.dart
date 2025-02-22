import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:in_drive_clone/config/error/failure.dart';
import 'package:in_drive_clone/core/permission_handler.dart';
import 'package:in_drive_clone/features/location_feature/domain/entity/route_entity.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_current_location_usecase.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_route_usecase.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/search_location_usecase.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entity/location_entity.dart';

class MapPageController extends GetxController {
  final GetRouteUsecase getRouteUsecase;
  var polylineCoordinates = <LatLng>[].obs;
  GetCurrentLocationUseCase? getCurrentLocationUseCase;
  final RxString _errorMessage = "".obs;
  final RxBool _isLoading = false.obs;
  final Rx<LatLng> _currentLocation = const LatLng(37.7749, -122.4194).obs;
  final dropOffLocation = Rxn<LatLng>();
  final polylinePoints = <LatLng>[].obs;
  MapController _mapController = MapController();
  SearchLocationUseCase? searchLocationUseCase;
  TextEditingController searchedLocationController = TextEditingController();
  RxList<LocationEntity> searchedLocations = <LocationEntity>[].obs;

  MapPageController(
      {required this.getCurrentLocationUseCase,
      required this.searchLocationUseCase,
      required this.getRouteUsecase});

  bool get isLoading => _isLoading.value;

  LatLng get currentLocation => _currentLocation.value;

  MapController get mapController => _mapController;

  String get errorMessage => _errorMessage.value;

  void set(LatLng currentLocation) {
    _currentLocation.value = currentLocation;
  }

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  void setIsLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  Future<void> getCurrentLocation() async {
    try {
      _isLoading.value = true;
      bool isPermissionAccepted =
          await PermissionHandler.checkLocationPermission();
      if (isPermissionAccepted) {
        final locationEntity = await getCurrentLocationUseCase!.call();
        _currentLocation.value =
            LatLng(locationEntity.latitude!, locationEntity.longitude!);
        _errorMessage.value = "";
      }
    } on Failure catch (e) {
      _errorMessage.value = e.errorMessage!;
    } finally {
      _isLoading.value = false;
    }
  }

  Future searchLocation(String searchedLocation) async {
    try {
      _isLoading.value = true;
     final search= await searchLocationUseCase!.call(searchedLocation);
     searchedLocations.value=search;
      _errorMessage.value = "";
    } on Failure catch (e) {
      _errorMessage.value = e.errorMessage!;
    } finally {
      _isLoading.value = false;
    }
  }
  void setDropOffLocation(LatLng dropOff) {
    dropOffLocation.value = dropOff;
    polylinePoints.value = [_currentLocation.value, dropOff];
  }
  Future<void> fetchRoute(LatLng start, LatLng end) async {
    try {
      _isLoading.value=true;
       final RouteEntity route = await getRouteUsecase(start, end);
      polylineCoordinates.assignAll(route.coordinates);
      _errorMessage.value="";
    } on Failure catch (e) {
      _errorMessage.value=e.errorMessage!;
    }
    finally {
      _isLoading.value=false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  @override
  void onClose() {
    super.onClose();
    searchedLocationController.dispose();
  }
}

