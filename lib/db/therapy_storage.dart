import 'package:physical_therapy_appointments/db/database.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/therapist_slots.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:sqflite/sqflite.dart';




//---------------- Save Appointment --------------//
Future<void> saveAppointment(Appointment appointment) async{
  final db = await TherapyDatabase().getDatabase();

  await db.insert('appointments', {
    'woundedId': appointment.woundedId,
    'therapistId': appointment.therapistId,
    'date': appointment.date,
    'slotTime': appointment.slotTime,
  });
}

//---------------- Therapists Schedule -----------//
Future<void> therapistSchedule(int therapistId) async{
  final db = await TherapyDatabase().getDatabase();
  List<int> workingDays = [0, 1, 2, 3, 4];
  List<String> times = [
    '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', 
    '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM'
  ];

  Batch batch = db.batch();
  for(int day in workingDays){
    for(String time in times){
      batch.insert('therapist_slots', {
        'therapistId': therapistId,
        'dayOfWeek' : day,
        'slotTime' : time,
      });
    }
  }
  await batch.commit(noResult: true);
}

//---------------- Therapists Slots --------------//
Future<void> slots(int therapistId, int dayIndex, String time) async{
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();

  await db.insert('therapist_slots', {
    'therapistId' : therapistId,
    'dayOfWeek' : dayIndex,
    'slotTime' : time,
  });
}
  
// --------------- User Login --------------------//
Future<dynamic> loginUser(String email, String password) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();

  final woundedResult = await db.query(
    'wounded',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );

  if (woundedResult.isNotEmpty){
    return Wounded.fromMap(woundedResult.first);
  }

  final therapistResult = await db.query(
    'therapists',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );

  if (therapistResult.isNotEmpty){
    return Therapist.fromMap(therapistResult.first);
  }

  return null;
}

// --------------- Check User Existence --------------------//
Future<bool> doesUserExist(String email) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  
  final woundedResult = await db.query(
    'wounded', 
    where: 'email = ?', 
    whereArgs: [email]);

  final therapistResult = await db.query(
    'therapists', 
    where: 'email = ?', 
    whereArgs: [email]);

  return woundedResult.isNotEmpty || therapistResult.isNotEmpty;
}


// --------------- Sign Up --------------------//
Future<dynamic> signUP({
  required String firstname,
  required String surname,
  required String email,
  required String password,
  String? phone,
  String? info,
  required String role,
}) async {

  if(await doesUserExist(email)){
    return 'User with this email already exists.';
  }

  final db = await TherapyDatabase().getDatabase();
  String table = (role == 'therapist') ? 'therapists' : 'wounded';

  final Map<String, dynamic> data = {
    'firstname': firstname,
    'surname': surname,
    'email': email,
    'password': password,
    'role': role,
  };
  
  if (role == 'therapist') {
    data['phone'] = phone;
    data['info'] = info;
  }
  
  int id = await db.insert(table, data);
  return id;
}



// ---------------Thrapist Table--------------------//
Future<void> insertTherapist(Therapist therapist) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('therapists', therapist.toMap());
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
  db.insert('wounded', wounded.toMap());
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

Future<void> insertAppointment(Appointment appointment) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.insert('appointments', appointment.toMap());
}

Future<List<Appointment>> loadAppointments() async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query('appointments');
  List<Appointment> resultList = result.map((row) {
    return Appointment.fromMap(row);
  }).toList();
  return resultList;
}

Future<void> deleteAppointment(int appointmentId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.delete('appointments', where: 'id = ?', whereArgs: [appointmentId]);
}

Future<Appointment?> getAppointmentById(int appointmentId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db
      .query('appointments', where: 'id = ?', whereArgs: [appointmentId]);
  if (result.isEmpty) return null;
  return Appointment.fromMap(result.first);
}

Future<void> updateAppointment(Appointment appointment) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  db.update('appointments', appointment.toMap(),
      where: 'id = ?', whereArgs: [appointment.id]);
}

Future<List<Appointment>> loadAppointmentsByWounded(int woundedId) async {
  TherapyDatabase database = TherapyDatabase();
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
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();

  final result = await db.query(
    'appointments',
    where: 'therapistId = ? AND date = ?',
    whereArgs: [therapistId, date],
  );

  return result.map((row) => Appointment.fromMap(row)).toList();
}

Future<List<Appointment>> loadAppointmentsByTherapist(int therapistId) async {
  TherapyDatabase database = TherapyDatabase();
  final db = await database.getDatabase();
  final result = await db.query(
    'appointments',
    where: 'therapistId = ?',
    whereArgs: [therapistId],
  );
  
  return result.map((row) => Appointment.fromMap(row)).toList();
}