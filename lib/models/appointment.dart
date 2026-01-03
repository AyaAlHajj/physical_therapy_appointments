import 'package:flutter/material.dart';
class Appointment {
  final int? id;
  final int woundedId;
  final int therapistId;
  final int date;
  final String slotTime; // Kept from rayan-ui

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
      'slotTime': slotTime,
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
    String? slotTime,
  }) {
    return Appointment(
      id: id ?? this.id,
      woundedId: woundedId ?? this.woundedId,
      therapistId: therapistId ?? this.therapistId,
      date: date ?? this.date,
      slotTime: slotTime ?? this.slotTime,
    );
  }
}












// <<<<<<< HEAD
// class Appointment {
// =======
// class Appointments{
// >>>>>>> origin/main
//   final int? id;
//   final int woundedId;
//   final int therapistId;
//   final int date;
// <<<<<<< HEAD
//   final String slotTime;

//   Appointment({
// =======

//   Appointments({
// >>>>>>> origin/main
//     this.id,
//     required this.woundedId,
//     required this.therapistId,
//     required this.date,
// <<<<<<< HEAD
//     required this.slotTime,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'woundedId': woundedId,
//       'therapistId': therapistId,
//       'date': date,
//       'slotTime':slotTime,
//     };
//   }

//   factory Appointment.fromMap(Map<String, dynamic> map) {
//     return Appointment(
// =======
//   });

//   Map<String, Object?> getAppointmentMap() {
//     return {
//       'woundedId': woundedId,
//       'therapistId': therapistId,
//       'date': date,
//     };
//   }

//   factory Appointments.fromMap(Map<String, Object?> map) {
//     return Appointments(
// >>>>>>> origin/main
//       id: map['id'] as int?,
//       woundedId: map['woundedId'] as int,
//       therapistId: map['therapistId'] as int,
//       date: map['date'] as int,
// <<<<<<< HEAD
//       slotTime: map['slotTime'] as String,
//     );
//   }
//   Appointment copyWith({
//     int? id,
//     int? woundedId,
//     int? therapistId,
//     int? date,
//     String?slotTime,
//   }) {
//     return Appointment(
//       id: id ?? this.id,
//       woundedId: woundedId ?? this.woundedId,
//       therapistId: therapistId ?? this.therapistId,
//       date: date ?? this.date,
//       slotTime: slotTime??this.slotTime,
//     );
//   }
// }
// =======
//     );
//   }
// }
// >>>>>>> origin/main
