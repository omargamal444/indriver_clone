import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:in_drive_clone/features/location_feature/presentation/controller/map_page_controller.dart';
import 'package:in_drive_clone/features/location_feature/presentation/widget/search_result_widget.dart';
import 'package:in_drive_clone/features/location_feature/presentation/widget/search_widget.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends GetView<MapPageController> {
  const HomePage({super.key});

  static String route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map Widget
          Obx(() {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Text(controller.errorMessage),
              );
            }
            return FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: controller.currentLocation,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: controller.currentLocation,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 40),
                    ),
                    if (controller.dropOffLocation.value != null)
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: controller.dropOffLocation.value!,
                        child: const Icon(Icons.location_on,
                            color: Colors.blue, size: 40),
                      ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: controller.polylineCoordinates,
                      strokeWidth: 4.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            );
          },),
          const Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$125.00", // Sample balance
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
          ),

          // Search Bar
          Positioned(
            top: 88,
            left: 16,
            right: 16,
            child: Column(
              children: [
                const SearchWidget(hintText: "Enter pickup location"),
                const SizedBox(height: 10),
                SearchWidget(
                  hintText: "Enter drop_off location",
                  onChanged: (value) {
                    controller.searchLocation(value);
                  },
                ),
                const SizedBox(height: 4),
                Obx(() {
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage));
                  }
                  return IgnorePointer(
                    ignoring: controller.searchedLocations.isEmpty,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 500),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.searchedLocations.length,
                        itemBuilder: (context, index) {
                          final searchedLocation =
                              controller.searchedLocations[index];
                          return SearchResultWidget(
                            searchedLocationName: searchedLocation.displayName!,
                            onTap: () {
                              controller.setDropOffLocation(LatLng(
                                  searchedLocation.latitude!,
                                  searchedLocation.longitude!));
                              controller.fetchRoute(controller.currentLocation,
                                  LatLng(searchedLocation.latitude!,searchedLocation.longitude!));
                              controller.searchedLocationController.clear();
                              controller.searchedLocations.clear();
                            },
                          );
                        },
                      ),
                    ),
                  );
                })
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 4,
            right: 4,
            child: ElevatedButton(
              onPressed: () {
                // Action for ride request
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Request Ride",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
