library eth_abi_codec.call;

import 'dart:typed_data';

import 'abi.dart';

class ContractCall {
  String functionName;
  Map<String, dynamic> callParams;

  dynamic getCallParam(String paramName) => callParams[paramName];

  ContractCall(this.functionName) :callParams = {};

  void setCallParam(String key, dynamic value) {
    callParams[key] = value;
  }

  /// fromJson takes a Map<String, dynamic> as input
  ///
  ///```json
  ///{
  /// "address": "contract address",
  /// "function": "function name",
  /// "params": [
  ///   {
  ///     "name": "param name",
  ///     "value": "param value"
  ///   }
  /// ]
  ///}
  ///```
  ContractCall.fromJson(Map<String, dynamic> json):
    functionName = json['function'],
    callParams = json['params'];

  Map<String, dynamic> toJson() =>
    {
      'function': functionName,
      'params': callParams
    };

  /// fromBinary takes "input data" field of ethereum contract call as input
  static ContractCall fromBinary(Uint8List data, ContractABI abi) {
    return abi.decomposeCall(data);
  }

  Uint8List toBinary(ContractABI abi) => abi.composeCall(this);
}