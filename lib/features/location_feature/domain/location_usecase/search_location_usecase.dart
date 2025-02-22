import 'package:in_drive_clone/features/location_feature/domain/entity/location_entity.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_repo/location_repo.dart';
class SearchLocationUseCase{
  LocationRepo? locationRepo;


  SearchLocationUseCase({required this.locationRepo});

  Future<List<LocationEntity>>call(String searchedLocation)async{
    return await locationRepo!.searchLocation(searchedLocation);
  }
}