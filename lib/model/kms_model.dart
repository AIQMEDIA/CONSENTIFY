import 'dart:convert';

class KmsModel {
  dynamic withdrawalId;
  String chain;
  String serializedTransaction;
  List<dynamic> hashes;
  dynamic index;
  dynamic withdrawalResponses;
  dynamic signatures;
  String id;

  KmsModel({
    this.withdrawalId,
    this.chain,
    this.serializedTransaction,
    this.hashes,
    this.index,
    this.withdrawalResponses,
    this.signatures,
    this.id,
  });

  @override
  String toString() {
    return 'KmsModel(withdrawalId: $withdrawalId, chain: $chain, serializedTransaction: $serializedTransaction, hashes: $hashes, index: $index, withdrawalResponses: $withdrawalResponses, signatures: $signatures, id: $id)';
  }

  factory KmsModel.fromMap(Map<String, dynamic> data) => KmsModel(
        withdrawalId: data['withdrawalId'] as dynamic,
        chain: data['chain'] as String,
        serializedTransaction: data['serializedTransaction'] as String,
        hashes: data['hashes'] as List<dynamic>,
        index: data['index'] as dynamic,
        withdrawalResponses: data['withdrawalResponses'] as dynamic,
        signatures: data['signatures'] as dynamic,
        id: data['id'] as String,
      );

  Map<String, dynamic> toMap() => {
        'withdrawalId': withdrawalId,
        'chain': chain,
        'serializedTransaction': serializedTransaction,
        'hashes': hashes,
        'index': index,
        'withdrawalResponses': withdrawalResponses,
        'signatures': signatures,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [KmsModel].
  factory KmsModel.fromJson(String data) {
    return KmsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [KmsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
