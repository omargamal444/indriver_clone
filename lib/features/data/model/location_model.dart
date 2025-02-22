import '../../domain/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required super.latitude, required super.longitude,super.displayName});
   factory LocationModel.fromJson(Map<String,dynamic>data){
     return LocationModel(
         latitude: data["lat"],
         longitude: data["lon"],
         displayName: data["display_name"]);
   }
}
