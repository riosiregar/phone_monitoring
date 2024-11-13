import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _countryCode = "+62";
  bool _isPhoneInput = true;
  bool _isVerificationStep = false;
  bool _isOtpVerificationStep = false;

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        // Berhasil login dengan Google, arahkan ke dashboard
        Navigator.pushNamed(context, '/dashboard');
      }
    } catch (e) {
      _showLoginFailedDialog("Google Sign-In failed: $e");
    }
  }

  Future<void> _verifyPhoneNumber() async {
    // Simulasi validasi OTP SMS
    setState(() {
      _isOtpVerificationStep = true;
    });
  }

  Future<void> _verifyEmail() async {
    // Simulasi pengiriman OTP ke email
    setState(() {
      _isOtpVerificationStep = true;
    });
  }

  void _handleNext() {
    if (_isPhoneInput && _phoneController.text.isNotEmpty) {
      setState(() {
        _isPhoneInput = false;
      });
    } else if (!_isPhoneInput && _emailOrPhoneController.text.isNotEmpty) {
      if (_emailOrPhoneController.text.contains('@')) {
        _verifyEmail();
      } else {
        _verifyPhoneNumber();
      }
    } else {
      _showLoginFailedDialog("Please fill in the required field.");
    }
  }

  void _verifyOtp() {
    if (_otpController.text == "123456") {
      // Ganti dengan validasi OTP sebenarnya
      Navigator.pushNamed(context, '/dashboard');
    } else {
      _showLoginFailedDialog("Invalid OTP, please try again.");
    }
  }

  void _showLoginFailedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            if (_isPhoneInput)
              Row(
                children: [
                  DropdownButton<String>(
                    value: _countryCode,
                    items: ["+1", "+62", "+44", "+91"].map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(
                          code,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newCode) {
                      setState(() {
                        _countryCode = newCode!;
                      });
                    },
                    dropdownColor: Colors.grey[800],
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (!_isOtpVerificationStep)
              TextField(
                controller: _emailOrPhoneController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email or Phone Number',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              )
            else
              TextField(
                controller: _otpController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isOtpVerificationStep ? _verifyOtp : _handleNext,
              child: Text(_isOtpVerificationStep ? 'Verify OTP' : 'Next'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign In with Google'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
            SizedBox(height: 20),
            buildForogotPassBtn(),
            buildSignUpBtn(),
          ],
        ),
      ),
    );
  }

  Widget buildForogotPassBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/forgot');
            },
            child: const Text(
              " Forgot Password?",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSignUpBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Don't have an account?",
              style: TextStyle(color: Colors.white70)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              " Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
