import 'package:again1/ui/auth/verify_code.dart';
import 'package:again1/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loginLoading = false;
  bool createAccountLoading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  // Regex pattern for phone number validation
  final RegExp phoneNumberRegex = RegExp(r'^\+\d{1,3}\s\d{3}\s\d{7,10}$');

  void _validateAndSubmit(bool isLogin) {
    final phoneNumber = phoneNumberController.text;

    if (phoneNumber.isEmpty) {
      Utils().toastMessage('Please enter your phone number.');
      return;
    }

    if (!phoneNumberRegex.hasMatch(phoneNumber)) {
      Utils().toastMessage('Please enter a valid phone number.');
      return;
    }

    setState(() {
      if (isLogin) {
        loginLoading = true;
      } else {
        createAccountLoading = true;
      }
    });

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {
        setState(() {
          if (isLogin) {
            loginLoading = false;
          } else {
            createAccountLoading = false;
          }
        });
      },
      verificationFailed: (e) {
        setState(() {
          if (isLogin) {
            loginLoading = false;
          } else {
            createAccountLoading = false;
          }
        });
        Utils().toastMessage(e.toString());
      },
      codeSent: (String verificationId, int? token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(verificationId: verificationId),
          ),
        );
        setState(() {
          if (isLogin) {
            loginLoading = false;
          } else {
            createAccountLoading = false;
          }
        });
      },
      codeAutoRetrievalTimeout: (e) {
        setState(() {
          if (isLogin) {
            loginLoading = false;
          } else {
            createAccountLoading = false;
          }
        });
        Utils().toastMessage(e.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Login via phone',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                color: Color(0xFF345567),  // Set the background color here
                padding: const EdgeInsets.all(10),  // Add padding inside the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Note:\nYou can create an account or log in using your phone number. Just enter your phone number and click on "Login" or "Create Account." You will then receive an OTP message. Enter the verification code to finish the process.',
                      style: TextStyle(fontSize: 16, color: Colors.white),  // Change text color to white for better contrast
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+92 234 3455234',
                ),
              ),
              SizedBox(height: 60),
              RoundButton(
                title: 'Login',
                loading: loginLoading,
                onTap: () => _validateAndSubmit(true),  // Pass true for login
              ),
              SizedBox(height: 20),
              RoundButton(
                title: 'Create Account',
                loading: createAccountLoading,
                onTap: () => _validateAndSubmit(false),  // Pass false for create account
              ),
            ],
          ),
        ),
      ),
    );
  }
}
