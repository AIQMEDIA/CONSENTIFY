// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignatureId {
  String signatureId;
  SignatureId({
    this.signatureId,
  });

  SignatureId copyWith({
    String signatureId,
  }) {
    return SignatureId(
      signatureId: signatureId ?? this.signatureId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signatureId': signatureId,
    };
  }

  factory SignatureId.fromMap(Map<String, dynamic> map) {
    return SignatureId(
      signatureId: map['signatureId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignatureId.fromJson(String source) =>
      SignatureId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignatureId(signatureId: $signatureId)';

  @override
  bool operator ==(covariant SignatureId other) {
    if (identical(this, other)) return true;

    return other.signatureId == signatureId;
  }

  @override
  int get hashCode => signatureId.hashCode;
}
