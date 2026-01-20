import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/dashboards/therapist_dashboard.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/screens/dashboards/wounded_dashboard.dart';
import 'package:physical_therapy_appointments/widgets/forms/therapist_form.dart';
import 'package:physical_therapy_appointments/widgets/forms/wounded_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: const Color.fromARGB(255, 155, 40, 40),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Sign Up",
          style:
              TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
            children: [
            ListTile(
              title: const Text('Therapist'),
              leading: Radio(
                activeColor: const Color.fromARGB(255, 116, 150, 142),
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
                activeColor: const Color.fromARGB(255, 116, 150, 142),
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

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async{
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

                  var result = await signUP(
                    firstname:  _firstNameController.text,
                    surname:  _surnameController.text,
                    email:  _emailController.text,
                    password:  _passwordController.text,
                    phone: selectedOption == 1 ? _phoneController.text : null,
                    info: selectedOption == 1 ? _infoController.text : null,
                    role: selectedOption == 1 ? 'therapist' : 'wounded',
                  );

                  if(result is int){
                    final pref = await SharedPreferences.getInstance();
                    await pref.setBool('isLoggedIn', true);
                    await pref.setString('email', _emailController.text);
                    String role = selectedOption == 1 ? 'therapist' : 'wounded';
                    await pref.setString('role', role);
                    await pref.setInt('userId', result);

                    if(selectedOption == 1){
                      await pref.setInt('therapistId', result);
                      await therapistSchedule(result);

                      Navigator.push( 
                        context, 
                        MaterialPageRoute(
                          builder: (ctx) =>  TherapistDashboard(therapistId: result,),
                        )
                      );
                    }

                    else{
                      await pref.setInt('woundedId', result);

                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (ctx) => WoundedDashboard(currentUserId: result),
                        )
                      );
                    }
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
                  
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 155, 40, 40),
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