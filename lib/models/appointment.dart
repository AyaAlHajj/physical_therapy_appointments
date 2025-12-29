class Appointments{
  final int? id;
  final int woundedId;
  final int therapistId;
  final int date;

  Appointments({
    this.id,
    required this.woundedId,
    required this.therapistId,
    required this.date,
  });

  Map<String, Object?> getAppointmentMap() {
    return {
      'woundedId': woundedId,
      'therapistId': therapistId,
      'date': date,
    };
  }

  factory Appointments.fromMap(Map<String, Object?> map) {
    return Appointments(
      id: map['id'] as int?,
      woundedId: map['woundedId'] as int,
      therapistId: map['therapistId'] as int,
      date: map['date'] as int,
    );
  }
}