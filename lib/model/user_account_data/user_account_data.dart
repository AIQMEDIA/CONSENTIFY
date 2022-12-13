import 'dart:convert';

import 'balance.dart';

class UserAccountData {
  String currency;
  bool active;
  Balance balance;
  bool frozen;
  String xpub;
  String customerId;
  String accountingCurrency;
  String id;

  UserAccountData({
    this.currency,
    this.active,
    this.balance,
    this.frozen,
    this.xpub,
    this.customerId,
    this.accountingCurrency,
    this.id,
  });

  @override
  String toString() {
    return 'UserAccountData(currency: $currency, active: $active, balance: $balance, frozen: $frozen, xpub: $xpub, customerId: $customerId, accountingCurrency: $accountingCurrency, id: $id)';
  }

  factory UserAccountData.fromMap(Map<String, dynamic> data) {
    return UserAccountData(
      currency: data['currency'] as String,
      active: data['active'] as bool,
      balance: data['balance'] == null
          ? null
          : Balance.fromMap(data['balance'] as Map<String, dynamic>),
      frozen: data['frozen'] as bool,
      xpub: data['xpub'] as String,
      customerId: data['customerId'] as String,
      accountingCurrency: data['accountingCurrency'] as String,
      id: data['id'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        'currency': currency,
        'active': active,
        'balance': balance?.toMap(),
        'frozen': frozen,
        'xpub': xpub,
        'customerId': customerId,
        'accountingCurrency': accountingCurrency,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserAccountData].
  factory UserAccountData.fromJson(String data) {
    return UserAccountData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserAccountData] to a JSON string.
  String toJson() => json.encode(toMap());

  UserAccountData copyWith({
    String currency,
    bool active,
    Balance balance,
    bool frozen,
    String xpub,
    String customerId,
    String accountingCurrency,
    String id,
  }) {
    return UserAccountData(
      currency: currency ?? this.currency,
      active: active ?? this.active,
      balance: balance ?? this.balance,
      frozen: frozen ?? this.frozen,
      xpub: xpub ?? this.xpub,
      customerId: customerId ?? this.customerId,
      accountingCurrency: accountingCurrency ?? this.accountingCurrency,
      id: id ?? this.id,
    );
  }
}
