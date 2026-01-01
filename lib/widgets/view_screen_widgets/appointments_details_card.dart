import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/detail_row.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/detail_row_with_icon.dart';

class AppointmentsDetailsCard extends StatelessWidget {
  final String woundedName;
  final String therapistName;
  final String date;
  final String time;
  const AppointmentsDetailsCard({
    Key? key,
    required this.woundedName,
    required this.therapistName,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'Wounded Name: ', value: woundedName),
          const Divider(height: 30),
          DetailRowWithIcon(
            icon: Icons.calendar_today,
            label: 'Date:',
            value: date,
          ),
          const Divider(height: 30),
          DetailRowWithIcon(
            icon: Icons.person,
            label: 'Therapist:',
            value: therapistName,
          ),
          const Divider(height: 30),
          DetailRowWithIcon(
            icon: Icons.access_time,
            label: 'Time:',
            value: time,
          ),
        ],
      ),
    );
  }
}
