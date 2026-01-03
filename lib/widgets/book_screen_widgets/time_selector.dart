import 'package:flutter/material.dart';

class TimeSelector extends StatelessWidget {
  final List<String> availableTimes;
  final String? selectedTime;
  final Function(String) onTimeSelected;
  const TimeSelector({
    Key? key,
    required this.availableTimes,
    required this.selectedTime,
    required this.onTimeSelected,
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
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedTime,
          hint: const Row(
            children: [
              Icon(Icons.access_time, color: Color.fromARGB(255, 155, 40, 40),),
              SizedBox(width: 12),
              Text('Select a time', style: TextStyle(fontSize: 16)),
            ],
          ),
          items: availableTimes.map((time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Row(
                children: [
                  const Icon(Icons.access_time,
                      color: Color.fromARGB(255, 155, 40, 40), size: 20),
                  const SizedBox(width: 12),
                  Text(time, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onTimeSelected(value);
            }
          },
        ),
      ),
    );
  }
}
