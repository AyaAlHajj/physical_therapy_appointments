import 'package:physical_therapy_appointments/database/appointments_database.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/therapist_slots.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';

// ---------------Thrapist Table--------------------//
Future<void> insertTherapist(Therapist therapist) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.insert('therapists', therapist.toMap());
}

Future<List<Therapist>> loadTherapists() async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query('therapists');
  List<Therapist> resultList = result.map((row) {
    return Therapist.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteTherapist(int therapistId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.delete('therapists', where: 'id=?', whereArgs: [therapistId]);
}

Future<Therapist?> getTherapistbyId(int therapistId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result =
      await db.query('therapists', where: 'id=?', whereArgs: [therapistId]);
  if (result.isEmpty) return null;
  return Therapist.fromMap(result.first);
}

//--------------Wounded Table----------------//

Future<void> insertWounded(Wounded wounded) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.insert('wounded', wounded.toMap());
}

Future<List<Wounded>> loadWounded() async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query('wounded');

  List<Wounded> resultList = result.map((row) {
    return Wounded.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteWounded(int woundedId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.delete('wounded', where: 'id = ?', whereArgs: [woundedId]);
}

Future<Wounded?> getWoundedById(int woundedId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result =
      await db.query('wounded', where: 'id = ?', whereArgs: [woundedId]);
  if (result.isEmpty) return null;
  return Wounded.fromMap(result.first);
}

//------------------- TherapistSlot Table ----------------// :
Future<void> insertTherapistSlot(TherapistSlots therapistSlot) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.insert('therapist_slots', therapistSlot.toMap());
}

Future<List<TherapistSlots>> loadTherapistSlots() async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query('therapist_slots');
  List<TherapistSlots> resultList = result.map((row) {
    return TherapistSlots.fromMap(row);
  }).toList();
  return resultList;
}

Future<void>deleteTherapistSlot(int therapistSlotsId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.delete('therapist_slots', where: 'id = ?', whereArgs: [therapistSlotsId]);
}

Future<TherapistSlots?> getTherapistSlotById(int therapistSlotsId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db
      .query('therapist_slots', where: 'id = ?', whereArgs: [therapistSlotsId]);
  if (result.isEmpty) return null;
  return TherapistSlots.fromMap(result.first);
}
Future<List<TherapistSlots>> loadSlotsByTherapist(int therapistId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'therapist_slots',
    where: 'therapistId = ?',
    whereArgs: [therapistId],
  );
  
  return result.map((row) => TherapistSlots.fromMap(row)).toList();
}
Future<List<TherapistSlots>> loadSlotsByDay(int therapistId, int dayOfWeek) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'therapist_slots',
    where: 'therapistId = ? AND dayOfWeek = ?',
    whereArgs: [therapistId, dayOfWeek],
  );
  
  return result.map((row) => TherapistSlots.fromMap(row)).toList();
}
//------------------ Appointments Table -------------------------//:

Future<void> insertAppointment(Appointment appointment) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.insert('appointments', appointment.toMap());
}

Future<List<Appointment>> loadAppointments() async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query('appointments');
  List<Appointment> resultList = result.map((row) {
    return Appointment.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteAppointment(int appointmentId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.delete('appointments', where: 'id = ?', whereArgs: [appointmentId]);
}

Future<Appointment?> getAppointmentById(int appointmentId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db
      .query('appointments', where: 'id = ?', whereArgs: [appointmentId]);
  if (result.isEmpty) return null;
  return Appointment.fromMap(result.first);
}

Future<void> updateAppointment(Appointment appointment) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  db.update('appointments', appointment.toMap(),
      where: 'id = ?', whereArgs: [appointment.id]);
}

Future<List<Appointment>> loadAppointmentsByWounded(int woundedId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();

  final result = await db.query(
    'appointments',
    where: 'woundedId = ?',
    whereArgs: [woundedId],
  );
  List<Appointment> appointments = result.map((row) {
    return Appointment.fromMap(row);
  }).toList();
  return appointments;
}
Future<List<Appointment>> getAppointmentsByTherapistAndDate(
  int therapistId,
  String date,
) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();

  final result = await db.query(
    'appointments',
    where: 'therapistId = ? AND date = ?',
    whereArgs: [therapistId, date],
  );

  return result.map((row) => Appointment.fromMap(row)).toList();
}
Future<List<Appointment>> loadAppointmentsByTherapist(int therapistId) async {
  AppointmentsDatabase database = AppointmentsDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'appointments',
    where: 'therapistId = ?',
    whereArgs: [therapistId],
  );
  
  return result.map((row) => Appointment.fromMap(row)).toList();
}