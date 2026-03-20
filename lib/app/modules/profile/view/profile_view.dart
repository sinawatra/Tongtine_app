import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/profile/models/user_model.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';

import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundAlt,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: localizedTextStyle(
                      fontSize: 14, color: AppColor.contentDim),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchProfile,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final user = controller.user.value;
        if (user == null) return const SizedBox.shrink();

        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(user),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildBalanceCard(user.balance),
                  const SizedBox(height: 16),
                  _buildInfoSection(user),
                  const SizedBox(height: 16),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }

  SliverAppBar _buildSliverAppBar(UserModel user) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: const Color(0xFF102C90),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(gradient: AppColor.appBarGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white24,
                child: ClipOval(
                  child: user.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: user.imageUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                          errorWidget: (_, __, ___) => const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white),
                        )
                      : const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.fullName,
                style: localizedTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white38),
                ),
                child: Text(
                  user.role,
                  style: localizedTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double balance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: AppColor.appBarGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4CFA).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: localizedTextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${balance.toStringAsFixed(2)}',
                  style: localizedTextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance_wallet,
                color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(UserModel user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Personal Information',
              style: localizedTextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          const Divider(height: 1, color: AppColor.outlineSoftest),
          _buildInfoRow(Icons.phone_outlined, 'Phone', user.phone),
          const Divider(height: 1, indent: 56, color: AppColor.outlineSoftest),
          _buildInfoRow(
              Icons.email_outlined, 'Email', user.email ?? 'Not provided'),
          const Divider(height: 1, indent: 56, color: AppColor.outlineSoftest),
          _buildInfoRow(
            user.kycVerified
                ? Icons.verified_user_outlined
                : Icons.shield_outlined,
            'KYC Status',
            user.kycVerified ? 'Verified' : 'Pending',
            valueColor: user.kycVerified ? Colors.green : Colors.orange,
          ),
          const Divider(height: 1, indent: 56, color: AppColor.outlineSoftest),
          _buildInfoRow(Icons.badge_outlined, 'Role', user.role),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.backgroundAlt,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Icon(icon, size: 20, color: AppColor.contentDim),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: localizedTextStyle(
                  fontSize: 14, color: AppColor.contentDim),
            ),
          ),
          Text(
            value,
            style: localizedTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColor.contentDefault,
            ),
          ),
        ],
      ),
    );
  }
}
