class Appointment {
  final int? id;
  final int woundedId;
  final int therapistId;
  final int date;
  final String slotTime;

  Appointment({
    this.id,
    required this.woundedId,
    required this.therapistId,
    required this.date,
    required this.slotTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'woundedId': woundedId,
      'therapistId': therapistId,
      'date': date,
      'slotTime':slotTime,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as int?,
      woundedId: map['woundedId'] as int,
      therapistId: map['therapistId'] as int,
      date: map['date'] as int,
      slotTime: map['slotTime'] as String,
    );
  }
  Appointment copyWith({
    int? id,
    int? woundedId,
    int? therapistId,
    int? date,
    String?slotTime,
  }) {
    return Appointment(
      id: id ?? this.id,
      woundedId: woundedId ?? this.woundedId,
      therapistId: therapistId ?? this.therapistId,
      date: date ?? this.date,
      slotTime: slotTime??this.slotTime,
    );
  }
}
