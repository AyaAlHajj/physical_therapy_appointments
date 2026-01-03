import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool showToday = true;

  final List<DateTime> demoDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 3)),
  ];

  final List<String> demoDoctors = [
    'Dr. Sameer',
    'Dr. Mazen',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EAF6),
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabButton("Today's", showToday, () {
                  setState(() => showToday = true);
                }),
                const SizedBox(width: 12),
                _tabButton("Upcoming", !showToday, () {
                  setState(() => showToday = false);
                }),
              ],
            ),

            const SizedBox(height: 20),

            /// Appointment cards
            Expanded(
              child: ListView.builder(
                itemCount: demoDates.length,
                itemBuilder: (context, index) {
                  final date = demoDates[index];
                  final doctor = demoDoctors[index];

                  return _appointmentCard(doctor, date);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.teal : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _appointmentCard(String doctorName, DateTime date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctorName,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Day: ${DateFormat('EEEE').format(date)}'),
          Text('Date: ${DateFormat('dd/MM/yyyy').format(date)}'),
        ],
      ),
    );
  }
}
