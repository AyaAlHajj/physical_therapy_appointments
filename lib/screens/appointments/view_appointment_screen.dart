import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/database/database_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/appointment_action_buttons.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/appointments_details_card.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/detail_row.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/detail_row_with_icon.dart';

class ViewAppointmentScreen extends StatefulWidget {
  final int appointmentId;
  const ViewAppointmentScreen({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<ViewAppointmentScreen> createState() => _ViewAppointmentScreenState();
}

class _ViewAppointmentScreenState extends State<ViewAppointmentScreen> {
  Appointment? appointment;
  Wounded? wounded;
  Therapist? therapist;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAppointmentsDetails();
  }

  Future<void> loadAppointmentsDetails() async {
    Appointment? loadedAppointment =
        await getAppointmentById(widget.appointmentId);
    if (loadedAppointment != null) {
      Wounded? loadedWounded =
          await getWoundedById(loadedAppointment.woundedId);
      Therapist? loadedTherapist =
          await getTherapistbyId(loadedAppointment.therapistId);

      setState(() {
        appointment = loadedAppointment;
        wounded = loadedWounded;
        therapist = loadedTherapist;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // to delete an appointment :
  Future<void> handleDelete() async {
    bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Appointment'),
              content: const Text(
                  'Are you sure you want to delete this appointment?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red))),
              ],
            ));
    if (confirm == true) {
      await deleteAppointment(widget.appointmentId);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 150, 142),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'View an Appointment',
          style:
              TextStyle(color: Color.fromARGB(255, 155, 40, 40), fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : appointment == null
              ? const Center(child: Text('Appointment not found'))
              : buildAppointmentDetails(),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  Widget buildAppointmentDetails() {
    String woundedName = wounded != null
        ? '${wounded!.firstname} ${wounded!.surname}'
        : 'Unkown';

    String therapistName = therapist != null
        ? 'Dr. ${therapist!.firstname} ${therapist!.surname}'
        : 'Unknown';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          AppointmentsDetailsCard(
            woundedName: woundedName,
            therapistName: therapistName,
            date: formatDate(appointment!.date),
            time: appointment!.slotTime,
          ),
          const SizedBox(width: 30),
          AppointmentActionButtons(
            onDelete: handleDelete,
            onEdit: () {
              Navigator.pushNamed(
                context,
                '/edit-appointment',
                arguments: appointment!.id,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  String formatDate(int dateMillis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateMillis);
    return '${date.day}/${date.month}/${date.year}';
  }
}
