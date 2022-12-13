// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TxFinalConfig {
  String from;
  String to;
  String data;
  String gasPrice;
  String id;
  TxFinalConfig({
    this.from,
    this.to,
    this.data,
    this.gasPrice,
    this.id,
  });

  TxFinalConfig copyWith({
    String from,
    String to,
    String data,
    String gasPrice,
    String id,
  }) {
    return TxFinalConfig(
      from: from ?? this.from,
      to: to ?? this.to,
      data: data ?? this.data,
      gasPrice: gasPrice ?? this.gasPrice,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'data': data,
      'gasPrice': gasPrice,
      'id': id,
    };
  }

  factory TxFinalConfig.fromMap(Map<String, dynamic> map) {
    return TxFinalConfig(
      from: map['from'] as String,
      to: map['to'] as String,
      data: map['data'] as String,
      gasPrice: map['gasPrice'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TxFinalConfig.fromJson(String source) =>
      TxFinalConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TxFinalConfig(from: $from, to: $to, data: $data, gasPrice: $gasPrice, id: $id)';
  }

  @override
  bool operator ==(covariant TxFinalConfig other) {
    if (identical(this, other)) return true;

    return other.from == from &&
        other.to == to &&
        other.data == data &&
        other.gasPrice == gasPrice &&
        other.id == id;
  }

  @override
  int get hashCode {
    return from.hashCode ^
        to.hashCode ^
        data.hashCode ^
        gasPrice.hashCode ^
        id.hashCode;
  }
}
