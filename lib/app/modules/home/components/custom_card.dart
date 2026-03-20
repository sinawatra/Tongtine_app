
import 'package:flutter/material.dart';
import 'package:homework_app/app/common/style/style.dart';
import 'package:homework_app/app/modules/utils/constants/colors.dart';

class TontineCard extends StatelessWidget {
  const TontineCard({
    super.key,
    required this.groupName,
    required this.contributionAmount,
    required this.totalMembers,
    required this.startDate,
    required this.status,
    this.groupId,
    this.imageUrl,
    this.onTap,
    this.onMore,
  });

  final String groupName;
  final double contributionAmount;
  final int totalMembers;
  final String? startDate;
  final String status;
  final String? imageUrl;
  final dynamic groupId; // Added groupId
  final VoidCallback? onTap;
  final VoidCallback? onMore;

  static const _border = Color(0xFFE8E8E8);
  static const _textSubtle = Color(0xFF3D3D3D);
  static const _textDefault = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: _border,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: logo + group name + status
              Row(
                children: [
                  _AvatarLogo(url: imageUrl),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupName,
                          style: localizedTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _textDefault,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Members: $totalMembers',
                          style: localizedTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _textSubtle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _StatusBadge(status: status),
                  const SizedBox(width: 8),

                  if (onMore != null)
                    InkWell(
                      onTap: onMore,
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.chevron_right,
                          size: 22,
                          color: _textSubtle,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(color: _border),
              const SizedBox(height: 16),

              // Bottom row: Contribution + Start date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(
                    title: 'ចំនួនត្រូវចូលរួម',
                    value: '\$${contributionAmount.toStringAsFixed(2)}',
                    valueWeight: FontWeight.w600,
                  ),
                  _StatColumn(
                    title: 'ថ្ងៃចាប់ផ្តើម',
                    value: startDate ?? 'TBD',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label = status;

    switch (status) {
      case "IN_PROGRESS":
        bgColor = AppColor.infoLight;
        textColor = AppColor.infoNormal;
        label = "In Progress";
        break;
      case "COMPLETED":
        bgColor = AppColor.successLight;
        textColor = AppColor.successNormal;
        label = "Completed";
        break;
      case "PENDING":
        bgColor = AppColor.warningLight;
        textColor = AppColor.warningNormal;
        label = "Pending";
        break;
      default:
        bgColor = AppColor.outlineSoftest;
        textColor = AppColor.contentDim;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: localizedTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

class _AvatarLogo extends StatelessWidget {
  const _AvatarLogo({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey[200],
      ),
      child: url != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported_outlined, size: 28),
              ),
            )
          : const Icon(Icons.group, size: 28, color: Colors.grey),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.title,
    required this.value,
    this.valueWeight = FontWeight.w500,
  });

  final String title;
  final String value;
  final FontWeight valueWeight;

  static const _textSubtle = Color(0xFF3D3D3D);
  static const _textDefault = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: localizedTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _textSubtle,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: localizedTextStyle(
            fontSize: 16,
            fontWeight: valueWeight,
            color: _textDefault,
          ),
        ),
      ],
    );
  }
}