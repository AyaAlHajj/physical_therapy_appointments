import 'dart:io';
import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/wounded_dashboard.dart';
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

  Widget startScreen = (savedUser == null) 
      ? const HomePage()
      : const WondedDashboard();

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