import 'dart:io';
import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/dashboards/therapist_dashboard.dart';
import 'package:physical_therapy_appointments/screens/dashboards/wounded_dashboard.dart';
import 'package:physical_therapy_appointments/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final pref = await SharedPreferences.getInstance();
  String? savedUser = pref.getString('email');
  String? role = pref.getString('role');
  int? userId = pref.getInt('userId');

  Widget startScreen;
  
  if(savedUser == null || userId == null){
    startScreen = const HomePage();
  }

  else{
    if(role == 'therapist'){
      startScreen = TherapistDashboard(therapistId: userId);
    }

    else{
      startScreen = WoundedDashboard(currentUserId: userId);
    }
  }

  runApp(MainApp(startScreen: startScreen,));
}

class MainApp extends StatelessWidget {
  final Widget startScreen;
  const MainApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startScreen,
    );
  }
}

