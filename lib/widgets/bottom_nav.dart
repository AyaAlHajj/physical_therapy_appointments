import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({Key?key,required this.currentIndex}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor:const Color.fromARGB(255, 116, 150, 142),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        
        if (index == currentIndex) return;

        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/profile');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/appointments');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, '/therapists');
        }
      },
  

items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
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
