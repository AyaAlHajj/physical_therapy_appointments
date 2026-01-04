import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';

class TherapistDropdown extends StatelessWidget {
  final List<Therapist> therapists;
  final Therapist? selectedTherapist;
  final Function(Therapist) onTherapistSelected;
  const TherapistDropdown({
    Key? key,
    required this.therapists,
    required this.selectedTherapist,
    required this.onTherapistSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<Therapist>(
            isExpanded: true,
            value: selectedTherapist,
            hint: const Row(
              children: [
                Icon(Icons.person_outline, color: Color.fromARGB(255, 155, 40, 40)),
                SizedBox(width: 12),
                Text('Select a therapist'),
              ],
            ),

            items: therapists.map((therapist) {
              return DropdownMenuItem<Therapist>(
                value: therapist,
                child: Text('Dr. ${therapist.firstname} ${therapist.surname}'),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onTherapistSelected(value);
              }
            }),
      ),
    );
  }
}
