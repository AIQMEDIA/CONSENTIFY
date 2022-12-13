// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class PastIPFSResponse {
  String data;
  PastIPFSResponse({
    @required this.data,
  });

  PastIPFSResponse copyWith({
    String data,
  }) {
    return PastIPFSResponse(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
    };
  }

  factory PastIPFSResponse.fromMap(Map<String, dynamic> map) {
    return PastIPFSResponse(
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PastIPFSResponse.fromJson(String source) => PastIPFSResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PastIPFSResponse(data: $data)';

  @override
  bool operator ==(covariant PastIPFSResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
