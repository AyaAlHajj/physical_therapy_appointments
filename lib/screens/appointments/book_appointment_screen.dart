import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/models/appointment.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';
import 'package:physical_therapy_appointments/widgets/book_screen_widgets/date_selector.dart';
import 'package:physical_therapy_appointments/widgets/book_screen_widgets/therapist_dropdown.dart';
import 'package:physical_therapy_appointments/widgets/book_screen_widgets/time_selector.dart';

class BookAppointmentScreen extends StatefulWidget {
  final int currentUserId;
  const BookAppointmentScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  List<Therapist> therapists = [];
  List<int> availableDates = [];
  List<String> availableTimes = [];

  Therapist? selectedTherapist;
  int? selectedDate;
  String? selectedTime;

  bool isLoadingTherapists = true;
  bool isLoadingDates = false;
  bool isLoadingTimes = false;

  @override
  void initState() {
    super.initState();
    loadedTherapists();
  }

  Future<void> loadedTherapists() async {
    final data = await loadTherapists();
    setState(() {
      therapists = data;
      isLoadingTherapists = false;
    });
  }

  Future<void> onTherapistSelected(Therapist therapist) async {
    setState(() {
      selectedTherapist = therapist;
      selectedDate = null;
      selectedTime = null;
      availableDates = [];
      availableTimes = [];
      isLoadingDates = true;
    });

    final slots = await loadSlotsByTherapist(therapist.id!);
    final daysOfWeek = slots.map((s) => s.dayOfWeek).toSet();
    List<int> dates = [];
    DateTime today = DateTime.now();

    for (int i = 0; i < 30; i++) {
      DateTime date = today.add(Duration(days: i));
      int dayOfWeek = date.weekday - 1;

      if (daysOfWeek.contains(dayOfWeek)) {
        String datestr =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        dates.add(date.millisecondsSinceEpoch);
      }
    }
    setState(() {
      availableDates = dates;
      isLoadingDates = false;
    });
  }

  Future<void> onDateSelected(int dateMillis) async {
    setState(() {
      selectedDate = dateMillis;
      selectedTime = null;
      availableTimes = [];
      isLoadingTimes = true;
    });

    final dateTime = DateTime.fromMillisecondsSinceEpoch(dateMillis);
    final weekday = dateTime.weekday - 1;
    final slots = await loadSlotsByDay(selectedTherapist!.id!, weekday);

    List<String> allTimes = slots.map((slot) => slot.slotTime).toList();
    final dateString = DateTime.fromMillisecondsSinceEpoch(dateMillis)
        .toIso8601String()
        .split('T')[0];
    List<Appointment> bookedAppointments =
        await getAppointmentsByTherapistAndDate(
      selectedTherapist!.id!,
      dateString,
    );

    List<String> bookedTimes =
        bookedAppointments.map((apt) => apt.slotTime).toList();

    List<String> available =
        allTimes.where((time) => !bookedTimes.contains(time)).toList();

    setState(() {
      availableTimes = available;
      isLoadingTimes = false;
    });
  }

  Future<void> bookAppointment() async {
    if (selectedTherapist == null ||
        selectedDate == null ||
        selectedTime == null ||
        selectedTherapist!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select therapist, date, and time')
            ),
      );
      return;
    }
    final int dateTimestamp = selectedDate!;
    //  DateTime.parse(selectedDate!).microsecondsSinceEpoch;
    try{
    Appointment newAppointment = Appointment(
      woundedId: widget.currentUserId,
      therapistId: selectedTherapist!.id!,
      date: dateTimestamp,
      slotTime: selectedTime!,
    );

    insertAppointment(newAppointment);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment booked successfully!'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );

    Navigator.pop(context);
  }
  catch(e){
    print("CRASH PREVENTED: $e");
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
          'Book Appointment',
          style:
              TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // Select Therapist
            const Text('Choose Therapist:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            isLoadingTherapists
                ? const Center(child: CircularProgressIndicator())
                : TherapistDropdown(
                    therapists: therapists,
                    selectedTherapist: selectedTherapist,
                    onTherapistSelected: onTherapistSelected,
                  ),

            //Select date:
            const SizedBox(height: 30),
            const Text('Choose Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (selectedTherapist == null)
              const Text('Please select a therapist first',
                  style: TextStyle(color: Colors.grey))
            else if (isLoadingDates)
              const Center(child: CircularProgressIndicator())
            else if (availableDates.isEmpty)
              const Text('No available dates',
                  style: TextStyle(color: Colors.red))
            else
              DateSelector(
                  availableDates: availableDates,
                  selectedDate: selectedDate,
                  onDateSelected: onDateSelected),

            ///Select Time:
            const SizedBox(height: 30),
            const Text('Choose Time:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (selectedDate == null)
              const Text('Please select a date first',
                  style: TextStyle(color: Colors.grey))
            else if (isLoadingTimes)
              const Center(child: CircularProgressIndicator())
            else if (availableTimes.isEmpty)
              const Text('No available times',
                  style: TextStyle(color: Colors.red))
            else
              TimeSelector(
                  availableTimes: availableTimes,
                  selectedTime: selectedTime,
                  onTimeSelected: (value) {
                    setState(() {
                      selectedTime = value;
                    });
                  }),

            const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 116, 150, 142),
                      ),
                      onPressed: () => Navigator.pop(context), 
                      child: const Text(
                        'Cancel', 
                        style: TextStyle(
                          color: Colors.white
                          ),
                          ),
                    ),

                    const SizedBox(width: 10,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 116, 150, 142),
                        disabledBackgroundColor: const Color.fromARGB(255, 116, 150, 142),
                      ),
                      onPressed: (selectedTherapist != null &&
                              selectedDate != null &&
                              selectedTime != null)
                          ? bookAppointment
                          : null,
                      child: const Text(
                        'Book',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  } 
}
