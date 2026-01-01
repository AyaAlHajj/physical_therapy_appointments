import 'package:flutter/material.dart';
class Wounded {
  final int? id;
  final String firstname;
  final String surname;
  final String email;
  final String password;
  final String role;

  Wounded({
    this.id,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.password,
    this.role = 'wounded',
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'surname': surname,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory Wounded.fromMap(Map<String, dynamic> map) {
    return Wounded(
      id: map['id'] as int?,
      firstname: map['firstname'] as String,
      surname: map['surname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
    );
  }
}

// <<<<<<< HEAD
// class Wounded {
//   final int ?id;
// =======
// class Wounded{
//   final int? id;
// >>>>>>> origin/main
//   final String firstname;
//   final String surname;
//   final String email;
//   final String password;
//   final String role;

// <<<<<<< HEAD
//   Wounded(
//       {this.id,
//       required this.firstname,
//       required this.surname,
//       required this.email,
//       required this.password,
//       this.role='wounded',
//       });
// Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'firstname': firstname,
//       'surname':surname,
//       'email':email,
//       'password':password,
//       'role':role,
//     };
//   }
//   factory Wounded.fromMap(Map<String, dynamic> map) {
//     return Wounded(
//        id:map['id'] as int?,
//         firstname: map['firstname'] as String,
//         surname: map['surname'] as String,
//         email: map['email'] as String,
//         password: map['password'] as String,
//         role: map['role'] as String
//         );
//   }
// }
// =======
//   Wounded({
//     this.id,
//     required this.firstname,
//     required this.surname,
//     required this.email,
//     required this.password,
//     required this.role,
//   });

//   Map<String, Object?> getWoundedMap() {
//     return {
//       'name': firstname,
//       'surname': surname,
//       'email': email,
//       'password': password,
//       'role': role,
//     };
//   }

//   factory Wounded.fromMap(Map<String, Object?> map) {
//     return Wounded(
//       id: map['id'] as int?,
//       firstname: map['name'] as String,
//       surname: map['surname'] as String,
//       email: map['email'] as String,
//       password: map['password'] as String,
//       role: map['role'] as String,
//     );
//   }
// }
// >>>>>>> origin/main
