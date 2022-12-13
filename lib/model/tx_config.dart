import 'dart:convert';

class TxConfig {
  int from;
  String to;
  String data;
  String gasPrice;

  TxConfig({this.from, this.to, this.data, this.gasPrice});

  @override
  String toString() {
    return 'TxConfig(from: $from, to: $to, data: $data, gasPrice: $gasPrice)';
  }

  factory TxConfig.fromMap(Map<String, dynamic> data) => TxConfig(
        from: data['from'] as int,
        to: data['to'] as String,
        data: data['data'] as String,
        gasPrice: data['gasPrice'] as String,
      );

  Map<String, dynamic> toMap() => {
        'from': from,
        'to': to,
        'data': data,
        'gasPrice': gasPrice,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TxConfig].
  factory TxConfig.fromJson(String data) {
    return TxConfig.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TxConfig] to a JSON string.
  String toJson() => json.encode(toMap());
}
