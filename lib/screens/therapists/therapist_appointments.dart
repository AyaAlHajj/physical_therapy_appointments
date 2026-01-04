import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/wounded.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';

class TherapistAppointments extends StatefulWidget {
  final int therapistId;
  const TherapistAppointments({Key? key, required this.therapistId})
      : super(key: key);

  @override
  State<TherapistAppointments> createState() => _TherapistAppointmentsState();
}

class _TherapistAppointmentsState extends State<TherapistAppointments> {
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
        Wounded? patient = await getWoundedById(appt.woundedId);
        if (patient != null) {
          woundedCache[appt.woundedId] = patient;
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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF74968E),
        elevation: 0,
        centerTitle: true,
        title: const Text("My Appointments",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: therapistAppointment.length,
              itemBuilder: (context, index) {
                final appointment = therapistAppointment[index];
                final patient = woundedCache[appointment.woundedId];
                String patientName = patient != null
                    ? '${patient.firstname} ${patient.surname}'
                    : 'loading patient..';
                return AppointmentListItem(
                    appointment: appointment,
                    patientName: patientName,
                    formattedDate: _formatDate(appointment.date),
                    onTap: () {});
              },
            ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}

String _formatDate(int millis) {
  DateTime d = DateTime.fromMillisecondsSinceEpoch(millis);
  return "${d.day}/${d.month}/${d.year}";
}
