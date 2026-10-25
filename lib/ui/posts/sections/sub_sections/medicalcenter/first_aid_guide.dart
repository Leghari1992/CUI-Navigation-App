import 'package:flutter/material.dart';

class FirstAidGuide extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('First Aid Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image below the AppBar
            SizedBox(
              width: double.infinity, // Full width
              height: 100, // Adjust height as needed
              child: Image.asset(
                'assets/images/firstaid.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              ' First Aid Guide',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'First aid is crucial in emergency situations to provide initial care and potentially save lives. This guide covers essential first aid techniques and considerations for common emergency scenarios.\nFollowing these instructions can empower individuals to confidently respond to medical emergencies.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify, // Justify text
            ),
            SizedBox(height: 20),
            // Table of Contents
            Text(
              'Table of Contents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildTableOfContents(),
            SizedBox(height: 20),
            // Sections
            _buildSection(
              '1.Introduction to First Aid',
              [
                _buildSubSection(
                  'Importance of First Aid',
                  'First aid involves providing immediate assistance to someone who has been injured or is suddenly taken ill. Prompt intervention can prevent conditions from worsening and improve the chances of recovery.',
                ),
                _buildSubSection(
                  'Legal Considerations',
                  'In many countries, including Australia, providing first aid is protected by Good Samaritan laws, which encourage people to offer reasonable assistance without fear of legal liability.',
                ),
              ],
            ),
            _buildSection(
              '2.DRSABCD Action Plan',
              [
                _buildSubSection(
                  'Overview',
                  'The DRSABCD action plan is a structured approach to assess and respond in emergencies.',
                ),
                _buildSubSection(
                  'Step-by-Step Procedure',
                  _buildDRSABCDTable(),
                ),
              ],
            ),
            _buildSection(
              '3.Infection Control During First Aid',
              [
                _buildSubSection(
                  'Use of Resuscitation Masks',
                  'To prevent exposure to bodily fluids:\n\u2022 Always carry a resuscitation mask in your first aid kit and familiarize yourself with its use.\n\u2022 Use gloves and other protective gear as necessary to reduce the risk of infection transmission.',
                ),
                _buildSubSection(
                  'Hygiene Practices',
                  '\u2022 Wash hands thoroughly with soap and water before and after providing first aid.\n\u2022 Use alcohol-based hand sanitizers if soap and water are not available.\n\u2022 Avoid breathing directly over open wounds or the person’s face during rescue breaths.',
                ),
              ],
            ),
            _buildSection(
              '4.First Aid Techniques for Specific Scenarios',
              [
                _buildSubSection(
                  'Choking',
                  '\u2022 Assessment: Determine if the person is unable to speak, cough, or breathe.\n\u2022 Treatment: Perform abdominal thrusts (Heimlich maneuver) to dislodge the obstruction. Stand behind the person, wrap your arms around their waist, and deliver firm, upward thrusts to the abdomen until the object is expelled.',
                ),
                _buildSubSection(
                  'Medication or Drug Overdose',
                  '\u2022 Response: Stay with the person and monitor their breathing closely.\n\u2022 Action: Call emergency services immediately and provide information about the substance ingested, if known. Follow their instructions while waiting for help to arrive.',
                ),
                _buildSubSection(
                  'Heavy Bleeding and Wound Management',
                  '\u2022 Direct Pressure: Apply direct pressure to the wound using a clean cloth or bandage to control bleeding.\n\u2022 Elevation: If possible, elevate the injured limb above the level of the heart to reduce blood flow to the wound.\n\u2022 Tourniquet: Use a tourniquet only as a last resort for life-threatening bleeding, and ensure it is applied correctly above the wound.',
                ),
              ],
            ),
            _buildSection(
              '5.Essentials of First Aid Kits',
              [
                _buildSubSection(
                  'Contents',
                  'A well-stocked first aid kit should include:\n\u2022 Bandages and Dressings\n\u2022 Adhesive Tape\n\u2022 Resuscitation Mask\n\u2022 Gloves\n\u2022 Antiseptic Wipes/Solution\n\u2022 Scissors\n\u2022 CPR Face Shield',
                ),
                // Image beneath the essentials of First Aid Kits
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Full width
                  height: 200, // Adjust height as needed
                  child: Image.asset(
                    'assets/images/kit.png',
                    fit: BoxFit.cover,
                  ),
                ),
                _buildSubSection(
                  'Maintenance and Accessibility',
                  '\u2022 Regularly check and replenish supplies to ensure readiness.\n\u2022 Store kits in easily accessible locations such as homes, cars, and workplaces.',
                ),
              ],
            ),
            _buildSection(
              '6.Bandaging and Sling Techniques',
              [
                _buildSubSection(
                  'Types of Bandages',
                  '\u2022 Triangular Bandage: Versatile for slings, head injuries, and as a large dressing.\n\u2022 Roller Bandage: Used to secure dressings, support joints, and apply pressure.\n\u2022 Tensor Bandage: Provides uniform compression and support to injured limbs.\n\u2022 Tubular Bandage: Used for dressing retention on cylindrical body parts like arms and legs.',
                ),
                // Image beneath Types of bandages
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Full width
                  height: 200, // Adjust height as needed
                  child: Image.asset(
                    'assets/images/bandages.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),

                _buildSubSection(
                  '\nHow to Apply an Arm Sling',
                  '\u2022 Positioning: Place the triangular bandage with the long edge along the body, pointing toward the elbow of the injured arm.\n\u2022 Application: Fold the top corner over the elbow and bring the sides around the neck. Tie securely at the fingertips to support the arm comfortably.',
                ),
                // Image beneath How to apply an arm Sling
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // Full width
                  height: 170, // Adjust height as needed
                  child: Image.asset(
                    'assets/images/armsling.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> subSections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subSections,
        ),
      ],
    );
  }

  Widget _buildSubSection(String title, dynamic content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        // Check if content is a String or a Widget
        if (content is String)
          Text(
            content,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.justify, // Justify text
          ),
        if (content is Widget)
          content, // Directly return the widget
      ],
    );
  }

  Widget _buildDRSABCDTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1), // Adjust the flex ratio for the Step column
        1: FlexColumnWidth(3), // Adjust the flex ratio for the Description column
      },
      border: TableBorder.all(width: 1.0, color: Colors.black),
      children: [
        TableRow(
          children: [
            _buildTableCell('Step', true),
            _buildTableCell('Description', true),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('D', false),
            _buildTableCell('Danger - Assess the scene for safety before approaching the injured person.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('R', false),
            _buildTableCell('Response - Check if the person is conscious and responsive.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('S', false),
            _buildTableCell('Send for help - Call emergency services (15 in Pakistan) or ask someone nearby to call.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('A', false),
            _buildTableCell('Airway - Ensure the person\'s airway is clear and open.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('B', false),
            _buildTableCell('Breathing - Check if the person is breathing normally.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('C', false),
            _buildTableCell('CPR (Cardiopulmonary resuscitation) - Perform chest compressions and rescue breaths if necessary.', false),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('D', false),
            _buildTableCell('Defibrillation - Use an automated external defibrillator (AED) if available and follow prompts.', false),
          ],
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, bool isHeader) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: isHeader ? Colors.blue : Colors.white,
      alignment: Alignment.center,
      height: 60, // Fixed height for each table cell
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
      ),
    );
  }


  Widget _buildTableOfContents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableOfContentsItem('Introduction to First Aid', '1'),
        _buildTableOfContentsItem('DRSABCD Action Plan', '2'),
        _buildTableOfContentsItem('Infection Control During First Aid', '3'),
        _buildTableOfContentsItem('First Aid Techniques for Specific Scenarios', '4'),
        _buildTableOfContentsItem('Essentials of First Aid Kits', '5'),
        _buildTableOfContentsItem('Bandaging and Sling Techniques', '6'),
      ],
    );
  }

  Widget _buildTableOfContentsItem(String title, String number) {
    return Row(
      children: [
        Text('$number. ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify, // Justify text
          ),
        ),
      ],
    );
  }
}
