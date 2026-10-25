import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackReportingScreen extends StatefulWidget {
  const FeedbackReportingScreen({super.key});

  @override
  State<FeedbackReportingScreen> createState() =>
      _FeedbackReportingScreenState();
}

class _FeedbackReportingScreenState extends State<FeedbackReportingScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  double _rating = 3.0;
  String? _documentId;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadFeedback() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(user.uid) // Assuming you want to store feedback per user
          .get();

      if (feedbackDoc.exists) {
        _controller.text = feedbackDoc['feedback'];
        _rating = feedbackDoc['rating'];
        _documentId = feedbackDoc.id;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: const Text('Feedback', style: TextStyle(color: Colors.white)),
      ),
     // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We value your feedback!\nPlease share your thoughts and rate your experience 😊',
                  style: TextStyle(

                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Enter your feedback here',
                    filled: true,
                    fillColor: Color(0xC6C6C6A8),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  maxLength: 4096,
                  textInputAction: TextInputAction.done,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Rate your experience:',
                  style: TextStyle(

                    fontSize: 18.0,
                  ),
                ),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _isSubmitting
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isSubmitting = true;
                          });
                          String message;
                          try {
                            final user =
                                FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final collection = FirebaseFirestore
                                  .instance
                                  .collection('feedback');
                              if (_documentId == null) {
                                // Add new feedback
                                await collection.doc(user.uid).set({
                                  'timestamp':
                                  FieldValue.serverTimestamp(),
                                  'feedback': _controller.text,
                                  'rating': _rating,
                                  'userId': user.uid,
                                });
                              } else {
                                // Update existing feedback
                                await collection
                                    .doc(_documentId)
                                    .update({
                                  'feedback': _controller.text,
                                  'rating': _rating,
                                  'timestamp':
                                  FieldValue.serverTimestamp(),
                                });
                              }
                              message = 'Feedback sent successfully';
                            } else {
                              message = 'User not authenticated';
                            }
                          } catch (e) {
                            message = 'Error when sending feedback';
                            print(e); // Print error for debugging
                          }
                          setState(() {
                            _isSubmitting = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)));
                          Navigator.pop(context);
                        }
                      },
                      child: _isSubmitting
                          ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(
                              Colors.white),
                        ),
                      )
                          : const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
