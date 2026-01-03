import 'package:flutter/material.dart';

class AppointmentActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const AppointmentActionButtons({
    Key? key,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          // delete :
          child: OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 18,
            ),
            label: const Text('Delete', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        
        // Edit :
        // Expanded(
        //   child: ElevatedButton.icon(
        //     onPressed: () {
        //       Navigator.pushNamed(
        //         context,
        //         '/edit-appointment',
        //         arguments: appointment!.id,
        //       );
            
            // MaterialPageRoute(
            //   builder: (context) => EditAppointmentScreen(
            //     appointmentId: appointment!.id!,
            //     currentUserId: widget.currentUserId,
            //     ),
            //   ),
            // ).then((_) {
            //   // Refresh data when coming back from edit
            //   loadAppointmentDetails();
            //   });
            // },
            const SizedBox(width: 15),
            Expanded(
              child:ElevatedButton.icon(
                onPressed: onEdit,      
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 116, 150, 142),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
