import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';

class AppointmentListItem extends StatelessWidget {
  final Appointment appointment;
  final Therapist? therapist;
  final String? patientName;
  final VoidCallback onTap;
  final String formattedDate;

  const AppointmentListItem(
      {super.key,
      required this.appointment,
     this.therapist,
      this.patientName,
      required this.onTap,
      required this.formattedDate});

  @override
  Widget build(BuildContext context) {
   
   String titleLabel = "";
    String displayName = "";

    if (patientName != null) {
      titleLabel = "Wounded Name: ";
      displayName = patientName!;
    } else {
      titleLabel = ""; 
      displayName = therapist != null ? 'Dr. ${therapist!.firstname}' : 'Dr. Therapist';
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                  children: [
                    if(titleLabel.isNotEmpty)
                    Text(
                      titleLabel,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                 ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color.fromARGB(255, 155, 40, 40),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          formatDate(appointment.date),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Color.fromARGB(255, 155, 40, 40),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          appointment.slotTime,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDate(int dateMillis) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
  return '${date.day}/${date.month}/${date.year}';
}
