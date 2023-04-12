import 'dart:convert';

class QrCodeThird {
  String username;
  String email;
  String dob;
  String mob;

  QrCodeThird({this.username, this.email, this.dob, this.mob});

  @override
  String toString() {
    return 'QrCodeThird(username: $username, email: $email, dob: $dob, mob: $mob)';
  }

  factory QrCodeThird.fromMap(Map<String, dynamic> data) => QrCodeThird(
        username: data['username'] as String,
        email: data['email'] as String,
        dob: data['dob'] as String,
        mob: data['mob'] as String,
      );

  Map<String, dynamic> toMap() => {
        'username': username,
        'email': email,
        'dob': dob,
        'mob': mob,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QrCodeThird].
  factory QrCodeThird.fromJson(String data) {
    return QrCodeThird.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QrCodeThird] to a JSON string.
  String toJson() => json.encode(toMap());

  QrCodeThird copyWith({
    String username,
    String email,
    String dob,
    String mob,
  }) {
    return QrCodeThird(
      username: username ?? this.username,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      mob: mob ?? this.mob,
    );
  }
}
