import 'package:flutter/material.dart';
class TherapistSlots {
  final int? id;
  final int therapistId;
  final int dayOfWeek;
  final String slotTime;

  TherapistSlots({
    this.id,
    required this.therapistId,
    required this.dayOfWeek,
    required this.slotTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'therapistId': therapistId,
      'dayOfWeek': dayOfWeek,
      'slotTime': slotTime,
    };
  }

  factory TherapistSlots.fromMap(Map<String, dynamic> map) {
    return TherapistSlots(
      id: map['id'] as int?,
      therapistId: map['therapistId'] as int,
      dayOfWeek: map['dayOfWeek'] as int,
      slotTime: map['slotTime'] as String,
    );
  }
}














// <<<<<<< HEAD
// class TherapistSlots {
// =======
// class TherapistSlots{
// >>>>>>> origin/main
//   final int? id;
//   final int therapistId;
//   final int dayOfWeek;
//   final String slotTime;

//   TherapistSlots({
//     this.id,
//     required this.therapistId,
//     required this.dayOfWeek,
//     required this.slotTime,
//   });

//   Map<String, dynamic> toMap() {
//     return {
// <<<<<<< HEAD
//       'id':id,
// =======
// >>>>>>> origin/main
//       'therapistId': therapistId,
//       'dayOfWeek': dayOfWeek,
//       'slotTime': slotTime,
//     };
//   }

// <<<<<<< HEAD
//   factory TherapistSlots.fromMap(Map<String, dynamic> map) {
//     return TherapistSlots(
//         id:map['id'] as int?,
//         therapistId: map['therapistId'] as int,
//         dayOfWeek: map['dayOfWeek'] as int,
//         slotTime: map['slotTime'] as String,
//         );
//   }
// }
// =======
//   factory TherapistSlots.fromMap(Map<String, Object?> map) {
//     return TherapistSlots(
//       id: map['id'] as int?,
//       therapistId: map['therapistId'] as int,
//       dayOfWeek: map['dayOfWeek'] as int,
//       slotTime: map['slotTime'] as String,
//     );
//   } 
// }
// >>>>>>> origin/main
