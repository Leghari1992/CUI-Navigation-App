import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../auth/login_screen.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),

        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: DeleteAccountForm(),
      ),
    );
  }
}

class DeleteAccountForm extends StatefulWidget {
  const DeleteAccountForm({Key? key}) : super(key: key);

  @override
  _DeleteAccountFormState createState() => _DeleteAccountFormState();
}

class _DeleteAccountFormState extends State<DeleteAccountForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verificationCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isDeleting = false;
  bool _isUsingEmail = true; // Flag to switch between email and phone number input
  String? _verificationId; // For phone number verification

  Future<void> sendVerificationCode(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number verified automatically')),
      );
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed: ${e.message}')),
      );
    };

    final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
      setState(() {
        _verificationId = verificationId;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification code sent to $phoneNumber')),
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
      setState(() {
        _verificationId = verificationId;
      });
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending verification code: ${e.toString()}')),
      );
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        setState(() {
          _isDeleting = true;
        });

        if (_isUsingEmail) {
          final credential = EmailAuthProvider.credential(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
          await user.reauthenticateWithCredential(credential);
        } else {
          if (_verificationId != null) {
            final credential = PhoneAuthProvider.credential(
              verificationId: _verificationId!,
              smsCode: _verificationCodeController.text.trim(),
            );
            await user.reauthenticateWithCredential(credential);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please complete phone number verification")),
            );
            return;
          }
        }

        // Delete user data from Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        // Delete user account using Firebase Authentication
        await user.delete();

        // Show success message and navigate to LoginScreen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully deleted account")),
        );

        // Delay navigation to allow SnackBar to finish
        await Future.delayed(Duration(seconds: 2));

        // Navigate to LoginScreen after successful deletion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
        );

      } catch (e) {
        // Handle errors
        print("Error deleting account: $e");

        // Show error message if necessary
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete account. Please provide correct credentials.")),
        );
      } finally {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _isUsingEmail
                      ? TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.trim().toLowerCase().endsWith('@gmail.com')) {
                        return 'Please enter a valid Gmail address';
                      }
                      return null;
                    },
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '+92 123 1234567', // Hint text for country code format
                          icon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          final RegExp phoneRegExp = RegExp(r'^\+\d{2} \d{3} \d{7}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!phoneRegExp.hasMatch(value.trim())) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _verificationCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Verification Code',
                          icon: Icon(Icons.code),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the verification code';
                          } else if (value.length != 6) {
                            return 'Verification code must be 6 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final phoneNumber = _phoneController.text.trim();
                          if (phoneNumber.isNotEmpty) {
                            sendVerificationCode(phoneNumber);
                          }
                        },
                        child: Text('Send Verification Code', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adjust padding for size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Optional: Adjust border radius
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_isUsingEmail)
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },


                    ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _isDeleting
                        ? null
                        : () {
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        deleteAccount(context);
                      }
                    },
                    child: _isDeleting
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text('Delete Account', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isUsingEmail = !_isUsingEmail;
                  });
                },
                child: Text(
                  _isUsingEmail
                      ? "Switch to Phone Number Verification"
                      : "Switch to Email Verification",
                  style: TextStyle(
                    color: Colors.blue,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
