import 'package:in_drive_clone/config/error/failure.dart';
import 'package:in_drive_clone/core/internet_connection.dart';
import 'package:in_drive_clone/features/domain/entity/location_entity.dart';
import 'package:in_drive_clone/features/domain/location_repo/location_repo.dart';

import '../data_source/remote_data_source_impl/location_remote_data_source_impl.dart';

class LocationRepoImpl implements LocationRepo {
  NetworkInfo? networkInfo;
  LocationRemoteDataSourceImpl? locationRemoteDataSourceImpl;

  LocationRepoImpl({required this.networkInfo,required this.locationRemoteDataSourceImpl});

  @override
  Future<LocationEntity> getCurrentLocation() async {
    try {
      if (await networkInfo!.isConnected()) {
        final d= await locationRemoteDataSourceImpl!.getCurrentLocation();
        return d;

      } else {
        throw Failure(errorMessage: "No Internet Connection");
      }
    } catch (e) {
      throw Failure(errorMessage: "some thing wrong happened");
    }
  }
  @override
  Future<List<LocationEntity>> searchLocation(String searchedLocation)async{
    if(await networkInfo!.isConnected()) {
      return locationRemoteDataSourceImpl!.searchLocation(searchedLocation);
    }
    throw Failure(errorMessage: "لا يوجد اتصال بالانترنت");
  }

}
