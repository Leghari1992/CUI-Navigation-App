import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for Clipboard

class MedicalInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CUI Medical Centre', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/medicalcenter.jpg', // Adjust path as per your assets folder structure
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Medical Centre Timing',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '8:00 AM to 9:00 PM',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Overview of CUI Medical Centre',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              context,
              'Establishment and Mission',
              'The CUI Islamabad Campus Medical Centre was established in 2007 as a first aid facility. Its primary mission is to provide efficient medical care to employees, students, and faculty members, utilizing available resources while addressing diverse healthcare needs.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Medical Staff and Facilities',
              'Staffing: Initially managed by one medical officer, the centre now employs three Medical Officers, three trained nurses, and two para-medical staff members.\n\nFacilities: Includes three beds for observation and two ambulances for transporting serious patients to tertiary-care hospitals.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Free Medical Services Offered',
              'The Medical Centre provides the following services free of charge:\n\u2022 Consultation & Emergency Medication\n\u2022 Vitals Monitoring\n\u2022 Antiseptic Dressing\n\u2022 ECG (Electrocardiogram)\n\u2022 Trauma/Burn/Anaphylaxis/Insect Bite Management\n\u2022 BSR (Blood Sugar Random) with glucometer\n\u2022 Nebulization\n\u2022 I/V Rehydration (Intravenous)',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Additional Health Initiatives',
              'In addition to medical services, the centre offers:\n\u2022 Healthcare Awareness Programs\n\u2022 Epidemic Lectures\n\u2022 First Aid Training for Students & Staff',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Specialized Services',
              '\u2022 CWC (Counselling & Wellness Centre): Provides mental health counselling and wellness support.\n\u2022 Dental Services: Offers dental care within the institute.',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Types of Emergencies Handled',
              'The Medical Centre is equipped to manage various minor emergencies, including:\n\u2022 Fainting/Unconsciousness\n\u2022 Shortness of Breath (SOB)\n\u2022 Minor Road Traffic Accidents (RTAs)\n\u2022 First Aid for Chest Pain\n\u2022 Dehydration/Vomiting\n\u2022 Allergic Reactions',
            ),
            SizedBox(height: 20.0),
            Text(
              'Ambulances',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'The campus provides two Ambulances:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ambulance1.jpg', // Adjust path as per your assets folder structure
                        height: 120,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Number Plate: GAG-792 ICT-Islamabad',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: '0330-5178358'));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Copied Ambulance Contact'),
                          ));
                        },
                        child: Text(
                          'Contact: 0330-5178358',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/ambulance2.jpg', // Adjust path as per your assets folder structure
                        height: 120,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Number Plate: GT-228 ICT-Islamabad',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: '0332-3005111'));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Copied Ambulance Contact'),
                          ));
                        },
                        child: Text(
                          'Contact: 0332-3005111',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            _buildSection(
              context,
              'Clinical Psychologist Availability',
              'Available for Consultation at CWC:\nMonday to Friday\n10:00 AM to 4:00 PM\n\nContacts:\n051-90495369\n051-90495777\n051-90495555\n\nEmail:',
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: 'cwc@comsats.edu.pk'));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Copied Email Address'),
                ));
              },
              child: Text(
                'cwc@comsats.edu.pk',
                style: TextStyle(fontSize: 16.0, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        content.contains('Email:') || content.contains('Contact:') ? GestureDetector(
          onTap: () {
            if (content.contains('Email:')) {
              Clipboard.setData(ClipboardData(text: 'cwc@comsats.edu.pk'));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Copied Email Address'),
              ));
            } else if (content.contains('Contact:')) {
              // Extract phone numbers and copy them
              final phoneNumbers = content.replaceAll('Contact:', '').trim();
              Clipboard.setData(ClipboardData(text: phoneNumbers));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Copied Contact Numbers'),
              ));
            }
          },
          child: Text(
            content,
            style: TextStyle(fontSize: 16.0),
          ),
        ) : Text(
          content,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
