import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/widgets/therapist_form.dart';
import 'package:physical_therapy_appointments/widgets/wounded_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int selectedOption = 1;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _checkEmptyFields(){
    if(_firstNameController.text.isEmpty ||
       _surnameController.text.isEmpty ||
       _emailController.text.isEmpty ||
       _passwordController.text.isEmpty){
        return false;
       }

    if(selectedOption == 1){
      if(_phoneController.text.isEmpty ||
         _infoController.text.isEmpty){
          return false;
         }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),

      body: SingleChildScrollView(
        child: Column(
            children: [
            const Text('Who are you?'),

            ListTile(
              title: const Text('Therapist'),
              leading: Radio(
                value: 1, 
                groupValue: selectedOption, 
                onChanged: (value){
                  setState(() {
                    selectedOption = value!;
                    });
                },
              ),
            ),

            ListTile(
              title: const Text('Wounded'),
              leading: Radio(
                value: 2, 
                groupValue: selectedOption, 
                onChanged: (value){
                  setState(() {
                    selectedOption = value!;
                    });
                },
              ),
            ),

            if(selectedOption == 1)
              TherapistForm(
                emailController: _emailController,
                passwordController: _passwordController,
                firstNameController: _firstNameController,
                surnameController: _surnameController,
                phoneController: _phoneController,
                infoController: _infoController,
              )
            else
              WoundedForm(
                emailController: _emailController,
                passwordController: _passwordController,
                firstNameController: _firstNameController,
                surnameController: _surnameController,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  if(!_checkEmptyFields()){
                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill all the fields'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), 
                            child: const Text('Close')
                          )
                        ],
                      )
                    );
                    return;
                  }
                  
                  signUP(
                    firstname:  _firstNameController.text,
                    surname:  _surnameController.text,
                    email:  _emailController.text,
                    password:  _passwordController.text,
                    phone: selectedOption == 1 ? _phoneController.text : null,
                    info: selectedOption == 1 ? _infoController.text : null,
                    role: selectedOption == 1 ? 'therapist' : 'wounded',
                  ).then((result) {
                      if(result == 'success' && selectedOption == 2){
                        Navigator.pop(context);
                      Navigator.pushNamed(context, '/wounded_dashboard');
                    }

                    else if(result == 'success' && selectedOption == 1){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/therapist_dashboard');
                    }
                    
                    else {
                        showDialog(
                          context: context, 
                        builder: (context) => AlertDialog(
                            title: const Text('Error'),
                          content: Text(result),
                          actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context), 
                              child: const Text('Close')
                            )
                          ],
                        )
                      );
                    }
                  });
                
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 116, 150, 142),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),
            ],
        ),
      ),
    );
  }
}