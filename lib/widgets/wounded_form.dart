import 'package:flutter/material.dart';

class WoundedForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController surnameController;

  const WoundedForm({
    required this.emailController, 
    required this.passwordController, 
    required this.firstNameController,
    required this.surnameController,
    super.key
  });

  @override
  State<WoundedForm> createState() => _WoundedFormState();
}

class _WoundedFormState extends State<WoundedForm> {
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