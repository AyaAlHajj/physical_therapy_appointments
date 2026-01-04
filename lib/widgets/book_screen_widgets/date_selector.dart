import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/widgets/appointment_list_item.dart';

class DateSelector extends StatelessWidget {
  final List<int> availableDates;
  final int? selectedDate;
  final Function(int) onDateSelected;
  const DateSelector({
    Key? key,
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
       
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: availableDates.contains(selectedDate) ? selectedDate : null,
          hint: const Row(
            children: [
              Icon(Icons.calendar_today, color: Color.fromARGB(255, 155, 40, 40),),
              SizedBox(width: 12),
              Text('Select a date', style: TextStyle(fontSize: 16)),
            ],
          ),
          items: availableDates.map((date) {
            return DropdownMenuItem<int>(
              value: date,
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,color: 
                     Color.fromARGB(255, 155, 40, 40), size: 20),
                  const SizedBox(width: 12),
                  Text(formatDate(date), style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onDateSelected(value);
            }
          },
        ),
      ),
    );
  }
}

