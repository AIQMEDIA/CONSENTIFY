// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegistrationData {
  String mnemonic;
  String xPub;
  String publicKey;
  String privateKey;
  String ipFsHash;
  String id;
  RegistrationData({
    this.mnemonic,
    this.xPub,
    this.publicKey,
    this.privateKey,
    this.ipFsHash,
    this.id,
  });

  RegistrationData copyWith({
    String mnemonic,
    String xPub,
    String publicKey,
    String privateKey,
    String ipFsHash,
    String id,
  }) {
    return RegistrationData(
      mnemonic: mnemonic ?? this.mnemonic,
      xPub: xPub ?? this.xPub,
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
      ipFsHash: ipFsHash ?? this.ipFsHash,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mnemonic': mnemonic,
      'xPub': xPub,
      'publicKey': publicKey,
      'privateKey': privateKey,
      'ipFsHash': ipFsHash,
      'id': id,
    };
  }

  factory RegistrationData.fromMap(Map<String, dynamic> map) {
    return RegistrationData(
      mnemonic: map['mnemonic'] as String,
      xPub: map['xPub'] as String,
      publicKey: map['publicKey'] as String,
      privateKey: map['privateKey'] as String,
      ipFsHash: map['ipFsHash'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationData.fromJson(String source) =>
      RegistrationData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegistrationData(mnemonic: $mnemonic, xPub: $xPub, publicKey: $publicKey, privateKey: $privateKey, ipFsHash: $ipFsHash, id: $id)';
  }

  @override
  bool operator ==(covariant RegistrationData other) {
    if (identical(this, other)) return true;

    return other.mnemonic == mnemonic &&
        other.xPub == xPub &&
        other.publicKey == publicKey &&
        other.privateKey == privateKey &&
        other.ipFsHash == ipFsHash &&
        other.id == id;
  }

  @override
  int get hashCode {
    return mnemonic.hashCode ^
        xPub.hashCode ^
        publicKey.hashCode ^
        privateKey.hashCode ^
        ipFsHash.hashCode ^
        id.hashCode;
  }
}
