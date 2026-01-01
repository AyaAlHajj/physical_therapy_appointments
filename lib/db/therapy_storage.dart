import 'package:physical_therapy_appointments/db/database.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/therapist_slots.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';

// ---------------Thrapist Table--------------------//
Future<void> insertTherapist(Therapist therapist) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('therapists', therapist.getTherapistMap());
}

Future<List<Therapist>> loadTherapists() async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query('therapists');
  List<Therapist> resultList = result.map((row) {
    return Therapist.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteTherapist(int therapistId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.delete('therapists', where: 'id=?', whereArgs: [therapistId]);
}

Future<Therapist?> getTherapistbyId(int therapistId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result =
      await db.query('therapists', where: 'id=?', whereArgs: [therapistId]);
  if (result.isEmpty) return null;
  return Therapist.fromMap(result.first);
}

//--------------Wounded Table----------------//

Future<void> insertWounded(Wounded wounded) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('wounded', wounded.getWoundedMap());
}

Future<List<Wounded>> loadWounded() async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query('wounded');

  List<Wounded> resultList = result.map((row) {
    return Wounded.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteWounded(int woundedId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.delete('wounded', where: 'id = ?', whereArgs: [woundedId]);
}

Future<Wounded?> getWoundedById(int woundedId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result =
      await db.query('wounded', where: 'id = ?', whereArgs: [woundedId]);
  if (result.isEmpty) return null;
  return Wounded.fromMap(result.first);
}

//------------------- TherapistSlot Table ----------------// :
Future<void> insertTherapistSlot(TherapistSlots therapistSlot) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('therapist_slots', therapistSlot.toMap());
}

Future<List<TherapistSlots>> loadTherapistSlots() async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query('therapist_slots');
  List<TherapistSlots> resultList = result.map((row) {
    return TherapistSlots.fromMap(row);
  }).toList();
  return resultList;
}

Future<void>deleteTherapistSlot(int therapistSlotsId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.delete('therapist_slots', where: 'id = ?', whereArgs: [therapistSlotsId]);
}

Future<TherapistSlots?> getTherapistSlotById(int therapistSlotsId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db
      .query('therapist_slots', where: 'id = ?', whereArgs: [therapistSlotsId]);
  if (result.isEmpty) return null;
  return TherapistSlots.fromMap(result.first);
}
Future<List<TherapistSlots>> loadSlotsByTherapist(int therapistId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'therapist_slots',
    where: 'therapistId = ?',
    whereArgs: [therapistId],
  );
  
  return result.map((row) => TherapistSlots.fromMap(row)).toList();
}
Future<List<TherapistSlots>> loadSlotsByDay(int therapistId, int dayOfWeek) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'therapist_slots',
    where: 'therapistId = ? AND dayOfWeek = ?',
    whereArgs: [therapistId, dayOfWeek],
  );
  
  return result.map((row) => TherapistSlots.fromMap(row)).toList();
}
//------------------ Appointments Table -------------------------//:

Future<void> insertAppointment(Appointments appointment) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('appointments', appointment.getAppointmentMap());
}

Future<List<Appointments>> loadAppointments() async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query('appointments');
  List<Appointments> resultList = result.map((row) {
    return Appointments.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteAppointment(int appointmentId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.delete('appointments', where: 'id = ?', whereArgs: [appointmentId]);
}

Future<Appointments?> getAppointmentById(int appointmentId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db
      .query('appointments', where: 'id = ?', whereArgs: [appointmentId]);
  if (result.isEmpty) return null;
  return Appointments.fromMap(result.first);
}

Future<void> updateAppointment(Appointments appointment) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.update('appointments', appointment.getAppointmentMap(),
      where: 'id = ?', whereArgs: [appointment.id]);
}

Future<List<Appointments>> loadAppointmentsByWounded(int woundedId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();

  final result = await db.query(
    'appointments',
    where: 'woundedId = ?',
    whereArgs: [woundedId],
  );
  List<Appointments> appointments = result.map((row) {
    return Appointments.fromMap(row);
  }).toList();
  return appointments;
}
Future<List<Appointments>> getAppointmentsByTherapistAndDate(
  int therapistId,
  String date,
) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();

  final result = await db.query(
    'appointments',
    where: 'therapistId = ? AND date = ?',
    whereArgs: [therapistId, date],
  );

  return result.map((row) => Appointments.fromMap(row)).toList();
}
Future<List<Appointments>> loadAppointmentsByTherapist(int therapistId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'appointments',
    where: 'therapistId = ?',
    whereArgs: [therapistId],
  );
  
  return result.map((row) => Appointments.fromMap(row)).toList();
}