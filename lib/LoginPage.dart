import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Lógica de inicio de sesión con Firebase
              await _auth.signInAnonymously();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            } catch (e) {
              print('Error de inicio de sesión: $e');
            }
          },
          child: const Text('Iniciar Sesión con Firebase'),
        ),
      ),
    );
  }
}
