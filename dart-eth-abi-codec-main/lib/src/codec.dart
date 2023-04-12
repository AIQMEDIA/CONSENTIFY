library eth_abi_codec.codec;

/// 
/// https://docs.soliditylang.org/en/v0.5.3/abi-spec.html
/// 

import 'dart:typed_data';
import 'package:convert/convert.dart';

/// Judge whether a type is dynamically located
/// definition: The following types are called “dynamic”:
/// bytes
/// string
/// T[] for any T
/// T[k] for any dynamic T and any k >= 0
/// (T1,...,Tk) if Ti is dynamic for some 1 <= i <= k

bool isDynamicType(String typeName) {
  if(typeName == 'bytes' || typeName == 'string') {
    return true;
  }

  var reg = RegExp(r"^([a-z\d\[\]\(\),]{1,})\[([\d]*)\]$");
  var match = reg.firstMatch(typeName);
  if(match != null) {
    var baseType = match.group(1);
    var repeatCount = match.group(2);
    if(repeatCount == "") {
      return true;
    }
    return isDynamicType(baseType);
  }

  if(typeName.endsWith(')') && typeName.startsWith('(')) {
    var subTypes = typeName.substring(1, typeName.length - 1).split(',');
    for(var i = 0; i < subTypes.length; i++) {
      if(isDynamicType(subTypes[i]))
        return true;
    }
    return false;
  }
  return false;
}


int sizeOfStaticType(String typeName) {
  var reg = RegExp(r"^([a-z\d\[\]\(\),]{1,})\[([\d]*)\]$");
  var match = reg.firstMatch(typeName);
  if(match != null) {
    var baseType = match.group(1);
    var repeatCount = match.group(2);
    assert(repeatCount != "");
    return sizeOfStaticType(baseType) * int.parse(repeatCount);
  }

  if(typeName.endsWith(')') && typeName.startsWith('(')) {
    var subTypes = typeName.substring(1, typeName.length - 1).split(',');
    return subTypes.fold(0, (previousValue, element) => previousValue + sizeOfStaticType(element));
  }

  // other static types all has capacity of 32
  return 32;
}

Uint8List padLeft(Uint8List d, int alignBytes) {
  int padLength = alignBytes - d.length % alignBytes;
  if(padLength == alignBytes)
    padLength = 0;
  var filled = new List<int>.filled(padLength, 0);
  return Uint8List.fromList(Uint8List.fromList(filled) + d);
}

Uint8List padRight(Uint8List d, int alignBytes) {
  int padLength = alignBytes - d.length % alignBytes;
  var filled = new List<int>.filled(padLength, 0);
  return Uint8List.fromList(d + Uint8List.fromList(filled));
}

BigInt decodeUint256(Iterable b) {
  return BigInt.parse(hex.encode(b.take(32).toList()), radix: 16);
}

Uint8List encodeUint256(BigInt v) {
  var s = v.toRadixString(16);
  if(s.length.isOdd) {
    s = '0' + s;
  }
  var r = Uint8List.fromList(hex.decode(s));
  return padLeft(r, 32);
}

BigInt decodeInt256(Iterable b) {
  return BigInt.parse(hex.encode(b.take(32).toList()), radix: 16);
}

Uint8List encodeInt256(BigInt v) {
  var s = v.toRadixString(16);
  if(s.length.isOdd) {
    s = '0' + s;
  }
  var r = Uint8List.fromList(hex.decode(s));
  return padLeft(r, 32);
}

int decodeInt(Iterable b) {
  return decodeUint256(b).toInt();
}

Uint8List encodeInt(int v) {
  return encodeUint256(BigInt.from(v));
}

bool decodeBool(Iterable b) {
  var decoded = decodeUint256(b).toInt();
  if(decoded != 0 && decoded != 1) {
    throw Exception("invalid encoded value for bool");
  }

  return decoded == 1;
}

Uint8List encodeBool(bool b) {
  return encodeInt(b ? 1 : 0);
}

Uint8List decodeFixedBytes(Iterable b, int length) {
  return Uint8List.fromList(b.take(length).toList());
}

Uint8List decodeBytes(Iterable b) {
  var length = decodeInt(b);
  return Uint8List.fromList(b.skip(32).take(length).toList());
}

