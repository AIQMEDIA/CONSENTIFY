import 'dart:convert';

import 'balance.dart';

class QrCodeFirst {
  String currency;
  bool active;
  Balance balance;
  dynamic accountCode;
  dynamic accountNumber;
  bool frozen;
  String xpub;
  String customerId;
  String accountingCurrency;
  String id;

  QrCodeFirst({
    this.currency,
    this.active,
    this.balance,
    this.accountCode,
    this.accountNumber,
    this.frozen,
    this.xpub,
    this.customerId,
    this.accountingCurrency,
    this.id,
  });

  @override
  String toString() {
    return 'QrCodeFirst(currency: $currency, active: $active, balance: $balance, accountCode: $accountCode, accountNumber: $accountNumber, frozen: $frozen, xpub: $xpub, customerId: $customerId, accountingCurrency: $accountingCurrency, id: $id)';
  }

  factory QrCodeFirst.fromMap(Map<String, dynamic> data) => QrCodeFirst(
        currency: data['currency'] as String,
        active: data['active'] as bool,
        balance: data['balance'] == null
            ? null
            : Balance.fromMap(data['balance'] as Map<String, dynamic>),
        accountCode: data['accountCode'] as dynamic,
        accountNumber: data['accountNumber'] as dynamic,
        frozen: data['frozen'] as bool,
        xpub: data['xpub'] as String,
        customerId: data['customerId'] as String,
        accountingCurrency: data['accountingCurrency'] as String,
        id: data['id'] as String,
      );

  Map<String, dynamic> toMap() => {
        'currency': currency,
        'active': active,
        'balance': balance?.toMap(),
        'accountCode': accountCode,
        'accountNumber': accountNumber,
        'frozen': frozen,
        'xpub': xpub,
        'customerId': customerId,
        'accountingCurrency': accountingCurrency,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QrCodeFirst].
  factory QrCodeFirst.fromJson(String data) {
    return QrCodeFirst.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QrCodeFirst] to a JSON string.
  String toJson() => json.encode(toMap());

  QrCodeFirst copyWith({
    String currency,
    bool active,
    Balance balance,
    dynamic accountCode,
    dynamic accountNumber,
    bool frozen,
    String xpub,
    String customerId,
    String accountingCurrency,
    String id,
  }) {
    return QrCodeFirst(
      currency: currency ?? this.currency,
      active: active ?? this.active,
      balance: balance ?? this.balance,
      accountCode: accountCode ?? this.accountCode,
      accountNumber: accountNumber ?? this.accountNumber,
      frozen: frozen ?? this.frozen,
      xpub: xpub ?? this.xpub,
      customerId: customerId ?? this.customerId,
      accountingCurrency: accountingCurrency ?? this.accountingCurrency,
      id: id ?? this.id,
    );
  }
}
