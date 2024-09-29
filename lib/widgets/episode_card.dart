import 'package:flutter/material.dart';

class EpisodeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          EpisodeCard(image: 'assets/images/atri.jpg', title: 'Atri: My Dear Moments', episode: 'Episode 1'),
          EpisodeCard(image: 'assets/images/noblesse.jpg', title: 'Noblesse', episode: 'Episode 1'),
          EpisodeCard(image: 'assets/images/tower_of_god.jpg', title: 'Tower of God', episode: 'Episode 2'),
        ],
      ),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  final String image;
  final String title;
  final String episode;

  const EpisodeCard({
    required this.image,
    required this.title,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 100, fit: BoxFit.cover),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(episode, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
