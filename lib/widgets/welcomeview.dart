import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/images/logo.png',
              width: 130,
            ),

            const SizedBox(height: 30),

             const Text(
              "Welcome to Appointments App\nYour Best Personal Physical Therapy Scheduler",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 155, 40, 40),
              ),
            ),
            const Spacer(flex: 2),
            const SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}