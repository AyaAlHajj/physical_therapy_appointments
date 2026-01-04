import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/dashboards/therapist_dashboard.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/screens/appointments/appointment_list_screen.dart';
import 'package:physical_therapy_appointments/screens/therapists_details.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<Therapist?>? therapists;

  const BottomNav({Key?key,
  required this.currentIndex,
   this.therapists,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      currentIndex: currentIndex,
      selectedItemColor:Color.fromARGB(255, 155, 40, 40),
      unselectedItemColor: Color.fromARGB(255, 92, 91, 91),
      onTap: (index) {
        
        if (index == currentIndex) return;
        
        if (index == 0) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const AppointmentListScreen(currentUserId: 0),
            )
          );
        } 
        
        else {
          if (therapists!=null && therapists!.isNotEmpty &&therapists![0] != null) {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => TherapistDashboard()
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
