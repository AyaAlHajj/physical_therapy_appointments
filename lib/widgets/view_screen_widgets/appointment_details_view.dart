import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/appointments_details_card.dart';

class AppointmentDetailsView extends StatelessWidget {
  final Appointment appointment;
  final Wounded wounded;
  final Therapist therapist;
  final VoidCallback handleDelete;
  final VoidCallback handleEdit;


  const AppointmentDetailsView({
    super.key, 
    required this.appointment, 
    required this.wounded,
    required this.therapist,
    required this.handleDelete,
    required this.handleEdit
  });

  @override
  Widget build(BuildContext context) {
    String woundedName = '${wounded.firstname} ${wounded.surname}';

    String therapistName = 'Dr. ${therapist.firstname} ${therapist.surname}';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 20),

          AppointmentsDetailsCard(
            woundedName: woundedName,
            therapistName: therapistName,
            date: formatDate(appointment.date),
            time: appointment.slotTime,
          ),

          const SizedBox(height: 30),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: handleEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: handleDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}