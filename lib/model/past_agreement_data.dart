// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PastAgreementData {
  String publicKey;
  String value;
  final isLoading = false.obs;
  PastAgreementData({
    @required this.publicKey,
    @required this.value,
  });

  PastAgreementData copyWith({
    String publicKey,
    String value,
  }) {
    return PastAgreementData(
      publicKey: publicKey ?? this.publicKey,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicKey': publicKey,
      'value': value,
    };
  }

  factory PastAgreementData.fromMap(Map<String, dynamic> map) {
    return PastAgreementData(
      publicKey: map['publicKey'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PastAgreementData.fromJson(String source) =>
      PastAgreementData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PassAgreementData(publicKey: $publicKey, value: $value)';

  @override
  bool operator ==(covariant PastAgreementData other) {
    if (identical(this, other)) return true;

    return other.publicKey == publicKey && other.value == value;
  }

  @override
  int get hashCode => publicKey.hashCode ^ value.hashCode;
}
