final String tableAgreement = 'agreements';

class AgreementField {
  static final List<String> values = [
    id,
    consentAsker,
    consentGiver,
    consentAskerEmail,
    consentGiverEmail,
    agreementTime
  ];

  static final String id = 'id';
  static final String consentAsker = 'consentAsker';
  static final String consentGiver = 'consentGiver';
  static final String consentAskerEmail = 'consentAskerEmail';
  static final String consentGiverEmail = 'consentGiverEmail';
  static final String agreementTime = 'agreementTime';
}

class Agreement {
  final int id;
  final String consentAsker;
  final String consentGiver;
  final String consentAskerEmail;
  final String consentGiverEmail;
  final DateTime agreementTime;

  const Agreement(
      {this.id,
      this.consentAsker,
      this.consentGiver,
      this.consentAskerEmail,
      this.consentGiverEmail,
      this.agreementTime});

  Agreement copy({
    int id,
    final String consentAsker,
    final String consentGiver,
    final String consentAskerEmail,
    final String consentGiverEmail,
    final DateTime agreementTime,
  }) =>
      Agreement(
          id: id ?? this.id,
          consentAsker: consentAsker ?? this.consentAsker,
          consentGiver: consentGiver ?? this.consentGiver,
          consentAskerEmail: consentAskerEmail ?? this.consentAskerEmail,
          consentGiverEmail: consentGiverEmail ?? this.consentGiverEmail,
          agreementTime: agreementTime ?? this.agreementTime);

  static Agreement fromJson(Map<String, Object> json) => Agreement(
        id: json[AgreementField.id] as int,
        consentAsker: json[AgreementField.consentAsker] as String,
        consentGiver: json[AgreementField.consentGiver] as String,
        consentAskerEmail: json[AgreementField.consentAskerEmail] as String,
        consentGiverEmail: json[AgreementField.consentGiverEmail] as String,
        agreementTime:
            DateTime.parse(json[AgreementField.agreementTime] as String),
      );

  Map<String, Object> toJson() => {
        AgreementField.id: id,
        AgreementField.consentAsker: consentAsker,
        AgreementField.consentGiver: consentGiver,
        AgreementField.consentAskerEmail: consentAskerEmail,
        AgreementField.consentGiverEmail: consentGiverEmail,
        AgreementField.agreementTime: agreementTime.toIso8601String(),
      };
}
