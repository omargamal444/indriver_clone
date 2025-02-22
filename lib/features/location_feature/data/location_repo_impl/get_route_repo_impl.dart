import 'package:in_drive_clone/config/error/failure.dart';
import 'package:in_drive_clone/core/internet_connection.dart';
import 'package:in_drive_clone/features/location_feature/domain/entity/route_entity.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_repo/route_repo.dart';
import 'package:latlong2/latlong.dart';
import '../data_source/remote_data_source_impl/location_remote_data_source_impl.dart';

class GetRouteRepoImpl implements RouteRepository {
  NetworkInfo? networkInfo;
  LocationRemoteDataSourceImpl? locationRemoteDataSourceImpl;

  GetRouteRepoImpl(
      {required this.networkInfo, required this.locationRemoteDataSourceImpl});

  @override
  Future<RouteEntity> getRoute(LatLng start, LatLng end) async {
    try {
      if (await networkInfo!.isConnected()) {
        return await locationRemoteDataSourceImpl!.getRoute(start, end);
      } else {
        throw Failure(errorMessage: "No Internet Connection");
      }
    } catch (e) {
      throw Failure(errorMessage: "some thing wrong happened");
    }
  }
}
