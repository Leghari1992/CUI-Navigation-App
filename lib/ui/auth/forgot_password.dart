import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text('Forgot Password', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Icon(Icons.lock_reset, size: 100, color: Colors.indigo),
                SizedBox(height: 20),
                Text(
                  'Enter your email address below to receive a link to create a new password via email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.indigo),
                  ),
                ),
                SizedBox(height: 40),
                RoundButton(
                  title: 'Send Reset Link',
                  onTap: () {
                    auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                      Utils().toastMessage('We have sent you an email to recover your password, please check your email.');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                ),
                SizedBox(height: 20), // Adjusted spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
