import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final result = await _googleSignIn.signIn();
      if (result != null) {
        // Redirect ke halaman dashboard jika login berhasil
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (error) {
      print('Error during sign-in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleSignIn,
              child: Text('Sign in with Google'),
            ),
            SizedBox(height: 20),
            Text(
              'Or Login with Username & Password',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logika login manual bisa ditambahkan di sini
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
