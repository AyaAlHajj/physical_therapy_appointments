import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/screens/appointments/view_appointment_screen.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/main_drawer.dart';

class TherapistDashboard extends StatefulWidget {
  final int therapistId;
  const TherapistDashboard({Key? key, required this.therapistId})
      : super(key: key);

  @override
  State<TherapistDashboard> createState() => _TherapistDashboardState();
}

class _TherapistDashboardState extends State<TherapistDashboard> {
  List<Appointment> therapistAppointment = [];
  Map<int, Wounded> woundedCache = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    List<Appointment> fetched =
        await loadAppointmentsByTherapist(widget.therapistId);

    for (var appt in fetched) {
      if (!woundedCache.containsKey(appt.woundedId)) {
        Wounded? wounded = await getWoundedById(appt.woundedId);
        if (wounded != null) {
          woundedCache[appt.woundedId] = wounded;
        }
      }
    }

    setState(() {
      therapistAppointment = fetched;
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
        
        title: const Text(
          "Your Appointments",

          style: TextStyle(
            color: Colors.white, 
            fontSize: 20
            ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : therapistAppointment.isEmpty
                    ? const Center(
                        child: Text(
                          "No appointments Yet",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: therapistAppointment.length,
                        itemBuilder: (context, index) {

                          final appointment = therapistAppointment[index];

                          final wounded = woundedCache[appointment.woundedId];

                          String woundedFullName = wounded != null
                          ?  "${wounded.firstname} ${wounded.surname}"
                          : "Unkown Wounded";
                          
                          return AppointmentListItem(
                            appointment: appointment,
                            woundedName: woundedFullName,
                            formattedDate: formatDate(appointment.date),
                            onTap: () {},
                          );
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }
}