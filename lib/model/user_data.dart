// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  String username;
  String email;
  String dob;
  String mob;
  UserData({
    this.username,
    this.email,
    this.dob,
    this.mob,
  });

  UserData copyWith({
    String username,
    String email,
    String dob,
    String mob,
  }) {
    return UserData(
      username: username ?? this.username,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      mob: mob ?? this.mob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'dob': dob,
      'mob': mob,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'] as String,
      email: map['email'] as String,
      dob: map['dob'] as String,
      mob: map['mob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(username: $username, email: $email, dob: $dob, mob: $mob)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.dob == dob &&
        other.mob == mob;
  }

  @override
  int get hashCode {
    return username.hashCode ^ email.hashCode ^ dob.hashCode ^ mob.hashCode;
  }
}
