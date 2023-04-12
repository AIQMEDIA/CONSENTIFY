library eth_abi_codec.abi;

import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sha3.dart';
import 'package:typed_data/typed_buffers.dart';

import 'codec.dart';
import 'call.dart';

class ContractInput {
  final String name;
  final String _type;
  final List<ContractInput> components;

  String get type {
    if(!_type.startsWith('tuple'))
      return _type;
    return _type.replaceFirst('tuple', '(' + components.map((i) => i.type).join(',') + ')');
  }

  String get originType => _type;

  ContractInput.fromJson(Map<String, dynamic> json)
    : 
    name = json['name'], 
    _type = json['type'],
    components = List<ContractInput>.from(((json['components']??[]) as List).map((i) => ContractInput.fromJson(i)));
}

class ContractOutput {
  final String name;
  final String type;
  ContractOutput.fromJson(Map<String, dynamic> json)
    : name = json['name'], type = json['type'];
}

class ContractABIEntry {
  final String name;
  final String type;
  final String stateMutability;
  final bool constant;
  final bool payable;
  final List<ContractOutput> outputs;
  final List<ContractInput> inputs;

  String get paramDescription {
    var params = inputs.map((i) => i.type).join(',');
    return '(${params})';
  }

  String get resultDescription {
    var results = outputs.map((i) => i.type).join(',');
    return '(${results})';
  }

  Uint8List get methodBytes {
    var s = '${name}${paramDescription}'.codeUnits;
    return SHA3Digest(256, ).process(Uint8List.fromList(s)).sublist(0, 4);
  }

  String get methodId => hex.encode(methodBytes);

  ContractABIEntry.fromJson(Map<String, dynamic> json):
    name = json['name'],
    type = json['type'],
    stateMutability = json['statueMutability'],
    constant = json['constant'],
    payable = json['payable'],
    inputs = List<ContractInput>.from(json['inputs'].map((i) => ContractInput.fromJson(i))),
    outputs = List<ContractOutput>.from(json['outputs'].map((i) => ContractOutput.fromJson(i)));

  Map<String, dynamic> decomposeCall(Uint8List data) {
    var buffer = new Uint8Buffer();
    buffer.addAll(data);
    var decoded = decodeType(paramDescription, buffer);
    if((decoded as List).length != inputs.length) {
      throw Exception("Decoded param count does not match function input count");
    }

    Map<String, dynamic> result = {};
    for(var i = 0; i < inputs.length; i++) {
      result[inputs[i].name] = decoded[i];
    }
    return result;
  }

  Uint8List composeCall(Map<String, dynamic> callParams) {
    return Uint8List.fromList(methodBytes + 
      encodeType(paramDescription, inputs.map((n) => callParams[n.name]).toList()));
  }

  Map<String, dynamic> decomposeResult(Uint8List data) {
    var buffer = new Uint8Buffer();
    buffer.addAll(data);
    var decoded = decodeType(resultDescription, buffer);
    if((decoded as List).length != outputs.length) {
      throw Exception("Decoded result count does not match function output count");
    }

    Map<String, dynamic> result = {};
    for(var i = 0; i < outputs.length; i++) {
      result[outputs[i].name] = decoded[i];
    }
    return result;
  }
}

class ContractABI {
  final List<ContractABIEntry> abis;
  Map<String, ContractABIEntry> methodIdMap = new Map(); // maps from method id to method entry
  Map<String, ContractABIEntry> methodNameMap = new Map(); // maps from method name to method entry

  ContractABI.fromJson(List<dynamic> json):
    abis = List<ContractABIEntry>
      .from(
        json
        .where((i) => i['type'] == 'function') // only processes function abi, ignores events and constructor
        .map((i) => ContractABIEntry.fromJson(i))
      )
    {
      abis.forEach((element) {
        methodIdMap[element.methodId] = element;
        methodNameMap[element.name] = element;
      });
    }

  ContractABIEntry getABIEntryByMethodId(String methodId) {
    return methodIdMap[methodId];
  }

  ContractABIEntry getABIEntryByMethodName(String methodName) {
    return methodNameMap[methodName];
  }

  Uint8List composeCall(ContractCall call)
    => getABIEntryByMethodName(call.functionName).composeCall(call.callParams);

  Map<String, dynamic> decomposeResult(String functionName, Uint8List data)
    => getABIEntryByMethodName(functionName).decomposeResult(data);

  ContractCall decomposeCall(Uint8List data) {
    var methodId = hex.encode(data.sublist(0, 4));
    var abiEntry = getABIEntryByMethodId(methodId);
    if(abiEntry == null) {
      throw Exception("Method id ${methodId} not found in abi, check whether input and abi matches");
    }
    var call = ContractCall(abiEntry.name);
    var params = abiEntry.decomposeCall(data.sublist(4));
    params.forEach((key, value) {
      call.setCallParam(key, value);
    });
    return call;
  }
}