// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QrCodeData {
  String customerId;
  String externalId;
  QrCodeData({
    this.customerId,
    this.externalId,
  });

  QrCodeData copyWith({
    String customerId,
    String externalId,
  }) {
    return QrCodeData(
      customerId: customerId ?? this.customerId,
      externalId: externalId ?? this.externalId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'externalId': externalId,
    };
  }

  factory QrCodeData.fromMap(Map<String, dynamic> map) {
    return QrCodeData(
      customerId: map['customerId'] as String,
      externalId: map['externalId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrCodeData.fromJson(String source) =>
      QrCodeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QrCodeData(customerId: $customerId, externalId: $externalId)';

  @override
  bool operator ==(covariant QrCodeData other) {
    if (identical(this, other)) return true;

    return other.customerId == customerId && other.externalId == externalId;
  }

  @override
  int get hashCode => customerId.hashCode ^ externalId.hashCode;
}
