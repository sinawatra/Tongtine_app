
import 'package:homework_app/app/data/service/base_response.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/modules/utils/constants/app_constants.dart';

class HomeRepository {
    final DioClient dioClient;

  HomeRepository({required this.dioClient});


  Future<BaseResponse> getTontineGroup() async {
    try {
      final response = await dioClient.get(AppConstants.tontineGroup);
      return response;
    } catch (e) {
      throw e.toString();
     }
      }


}