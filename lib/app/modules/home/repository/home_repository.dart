
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

  Future<BaseResponse> createGroup(String groupName, int contributionAmount, int totalMembers, String imageUrl) async {
    try {
      final response = await dioClient.post(AppConstants.tontineGroup, data: {
        "groupName": groupName,
        "contributionAmount": contributionAmount,
        "totalMembers": totalMembers,
        "imageUrl": imageUrl,
      });
      return response;
    } catch (e) {
      throw e.toString();
     }
    }

    Future<BaseResponse> getGroupInfoById(String groupId) async {
      try {
        final response = await dioClient.get("${AppConstants.tontineGroup}/$groupId");
        return response;
      } catch (e) {
        throw e.toString();
       }
      }

    Future<BaseResponse> getGroupMemberByGroupID(String groupId) async {
      try {
        final response = await dioClient.get("${AppConstants.tontineGroup}/$groupId/members");
        return response;
      } catch (e) {
        throw e.toString();
       }
      }

      Future<BaseResponse> getOverView() async {
        try {
          final response = await dioClient.get(AppConstants.overview);
          return response;
        } catch (e) {
          throw e.toString();
         }
        }

        Future<BaseResponse> joinGroup(String groupId) async {
          try {
            final response = await dioClient.post("${AppConstants.tontineGroup}/$groupId/join");
            return response;
          } catch (e) {
            throw e.toString();
           }
          }


          Future<void> triggerPayoutForTheGroup(String groupId, String amount) async {
            try {
              await dioClient.post("${AppConstants.tontineGroup}/$groupId/contribute", 
              data: {
                "amount": amount,
              },
              );
            } catch (e) {
              throw e.toString();
             }
            }
}