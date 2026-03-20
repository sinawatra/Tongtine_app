import 'package:homework_app/app/data/service/base_response.dart';
import 'package:homework_app/app/data/service/dio_client.dart';
import 'package:homework_app/app/modules/utils/constants/app_constants.dart';

class ProfileRepository {
  final DioClient dioClient;

  ProfileRepository({required this.dioClient});

  Future<BaseResponse> getUserById(String userId) async {
    try {
      final response = await dioClient.get(
        '${AppConstants.users}/$userId',
        query: {'userId': userId},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
