import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:in_drive_clone/core/internet_connection.dart';
import 'package:in_drive_clone/features/location_feature/data/data_source/remote_data_source_impl/location_remote_data_source_impl.dart';
import 'package:in_drive_clone/features/location_feature/data/location_repo_impl/get_route_repo_impl.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_current_location_usecase.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_route_usecase.dart';
import '../config/api/dio_consumer.dart';
import '../features/location_feature/data/location_repo_impl/location_repo_impl.dart';
import '../features/location_feature/domain/location_usecase/search_location_usecase.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(),fenix: true);
    Get.lazyPut(() => DioConsumer(Get.find<Dio>()), fenix: true);
    Get.lazyPut(() => LocationRemoteDataSourceImpl(api: Get.find<DioConsumer>()), fenix: true);
    Get.lazyPut(() => NetworkInfo(), fenix: true);
    Get.lazyPut(
        () => LocationRepoImpl(
            networkInfo: Get.find<NetworkInfo>(),
            locationRemoteDataSourceImpl:
                Get.find<LocationRemoteDataSourceImpl>()),
        fenix: true);
    Get.lazyPut(
            () => GetRouteRepoImpl(
            networkInfo: Get.find<NetworkInfo>(),
            locationRemoteDataSourceImpl:
            Get.find<LocationRemoteDataSourceImpl>()),
        fenix: true);
    Get.lazyPut(
        () => GetCurrentLocationUseCase(
            locationRepo: Get.find<LocationRepoImpl>()),
        fenix: true);
    Get.lazyPut(
        () => SearchLocationUseCase(locationRepo: Get.find<LocationRepoImpl>()),
        fenix: true);
    Get.lazyPut(
            () => SearchLocationUseCase(locationRepo: Get.find<LocationRepoImpl>()),
        fenix: true);
    Get.lazyPut(
            () => GetRouteUsecase(repository: Get.find<GetRouteRepoImpl>()),
        fenix: true);
  }
}
