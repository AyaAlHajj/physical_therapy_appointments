import 'package:flutter/material.dart';
import 'package:physical_therapy_appointments/screens/dashboards/therapist_dashboard.dart';
import 'package:physical_therapy_appointments/db/therapy_storage.dart';
import 'package:physical_therapy_appointments/screens/dashboards/wounded_dashboard.dart';
import 'package:physical_therapy_appointments/screens/authentications/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password= _passwordController.text.trim();
    
    dynamic user = await loginUser(email, password);

    if (user != null) {
      final pref = await SharedPreferences.getInstance();
      await pref.setBool('isLoggedIn', true);
      await pref.setInt('userId', user.id);
      await pref.setString('email', user.email);

      String role = user.role ?? 'wounded';
      await pref.setString('role', role);

      if(role == 'therapist'){
        Navigator.push( 
          context, 
          MaterialPageRoute(
            builder: (ctx) =>  TherapistDashboard(therapistId: user.id!,),
          )
        );
      }
      
      else{
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (ctx) => WoundedDashboard(currentUserId: user.id!),
        )
      );
      }
    }
    
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid Username or Password!")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 155, 40, 40),
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: false, 
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 155, 40, 40),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),

              const SizedBox(height: 40),

              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ));
                },
                child: const Text(
                  "Don't have an account? SignUp",
                  style: TextStyle(color: Color.fromARGB(255, 96, 96, 96)),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}