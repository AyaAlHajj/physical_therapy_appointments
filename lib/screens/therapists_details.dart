import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/models/therapist.dart';
import 'package:physical_therapy_appointments/widgets/bottom_nav.dart';

class TherapistDetailsScreen extends StatelessWidget {
  final List<Therapist> therapists;

  const TherapistDetailsScreen({Key? key, required this.therapists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          'Thrapist Details',
          style:
              TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),

      body: therapists.isEmpty ? const Center(child: Text("No Therapists Available"),)
      : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: therapists.length,
        itemBuilder: (context, index) {

          final therapist = therapists[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),

        child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                        '${therapist.firstname} ${therapist.surname}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8,),

                  const Text(
                    "About Therapist:",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                        
                  const SizedBox(height: 8),
                  
                  Text(
                    therapist.info,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),

          ),
        );
        }
        ),
      

      bottomNavigationBar: BottomNav(currentIndex: 1, therapists: therapists),
    );
  }
}