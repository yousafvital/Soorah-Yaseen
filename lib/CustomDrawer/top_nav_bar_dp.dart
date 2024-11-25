import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your logic to retrieve the user's name
    const String userName = "يٰسٓ"; // Replace with the actual user's name

    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white, // Background color for the circle
            child: Text(
              userName,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noori'),
            ),
          ),
        ],
      ),
    );
  }
}
