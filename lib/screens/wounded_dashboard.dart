import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/home.dart';

class WondedDashboard extends StatefulWidget {
  const WondedDashboard({super.key});

  @override
  State<WondedDashboard> createState() => _WondedDashboardState();
}

class _WondedDashboardState extends State<WondedDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wounded Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 155, 40, 40),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 116, 150, 142),
              ),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      
      body: const Center(
        child: Text('Welcome to the Wounded Dashboard!'),
      )
    );
  }
}