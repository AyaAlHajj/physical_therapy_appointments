import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/screens/appointments/book_appointment_screen.dart';
import 'package:physical_therapy_appointments/screens/appointments/view_appointment_screen.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/main_drawer.dart';

class AppointmentListScreen extends StatefulWidget {
  // static const bool useTestData = true;
  final int currentUserId;
  const AppointmentListScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  List<Appointment> appointments = [];
  Map<int, Therapist> therapistsCache = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAppointmentsData();
  }

  Future<void> loadAppointmentsData() async {
    List<Appointment> loadAppointments =
        await loadAppointmentsByWounded(widget.currentUserId);
    for (var appointment in loadAppointments) {
      if (!therapistsCache.containsKey(appointment.therapistId)) {
        Therapist? therapist = await getTherapistbyId(appointment.therapistId);
        if (therapist != null) {
          therapistsCache[appointment.therapistId] = therapist;
        }
      }
    }
    setState(() {
      appointments = loadAppointments;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: const MainDrawer(),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 40, 40),
        
        title: const Text(
          "Your Appointments",
          style:
              TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : appointments.isEmpty
                    ? const Center(
                        child: Text(
                          "No appointments Yet",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {

                          final appointment = appointments[index];

                          final therapist = therapistsCache[appointment.therapistId];
                          
                          return AppointmentListItem(
                            appointment: appointment,
                            therapist: therapist,
                            formattedDate: formatDate(appointment.date),
                            onTap: () async{
                              final result = await Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ViewAppointmentScreen(
                                      appointmentId: appointment.id!
                                      ),
                                    ),
                                    );

                                    if(result == true){
                                      loadAppointmentsData();
                                    }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      // book appointment icon(+):
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookAppointmentScreen(
                currentUserId: widget.currentUserId,
              ),
            ),
          ).then((_) {
            loadAppointmentsData();
          });
        },
        backgroundColor: const Color.fromARGB(255, 155, 40, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
  }

