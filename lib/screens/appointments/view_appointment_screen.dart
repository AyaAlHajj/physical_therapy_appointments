import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/screens/appointments/edit_appointment.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/view_screen_widgets/appointment_details_view.dart';

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
                  child: const Text('Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 116, 150, 142))),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete',
                        style: TextStyle(color: Color.fromARGB(255, 155, 40, 40)))),
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
      backgroundColor: Colors.grey[200],
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
      
      body: isLoading
         ? const Center(child: CircularProgressIndicator())
          : appointment == null
             ? const Center(child: Text('Appointment not found'))
              : AppointmentDetailsView(
                appointment:appointment!,
                wounded :wounded!,
                therapist:therapist!,
                handleDelete: handleDelete,
                handleEdit:() async {
                  final result = await Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => EditAppointmentScreen(
                                      appointment: appointment!
                                      ),
                                    ),
                  );
                

              if(result == true){
                await loadAppointmentsDetails();
              }
      
              } ,
                ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
    
}
