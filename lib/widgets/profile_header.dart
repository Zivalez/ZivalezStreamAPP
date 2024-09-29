import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            radius: 40,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aditya Dharma', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Si Pencinta Sci-Fi', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
