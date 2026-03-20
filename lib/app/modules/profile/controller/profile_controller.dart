import 'dart:developer';

import 'package:get/get.dart';
import 'package:homework_app/app/data/service/secure_storage_service.dart';
import 'package:homework_app/app/modules/profile/models/user_model.dart';
import 'package:homework_app/app/modules/profile/repository/profile_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository;
  final SecureStorageService secureStorageService;

  ProfileController({
    required this.profileRepository,
    required this.secureStorageService,
  });

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await secureStorageService.getToken();
      if (token == null) {
        errorMessage.value = 'Not authenticated';
        return;
      }

      final decoded = JwtDecoder.decode(token);
      final userId = decoded['id'] ?? decoded['sub'] ?? decoded['userId'];
      if (userId == null) {
        errorMessage.value = 'Could not retrieve user ID';
        return;
      }

      final response = await profileRepository.getUserById(userId.toString());
      if (response.success == true && response.body != null) {
        user.value = UserModel.fromJson(response.body as Map<String, dynamic>);
      } else {
        errorMessage.value = response.message ?? 'Failed to load profile';
      }
    } catch (e) {
      log('Error fetching profile: $e');
      errorMessage.value = 'Failed to load profile';
    } finally {
      isLoading.value = false;
    }
  }
}
