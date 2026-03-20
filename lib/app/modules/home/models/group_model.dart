class GroupModel {
  final String id;
  final String groupName;
  final double contributionAmount;
  final int totalMembers;
  final DateTime? startDate;
  final String status;
  final String? imageUrl;

  const GroupModel({
    required this.id,
    required this.groupName,
    required this.contributionAmount,
    required this.totalMembers,
    this.startDate,
    required this.status,
    this.imageUrl,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      groupName: json['groupName'] as String,
      contributionAmount: (json['contributionAmount'] as num).toDouble(),
      totalMembers: json['totalMembers'] as int,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      status: json['status'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
