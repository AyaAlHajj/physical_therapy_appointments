// import 'package:flutter/material.dart';
// import 'package:physical_therapy_appointments/database/database_storage.dart';
// import 'package:physical_therapy_appointments/models/appointment.dart';
// import 'package:physical_therapy_appointments/models/therapist.dart';
// import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
// import 'package:physical_therapy_appointments/widgets/book_screen_widgets/date_selector.dart';
// import 'package:physical_therapy_appointments/widgets/book_screen_widgets/therapist_dropdown.dart';
// import 'package:physical_therapy_appointments/widgets/book_screen_widgets/time_selector.dart';

// class EditAppointmentScreen extends StatefulWidget {
//   final Appointment appointment;

//   const EditAppointmentScreen({Key? key, required this.appointment})
//       : super(key: key);

//   @override
//   State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
// }

// class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
//   List<Therapist> therapists = [];
//   List<int> availableDates = [];
//   List<String> availableTimes = [];

//   Therapist? selectedTherapist;
//   int? selectedDate;
//   String? selectedTime;

//   bool isLoadingTherapists = true;
//   bool isLoadingDates = false;
//   bool isLoadingTimes = false;

//   @override
//   void initState() {
//     super.initState();
//     loadInitialData();
//   }

//   Future<void> loadInitialData() async {
//     therapists = await loadTherapists();

//     selectedTherapist =
//         therapists.firstWhere((t) => t.id == widget.appointment.therapistId);
//     selectedDate = widget.appointment.date;
//     selectedTime = widget.appointment.slotTime;

//     setState(() => isLoadingTherapists = false);

//     await onTherapistSelected(selectedTherapist!);
//     await onDateSelected(selectedDate!);
//   }

//   Future<void> onTherapistSelected(Therapist therapist) async {
//     setState(() {
//       selectedTherapist = therapist;
//       selectedDate = null;
//       selectedTime = null;
//       availableDates = [];
//       availableTimes = [];
//       isLoadingDates = true;
//     });

//     final slots = await loadSlotsByTherapist(therapist.id!);
//     final daysOfWeek = slots.map((s) => s.dayOfWeek).toSet();

//     DateTime today = DateTime.now();
//     List<int> dates = [];

//     for (int i = 0; i < 30; i++) {
//       DateTime date = today.add(Duration(days: i));
//       int weekday = date.weekday - 1;

//       if (daysOfWeek.contains(weekday)) {
//         dates.add(date.millisecondsSinceEpoch);
//       }
//     }

//     setState(() {
//       availableDates = dates;
//       isLoadingDates = false;
//     });
//   }

//   Future<void> onDateSelected(int dateMillis) async {
//     setState(() {
//       selectedDate = dateMillis;
//       selectedTime = null;
//       availableTimes = [];
//       isLoadingTimes = true;
//     });

//     final weekday =
//         DateTime.fromMillisecondsSinceEpoch(dateMillis).weekday - 1;

//     final slots =
//         await loadSlotsByDay(selectedTherapist!.id!, weekday);

//     final allTimes = slots.map((s) => s.slotTime).toList();

//     final dateString = DateTime.fromMillisecondsSinceEpoch(dateMillis)
//         .toIso8601String()
//         .split('T')[0];

//     final bookedAppointments =
//         await getAppointmentsByTherapistAndDate(
//       selectedTherapist!.id!,
//       dateString,
//     );

//     final bookedTimes =
//         bookedAppointments.map((a) => a.slotTime).toList();

//     setState(() {
//       availableTimes =
//           allTimes.where((t) => !bookedTimes.contains(t)).toList();
//       isLoadingTimes = false;
//     });
//   }

//   Future<void> updateAppointment() async {
//     Appointment updated = Appointment(
//       id: widget.appointment.id,
//       woundedId: widget.appointment.woundedId,
//       therapistId: selectedTherapist!.id!,
//       date: selectedDate!,
//       slotTime: selectedTime!,
//     );

//     await updateAppointmentById(updated);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Appointment updated successfully'),
//         backgroundColor: Colors.green,
//       ),
//     );

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE8EAF6),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 116, 150, 142),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Edit Appointment',
//           style: TextStyle(
//               color: Color.fromARGB(255, 155, 40, 40), fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),

//             const Text('Choose Therapist:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             isLoadingTherapists
//                 ? const Center(child: CircularProgressIndicator())
//                 : TherapistDropdown(
//                     therapists: therapists,
//                     selectedTherapist: selectedTherapist,
//                     onTherapistSelected: onTherapistSelected,
//                   ),

//             const SizedBox(height: 30),
//             const Text('Choose Date:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             isLoadingDates
//                 ? const Center(child: CircularProgressIndicator())
//                 : DateSelector(
//                     availableDates: availableDates,
//                     selectedDate: selectedDate,
//                     onDateSelected: onDateSelected,
//                   ),

//             const SizedBox(height: 30),
//             const Text('Choose Time:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             isLoadingTimes
//                 ? const Center(child: CircularProgressIndicator())
//                 : TimeSelector(
//                     availableTimes: availableTimes,
//                     selectedTime: selectedTime,
//                     onTimeSelected: (value) {
//                       setState(() => selectedTime = value);
//                     },
//                   ),

//             const SizedBox(height: 40),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: updateAppointment,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       const Color.fromARGB(255, 116, 150, 142),
//                   padding: const EdgeInsets.symmetric(vertical: 18),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 child: const Text(
//                   'Save Changes',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 155, 40, 40),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const BottomNav(currentIndex: 1),
//     );
//   }
// }
