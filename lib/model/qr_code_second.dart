import 'dart:convert';

class QrCodeSecond {
  dynamic customerCountry;
  dynamic providerCountry;
  String externalId;
  String accountingCurrency;
  bool active;
  bool enabled;
  String id;

  QrCodeSecond({
    this.customerCountry,
    this.providerCountry,
    this.externalId,
    this.accountingCurrency,
    this.active,
    this.enabled,
    this.id,
  });

  @override
  String toString() {
    return 'QrCodeSecond(customerCountry: $customerCountry, providerCountry: $providerCountry, externalId: $externalId, accountingCurrency: $accountingCurrency, active: $active, enabled: $enabled, id: $id)';
  }

  factory QrCodeSecond.fromMap(Map<String, dynamic> data) => QrCodeSecond(
        customerCountry: data['customerCountry'] as dynamic,
        providerCountry: data['providerCountry'] as dynamic,
        externalId: data['externalId'] as String,
        accountingCurrency: data['accountingCurrency'] as String,
        active: data['active'] as bool,
        enabled: data['enabled'] as bool,
        id: data['id'] as String,
      );

  Map<String, dynamic> toMap() => {
        'customerCountry': customerCountry,
        'providerCountry': providerCountry,
        'externalId': externalId,
        'accountingCurrency': accountingCurrency,
        'active': active,
        'enabled': enabled,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QrCodeSecond].
  factory QrCodeSecond.fromJson(String data) {
    return QrCodeSecond.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QrCodeSecond] to a JSON string.
  String toJson() => json.encode(toMap());

  QrCodeSecond copyWith({
    dynamic customerCountry,
    dynamic providerCountry,
    String externalId,
    String accountingCurrency,
    bool active,
    bool enabled,
    String id,
  }) {
    return QrCodeSecond(
      customerCountry: customerCountry ?? this.customerCountry,
      providerCountry: providerCountry ?? this.providerCountry,
      externalId: externalId ?? this.externalId,
      accountingCurrency: accountingCurrency ?? this.accountingCurrency,
      active: active ?? this.active,
      enabled: enabled ?? this.enabled,
      id: id ?? this.id,
    );
  }
}
