class Therapist {
  final int ? id;
  final String firstname;
  final String surname;
  final String phone;
  final String info;
  final String email;
  final String password;
  final String role;
  
  Therapist({
    this.id,
    required this.firstname,
    required this.surname,
    required this.phone,
    required this.info,
    required this.email,
    required this.password,
    this.role ='Therapist',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'surname':surname,
      'phone': phone,
      'info': info,
      'email':email,
      'password':password,
      'role':role,
    };
  }
  factory Therapist.fromMap(Map<String,dynamic> map){
    return Therapist(
      id: map['id'] as int?,
      firstname: map['firstname'] as String,
      surname: map['surname'] as String,
     phone:map['phone'] as String,
     info:map['info'] as String,
     email:map['email'] as  String,
     password: map['password'] as String,
     role: map['role'] as String,
     
     );
  }
  
}

