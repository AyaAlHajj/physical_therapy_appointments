import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/widgets/welcomeview.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ConcentricPageView(
        colors: const [Colors.white, Color.fromARGB(255, 116, 150, 142)],
        radius: 30,
        itemCount: 1,
        
        nextButtonBuilder: (context) => 
          IconButton(
            highlightColor: Colors.white24,
            hoverColor: Colors.white10,
            
            icon: const Icon(
              Icons.navigate_next,
              size: 32,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
        ),
        itemBuilder: (index) => const WelcomeView(),
      ),
    );
  }
}