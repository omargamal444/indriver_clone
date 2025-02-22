import 'package:in_drive_clone/features/domain/entity/location_entity.dart';

abstract class LocationRepo {
  Future<LocationEntity> getCurrentLocation();
  Future<List<LocationEntity>>searchLocation(String searchedLocation);
}
