import 'dart:convert';

class FormM {
  String personID;
  String serial;
  String reason;
  double calculate;

  DateTime time;
  FormM({
    this.personID = '',
    this.serial = '',
    this.reason = '',
    this.calculate = 0.0,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personID': personID,
      'serial': serial,
      'reason': reason,
      'calculate': calculate,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory FormM.fromMap(Map<String, dynamic> map) {
    return FormM(
      personID: map['personID'] as String,
      serial: map['serial'] as String,
      reason: map['reason'] as String,
      calculate: map['calculate'] as double,
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'] as int)
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FormM.fromJson(String source) =>
      FormM.fromMap(json.decode(source) as Map<String, dynamic>);
}
