import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;  // Changed to nullable
  String _userName = '';
  String _userEmailOrPhone = '';
  String _nameDescription = '';
  late File _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageFile = File('');
    _getCurrentUserDetails(); // Fetch current user details
  }

  Future<void> _getCurrentUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        if (_currentUser?.email != null) {
          _userEmailOrPhone = _currentUser!.email!;
        } else if (_currentUser?.phoneNumber != null) {
          _userEmailOrPhone = _currentUser!.phoneNumber!;
        } else {
          _userEmailOrPhone = 'Email/Phone not available';
        }
      });

      try {
        DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(_currentUser!.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _userName = docSnapshot.get('name');
            _nameDescription = docSnapshot.get('description') ?? '';
            _descriptionController.text = _nameDescription;

            // Fetch and set profile picture
            String? profilePictureUrl = docSnapshot.get('profilePicture');
            if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
              _imageFile = File(profilePictureUrl);
            }
          });
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<void> _saveUserData() async {
    try {
      await _firestore.collection('users').doc(_currentUser!.uid).set({
        'name': _userName,
        'description': _nameDescription,
        'profilePicture': _imageFile.existsSync() ? _imageFile.path : '',
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save data'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfilePicture() async {
    try {
      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .set({'profilePicture': _imageFile.path}, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile picture updated successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error updating profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile picture'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          'Account Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _currentUser != null
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _imageFile.existsSync()
                          ? FileImage(_imageFile)
                          : AssetImage('assets/default_profile.png') as ImageProvider,
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: _getImage,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _saveProfilePicture,
                    child: Text('Save Profile Picture'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: $_userName',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logged in via:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _userEmailOrPhone,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _nameDescription,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Update your name:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                      cursorColor: Colors.blue,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          _userName = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveUserData,
                      child: Text('Save Name'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Update your description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter your description',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                      cursorColor: Colors.blue,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          _nameDescription = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveUserData,
                      child: Text('Save Description'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
