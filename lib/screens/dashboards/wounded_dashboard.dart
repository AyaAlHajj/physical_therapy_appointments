import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/screens/appointments/book_appointment_screen.dart';
import 'package:physical_therapy_appointments/screens/appointments/view_appointment_screen.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/main_drawer.dart';

class WoundedDashboard extends StatefulWidget{
  final int currentUserId;
  const WoundedDashboard({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  State<WoundedDashboard> createState() => _WoundedDashboardState();
}

class _WoundedDashboardState extends State<WoundedDashboard> {
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
      backgroundColor: Colors.grey[200],

      drawer: const MainDrawer(),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 40, 40),
        iconTheme: const IconThemeData(color: Colors.white),
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
                          
                          return Dismissible(
                            key: ValueKey(appointment.id),
                            direction: DismissDirection.endToStart,

                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              color: const Color.fromARGB(255, 155, 40, 40),
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (direction) async{
                              return await showDialog(
                                context: context, 
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Appointment'),
                                  content: const Text(
                                    'Are you sure you want to delete this appointment?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Cancel',
                                        style: TextStyle(color: Color.fromARGB(255, 116, 150, 142))
                                        ),
                                      ),
                                      
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('Delete',
                                        style: TextStyle(color: Color.fromARGB(255, 155, 40, 40))
                                        ),
                                      ),
                                    ],
                                ),
                              );
                            },

                            onDismissed: (direction) async{
                              final idToDelete = appointment.id;

                              if(idToDelete !=null){
                                await deleteAppointment(idToDelete);

                                setState(() {
                                  appointments.removeAt(index);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Appointment deleted successfully'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: AppointmentListItem(
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
                                      
                                    loadAppointmentsData();
                              },
                            ),
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

