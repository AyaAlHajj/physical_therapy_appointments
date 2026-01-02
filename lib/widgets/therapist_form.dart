import 'package:flutter/material.dart';

class TherapistForm extends StatefulWidget{
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController surnameController;
  final TextEditingController phoneController;
  final TextEditingController infoController;

  const TherapistForm({
    required this.emailController, 
    required this.passwordController, 
    required this.firstNameController,
    required this.surnameController,
    required this.phoneController,
    required this.infoController, 
    super.key
  });

  @override
  State<TherapistForm> createState() => _TherapistFormState();
}

class _TherapistFormState extends State<TherapistForm>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget.firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: widget.surnameController,
              decoration: const InputDecoration(labelText: 'Surname'),
            ),
            TextField(
              controller: widget.phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: widget.infoController,
              decoration: const InputDecoration(labelText: 'Info'),
            ),
            TextField(
              controller: widget.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: widget.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }
}