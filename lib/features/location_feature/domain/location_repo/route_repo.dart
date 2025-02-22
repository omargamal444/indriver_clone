import 'package:in_drive_clone/features/location_feature/domain/entity/route_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class RouteRepository {
  Future<RouteEntity> getRoute(LatLng start, LatLng end);
}
