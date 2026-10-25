import 'package:again1/ui/posts/sections/sub_sections/settings/account_details.dart';
import 'package:again1/ui/posts/sections/sub_sections/settings/delete_account.dart';
import 'package:again1/ui/posts/sections/sub_sections/settings/log_out.dart';
import 'package:again1/ui/posts/sections/sub_sections/settings/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:again1/ui/auth/forgot_password.dart';
import '../../../../../widgets/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        //      color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountDetailsScreen(),
                  ),
                );
              },
              icon: Icon(Icons.account_circle, color: Colors.blue),
              label: Text(
                'Account',
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                bool isDark = themeProvider.isDarkMode;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          themeProvider.setTheme(ThemeData.dark());
                        },
                        icon: Icon(
                          Icons.nightlight_round,
                          color: isDark ? Colors.white : Colors.blue,
                        ),
                        label: Text(
                          'Dark Theme',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.blue,
                            fontSize: 16.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.indigo : Colors.white,
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          themeProvider.setTheme(
                            ThemeData(
                              primarySwatch: Colors.indigo,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.wb_sunny,
                          color: !isDark ? Colors.white : Colors.blue,
                        ),
                        label: Text(
                          'Light Theme',
                          style: TextStyle(
                            color: !isDark ? Colors.white : Colors.blue,
                            fontSize: 16.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isDark ? Colors.indigo : Colors.white,
                          padding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),


            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to Forgot Password screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen(),
                  ),
                );
              },
              icon: Icon(Icons.lock_open, color: Colors.blue),
              label: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications()),
                );
              },

              icon: Icon(Icons.exit_to_app, color: Colors.blue),
              label: Text(
                'Notifications',
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),




            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Show logout confirmation dialog
                logout(context);

              },
              icon: Icon(Icons.logout, color: Colors.blue),
              label: Text(
                'Log Out',
                style: TextStyle(color: Colors.blue, fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Show confirmation dialog for deleting account
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirm Delete"),
                      content: Text("Are you sure you want to delete your account?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Yes"),
                          onPressed: () {
                            // Handle account deletion
                            Navigator.of(context).pop(); // Close confirmation dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DeleteAccountScreen()),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },

                // Handle Delete Account button press

              icon: Icon(Icons.delete, color: Colors.white),
              label: Text(
                'Delete Account',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 2,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}