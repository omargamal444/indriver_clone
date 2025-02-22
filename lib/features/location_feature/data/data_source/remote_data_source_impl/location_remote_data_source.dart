
import 'package:in_drive_clone/features/location_feature/domain/entity/location_entity.dart';
import 'package:in_drive_clone/features/location_feature/domain/entity/route_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class RemoteDataSource{
  Future<LocationEntity>getCurrentLocation();
  Future<List<LocationEntity>> searchLocation(String searchedLocation);
  Future<RouteEntity> getRoute(LatLng start, LatLng end);
}