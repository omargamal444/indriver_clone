import '../entity/location_entity.dart';
import '../location_repo/location_repo.dart';

class GetCurrentLocationUseCase{
  LocationRepo? locationRepo;


  GetCurrentLocationUseCase({required this.locationRepo});

  Future<LocationEntity>call()async{
  return await locationRepo!.getCurrentLocation();
  }
}