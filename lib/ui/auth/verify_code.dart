import 'package:again1/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {

  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth  = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Verification',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(

              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: 'Verify',loading: loading, onTap: () async{

              setState(() {
                loading = true;
              });

              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString()
              );
              try
              {
                await auth.signInWithCredential(credential);

                Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
              }catch(e)
              {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(e.toString());
              }
            })

          ],
        ),
      ),
    );
  }
}