Uint8List encodeFixedBytes(Uint8List v, int length) {
  if(v.length > 32) {
    throw Exception("Can not encode fixed bytes of length longer than 32");
  }

  if(v.length != length) {
    throw Exception("incompatible byte length");
  }

  var pad0s = 32 - v.length;
  List<int> pads = [];
  for(var i = 0; i < pad0s; i++)
    pads.add(0);
  return Uint8List.fromList(v + pads);
}

Uint8List encodeBytes(Uint8List v) {
  var length = encodeInt(v.length);
  var pad0s = 32 - v.length % 32;
  List<int> pads = [];
  for(var i = 0; i < pad0s; i++)
    pads.add(0);
  return Uint8List.fromList(length + v + pads);
}

String decodeString(Iterable b) {
  var length = decodeInt(b);
  return String.fromCharCodes(b.skip(32).take(length));
}

Uint8List encodeString(String s) {
  var length = encodeInt(s.length);
  return Uint8List.fromList(length + padRight(Uint8List.fromList(s.codeUnits), 32));
}

String decodeAddress(Iterable b) {
  return hex.encode(b.take(32).skip(12).toList());
}

Uint8List encodeAddress(String a) {
  Uint8List encoded = hex.decode(a);
  if(encoded.length != 20) {
    throw Exception("invalid address length");
  }
  return padLeft(encoded, 32);
}

List<dynamic> decodeList(Iterable b, String type) {
  var length = decodeInt(b);
  return decodeFixedLengthList(b.skip(32), type, length);
}

Uint8List encodeList(List<dynamic> l, String type) {
  var length = encodeInt(l.length);
  return Uint8List.fromList(length + encodeFixedLengthList(l, type, l.length));
}

List<dynamic> decodeFixedLengthList(Iterable b, String type, int length) {
  List<dynamic> result = new List();
  for(var i = 0; i < length; i++) {
    if(isDynamicType(type)) {
      var relocate = decodeInt(b.skip(i * 32));
      result.add(decodeType(type, b.skip(relocate)));
    } else {
      result.add(decodeType(type, b.skip(i * 32)));
    }
  }
  return result;
}

Uint8List encodeFixedLengthList(List<dynamic> l, String type, int length) {
  if(l.length != length) {
    throw Exception("incompatibal input list length for type ${type}");
  }

  if(isDynamicType(type)) {
    List<int> relocates = [];
    var baseOffset = 32 * length;
    List<int> contents = [];
    for(var i = 0; i < length; i++) {
      relocates.addAll(encodeInt(baseOffset + contents.length));
      contents.addAll(encodeType(type, l[i]));
    }
    return Uint8List.fromList(relocates + contents);
  } else {
    List<int> contents = [];
    for(var i = 0; i < length; i++) {
      contents.addAll(encodeType(type, l[i]));
    }
    return Uint8List.fromList(contents);
  }
}

List<String> splitTypes(String typesStr) {
  if(typesStr.length == 0)
    return [];
  var currentStart = 0;
  List<String> subTypes = [];
  List<String> parentheses = [];
  for(var i = 0; i < typesStr.length; i++) {
    var c = typesStr[i];
    switch(c) {
      case '(':
      case '[':
        parentheses.add(c);
        break;
      case ')':
        var pop = parentheses.removeLast();
        assert(pop == '(');
        break;
      case ']':
        var pop = parentheses.removeLast();
        assert(pop == '[');
        break;
      case ',':
        if(parentheses.isEmpty) {
          subTypes.add(typesStr.substring(currentStart, i));
          currentStart = i + 1;
        }
        break;
    }
  }

  if(currentStart < typesStr.length) {
    subTypes.add(typesStr.substring(currentStart));
  }
  return subTypes;
}

