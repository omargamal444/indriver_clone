abstract class ApiConsumer {
  Future get({required String endPoint,Object?data,Map<String,dynamic> queryParameter});
  Future post({required String endPoint,Map<String,dynamic>?data,Map <String,dynamic>queryParameter});
  Future patch({required String endPoint,Object?data,Map<String,dynamic> queryParameter});
  Future delete({required String endPoint,Object?data,Map<String,dynamic> queryParameter});
}
