// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class LoginSessionData {
  String chainId;
  String account;
  LoginSessionData({
    @required this.chainId,
    @required this.account,
  });

  LoginSessionData copyWith({
    String chainId,
    String account,
  }) {
    return LoginSessionData(
      chainId: chainId ?? this.chainId,
      account: account ?? this.account,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chainId': chainId,
      'account': account,
    };
  }

  factory LoginSessionData.fromMap(Map<String, dynamic> map) {
    return LoginSessionData(
      chainId: map['chainId'] as String,
      account: map['account'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSessionData.fromJson(String source) => LoginSessionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginSessionData(chainId: $chainId, account: $account)';

  @override
  bool operator ==(covariant LoginSessionData other) {
    if (identical(this, other)) return true;
  
    return 
      other.chainId == chainId &&
      other.account == account;
  }

  @override
  int get hashCode => chainId.hashCode ^ account.hashCode;
}
