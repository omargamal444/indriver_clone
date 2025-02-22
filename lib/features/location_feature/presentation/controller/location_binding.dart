import 'package:get/get.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_current_location_usecase.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/get_route_usecase.dart';
import 'package:in_drive_clone/features/location_feature/domain/location_usecase/search_location_usecase.dart';
import 'package:in_drive_clone/features/location_feature/presentation/controller/map_page_controller.dart';


class MapPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MapPageController(
        getCurrentLocationUseCase: Get.find<GetCurrentLocationUseCase>(),
        searchLocationUseCase: Get.find<SearchLocationUseCase>(),
    getRouteUsecase: Get.find<GetRouteUsecase>(),)
    );
  }

}