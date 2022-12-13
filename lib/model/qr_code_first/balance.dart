import 'dart:convert';

class Balance {
  String accountBalance;
  String availableBalance;

  Balance({this.accountBalance, this.availableBalance});

  @override
  String toString() {
    return 'Balance(accountBalance: $accountBalance, availableBalance: $availableBalance)';
  }

  factory Balance.fromMap(Map<String, dynamic> data) => Balance(
        accountBalance: data['accountBalance'] as String,
        availableBalance: data['availableBalance'] as String,
      );

  Map<String, dynamic> toMap() => {
        'accountBalance': accountBalance,
        'availableBalance': availableBalance,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Balance].
  factory Balance.fromJson(String data) {
    return Balance.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Balance] to a JSON string.
  String toJson() => json.encode(toMap());

  Balance copyWith({
    String accountBalance,
    String availableBalance,
  }) {
    return Balance(
      accountBalance: accountBalance ?? this.accountBalance,
      availableBalance: availableBalance ?? this.availableBalance,
    );
  }
}
