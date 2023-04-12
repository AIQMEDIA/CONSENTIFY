# Decode and encode ETH contract call package
This package only deals with contract call encoding/decoding.

# What this package does NOT do
* fetch contract abi from chain
* fetch any transaction infomation from chain
* encoding the whole ETH transaction with RLP format
* digest or sign transaction
* send transaction to chain

# Decode contract call
```dart
import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:convert/convert.dart';

// Step1. 
// Fetch contract abi from either etherscan.io or infura.  
// For example, contract abi for USDT-ERC20 can be found on 
// [USDT ERC20 Contract Code Page]
// (https://etherscan.io/address/0xdac17f958d2ee523a2206206994597c13d831ec7#code),
// the abi is listed at Contract ABI section.

var abi = ContractABI.fromJson(jsonDecode(ABI_JSON_STR));

// Step2.
// Build contract call object by abi
var data = hex.decode('hex string of input field');
var call = abi.decomposeCall(data);

// Step3.
// Fetch call infomations
print(call.functionName);
print(call.callParams['_to']);
print(call.callParams['_value']);
```

# Encode contract call
```dart
import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:convert/convert.dart';

// Step1.
// Fetch abi json
var abi = ContractABI.fromJson(jsonDecode(ABI_JSON_STR));

// Step2.
// Build contract call object
var call = ContractCall('transfer')
    ..setCallParam('_to', 'c9d983203307abccd3e1b303a00ea0a19724fe2c')
    ..setCallParam('_value', BigInt.from(1000000000000000000));

// Step3.
// Encode call
print(hex.encode(abi.composeCall(call)));
```

# Decode contract call result
```dart
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

var abi = ContractABI.fromJson(jsonDecode(ABI_JSON_STR));
var data = hex.decode('hex string of contract call result');
var res = abi.decomposeResult('method name', data);
print(res['method output param name']);
```