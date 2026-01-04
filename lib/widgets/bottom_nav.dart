import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/dashboards/therapist_dashboard.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/screens/dashboards/wounded_dashboard.dart';
import 'package:physical_therapy_appointments/screens/therapists_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<Therapist>? therapists;

  const BottomNav({Key?key,
  required this.currentIndex,
  this.therapists,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      selectedItemColor:Color.fromARGB(255, 155, 40, 40),
      unselectedItemColor: Color.fromARGB(255, 92, 91, 91),
      onTap: (index) async {
        
        final pref = await SharedPreferences.getInstance();
        String? role = pref.getString('role');
        int? id = pref.getInt('userId');
        
        if (index == currentIndex) return;
        
        if (index == 0) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context){
                if(role == 'therapist'){
                  return TherapistDashboard(therapistId: id ?? 0);
                }

                else{
                  return WoundedDashboard(currentUserId: id ?? 0);
                }
              },
            )
          );
        } 
        
        else {
          List<Therapist> therapistsList = (therapists ?? []).whereType<Therapist>().toList();

          if(therapistsList.isEmpty){
            therapistsList = await loadTherapists();
          }

          if (therapistsList.isNotEmpty) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => TherapistDetailsScreen(therapists: therapistsList),
            )
          );
          }

          else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No therapists available')),
            );
          }
        }

    },
  

items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Therapists',
        ),
      ],
    );
  }
}
