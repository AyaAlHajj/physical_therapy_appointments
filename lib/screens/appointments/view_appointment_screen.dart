import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 40, 40),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, 
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'View an Appointment',
          style:
              TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      //body: isLoading
        //  ? const Center(child: CircularProgressIndicator())
          //: appointment == null
            //  ? const Center(child: Text('Appointment not found'))
              //: AppointmentDetailsView(handleDelete: handleDelete, handleEdit: ,),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
    
}