dynamic decodeType(String type, Iterable b) {
  switch (type) {
    case 'string':
      return decodeString(b);
    case 'address':
      return decodeAddress(b);
    case 'bool':
      return decodeBool(b);
    case 'bytes':
      return decodeBytes(b);
    default:
      break;
  }

  var reg = RegExp(r"^([a-z\d\[\]\(\),]{1,})\[([\d]*)\]$");
  var match = reg.firstMatch(type);
  if(match != null) {
    var baseType = match.group(1);
    var repeatCount = match.group(2);
    if(repeatCount == "") {
      return decodeList(b, baseType);
    } else {
      int repeat = int.parse(repeatCount);
      return decodeFixedLengthList(b, baseType, repeat);
    }
  }

  // support uint8, uint128, uint256 ...
  if(type.startsWith('uint')) {
    return decodeUint256(b);
  }

  if(type.startsWith('int')) {
    return decodeInt256(b);
  }

  // bytes<M> 0 < M <= 32
  if(type.startsWith('bytes')) {
    var length = int.parse(type.substring(5));
    return decodeFixedBytes(b, length);
  }

  if(type.startsWith('(') && type.endsWith(')')) {
    var types = type.substring(1, type.length - 1);
    var subtypes = splitTypes(types);
    List<dynamic> result = new List();
    int headerOffset = 0;
    for(var i = 0; i < subtypes.length; i++) {
      if(isDynamicType(subtypes[i])) {
        var relocate = decodeInt(b.skip(headerOffset));
        result.add(decodeType(subtypes[i], b.skip(relocate)));
        headerOffset += 32;
      } else {
        result.add(decodeType(subtypes[i], b.skip(headerOffset)));
        headerOffset += sizeOfStaticType(subtypes[i]);
      }
    }
    return result;
  }
}

Uint8List encodeType(String type, dynamic data) {
  switch (type) {
    case 'string':
      return encodeString(data);
    case 'address':
      return encodeAddress(data);
    case 'bool':
      return encodeBool(data);
    case 'bytes':
      return encodeBytes(data);
  }

  var reg = RegExp(r"^([a-z\d\[\]\(\),]{1,})\[([\d]*)\]$");
  var match = reg.firstMatch(type);
  if(match != null) {
    var baseType = match.group(1);
    var repeatCount = match.group(2);
    if(repeatCount == "") {
      return encodeList(data, baseType);
    } else {
      int repeat = int.parse(repeatCount);
      return encodeFixedLengthList(data, baseType, repeat);
    }
  }

  if(type.startsWith('uint')) {
    if(data is BigInt)
      return encodeUint256(data);
    else if(data is String) {
      String d = data.toLowerCase();
      if(d.startsWith('0x')) {
        return encodeUint256(BigInt.parse(d.substring(2), radix: 16));
      } else if(d.contains(new RegExp(r'[a-f]'))) {
        return encodeUint256(BigInt.parse(d, radix: 16));
      } else {
        return encodeUint256(BigInt.parse(d));
      }
    } else
      return encodeInt(data);
  }

  if(type.startsWith('int')) {
    if(data is BigInt)
      return encodeInt256(data);
    else if(data is String) {
      String d = data.toLowerCase();
      if(d.startsWith('0x')) {
        return encodeInt256(BigInt.parse(d.substring(2), radix: 16));
      } else if(d.contains(new RegExp(r'[a-f]'))) {
        return encodeInt256(BigInt.parse(d, radix: 16));
      } else {
        return encodeInt256(BigInt.parse(d));
      }
    } else
      return encodeInt(data);
  }

  if(type.startsWith('bytes')) {
    var length = int.parse(type.substring(5));
    return encodeFixedBytes(data, length);
  }

  if(type.startsWith('(') && type.endsWith(')')) {
    var types = type.substring(1, type.length - 1);
    var subtypes = splitTypes(types);
    if(subtypes.length != (data as List).length) {
      throw Exception("incompatibal input length and contract abi arguments for ${type}");
    }

    List<int> headers = [];
    List<int> contents = [];

    int baseOffset = 0;
    for(var i = 0; i < subtypes.length; i++) {
      if(isDynamicType(subtypes[i]))
        baseOffset += 32;
      else
        baseOffset += sizeOfStaticType(subtypes[i]);
    }

    for(var i = 0; i < subtypes.length; i++) {
      if(isDynamicType(subtypes[i])) {
        headers.addAll(encodeInt(baseOffset + contents.length));
        contents.addAll(encodeType(subtypes[i], data[i]));
      } else {
        headers.addAll(encodeType(subtypes[i], data[i]));
      }
    }
    return Uint8List.fromList(headers + contents);
  }
}