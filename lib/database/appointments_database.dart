import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentsDatabase {
  Future<Database> getDatabase() async {
    String dbPath = await getDatabasesPath();
    Database db = await openDatabase(join(dbPath, 'appointments.db'),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE therapists(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstname TEXT NOT NULL,
          surname TEXT NOT NULL,
            phone TEXT,
            info TEXT,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            role TEXT NOT NULL
          )
         ''');
      await db.execute('''
             CREATE TABLE wounded(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstname TEXT NOT NULL,
            surname TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            role TEXT NOT NULL
          ) 
''');
      await db.execute('''

           CREATE TABLE therapist_slots(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            therapistId INTEGER NOT NULL,
            dayOfWeek INTEGER NOT NULL,
            slotTime TEXT NOT NULL,
            FOREIGN KEY (therapistId) REFERENCES therapists (id) ON DELETE CASCADE
          )
''');
      await db.execute('''
                 CREATE TABLE appointments(
               id INTEGER PRIMARY KEY AUTOINCREMENT,
                woundedId INTEGER NOT NULL,
                therapistId INTEGER NOT NULL,
                date INT NOT NULL,
                slotTime TEXT NOT NULL,
                FOREIGN KEY(woundedId) REFERENCES wounded(id) ON DELETE CASCADE ,
                FOREIGN KEY (therapistId) REFERENCES therapists (id) ON DELETE CASCADE,
  )
''');
    },
    version:  1,
    );
    return db;
  }
}
