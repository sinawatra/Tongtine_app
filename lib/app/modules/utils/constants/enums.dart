// ignore_for_file: constant_identifier_names
enum TextSizes {small, medium, large}

enum OrderStatus {accept, processing, delivered}

enum KycType {
  idFront("ID_Front"),
  idBack("ID_Back"),
  selfie("SELFIE");

  final String value;
  const KycType(this.value);
}

enum OrderType {
    assigned("ASSIGNED"),
    inProgress("IN_PROGRESS"),
    upcoming("UPCOMING"),
    completed("COMPLETED");

  final String value;
  const OrderType(this.value);
}

enum ChatMessageType {
  text('TEXT'),
  contact('CONTACT'),
  location('LOCATION'),
  media('MEDIA'),
  call('CALL'),
  file('FILE'),
  link('LINK'),
  typing('typing'),
  groupLink('GROUP_LINK'),
  system('SYSTEM');

  final String value;
  const ChatMessageType(this.value);

  /// Convert enum → string
  String toJson() => value;

  /// Convert string → enum
  static ChatMessageType fromJson(String? value) {
    return ChatMessageType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ChatMessageType.text, // fallback if unknown
    );
  }
}



enum EarningType {
  all("all"),
  request("request"),
  earning("earning"),
  deduction("deductions"),
  withdrawal("withdrawal");


  final String value;
  const EarningType(this.value);
}
// enum orderDetailsType {
//   PENDING("PENDING"),
//   ACCEPTED("ACCEPTED"),
//   REJECTED("REJECTED"),
//   COMPLETED("COMPLETED");

//   final String value;
//   const orderDetailsType(this.value);
// }