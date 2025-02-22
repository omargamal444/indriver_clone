import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:in_drive_clone/config/api/api_consumer.dart';
import 'package:in_drive_clone/config/api/api_key.dart';
import 'package:in_drive_clone/features/location_feature/data/data_source/remote_data_source_impl/location_remote_data_source.dart';
import 'package:in_drive_clone/features/location_feature/data/model/location_model.dart';
import 'package:in_drive_clone/features/location_feature/data/model/route_model.dart';
import 'package:in_drive_clone/features/location_feature/domain/entity/location_entity.dart';
import 'package:in_drive_clone/features/location_feature/domain/entity/route_entity.dart';
import 'package:latlong2/latlong.dart';

class LocationRemoteDataSourceImpl implements RemoteDataSource {
  ApiConsumer? api;

  LocationRemoteDataSourceImpl({required this.api});

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final locationEntity = LocationModel(
        latitude: position.latitude, longitude: position.longitude);
    return locationEntity;
  }

  @override
  Future<List<LocationEntity>> searchLocation(String searchedLocation) async {
    if (searchedLocation.isEmpty) return [];

    Response response = await api!.get(
      endPoint:
          "https://nominatim.openstreetmap.org/search?q=cairo&format=json&countrycodes=EG",
      queryParameter: {'q': searchedLocation, 'format': 'json', 'limit': 100},
    );
    List listData = response.data;
    return listData.map((e) {
      Map<String, dynamic> data = {
        "lat": double.parse(e[ApiKey.lat]),
        "lon": double.parse(e[ApiKey.lon]),
        "display_name": e[ApiKey.displayName]
      };
      return LocationModel.fromJson(data);
    }).toList();
  }

  @override
  Future<RouteEntity> getRoute(LatLng start, LatLng end) async {
    String url =
        "https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson";

    final response = await api!.get(endPoint: url);
      final routes = response.data[ApiKey.routes] as List;
      if (routes.isNotEmpty) {
        var coordinates = routes[0][ApiKey.geometry][ApiKey.coordinates] as List;
        List<LatLng> points =
            coordinates.map((co) => LatLng(co[1], co[0])).toList();
        return RouteModel(coordinates: points);
      }
    throw Exception("Failed to fetch route");
  }
}
