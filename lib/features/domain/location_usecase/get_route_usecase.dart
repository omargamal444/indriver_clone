import 'package:in_drive_clone/features/domain/entity/route_entity.dart';
import 'package:in_drive_clone/features/domain/location_repo/route_repo.dart';
import 'package:latlong2/latlong.dart';

class GetRouteUsecase {
  final RouteRepository repository;

  GetRouteUsecase({required this.repository});

  Future<RouteEntity> call(LatLng start, LatLng end) {
    return repository.getRoute(start, end);
  }
}
