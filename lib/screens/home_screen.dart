import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/episode_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Episode Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          EpisodeList(),
        ],
      ),
    );
  }
}
