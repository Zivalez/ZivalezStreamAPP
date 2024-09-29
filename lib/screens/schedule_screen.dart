import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Jumlah tab (hari)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jadwal Rilis'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Senin'),
              Tab(text: 'Selasa'),
              Tab(text: 'Rabu'),
              Tab(text: 'Kamis'),
              Tab(text: 'Jumat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScheduleList(day: 'Senin'),
            ScheduleList(day: 'Selasa'),
            ScheduleList(day: 'Rabu'),
            ScheduleList(day: 'Kamis'),
            ScheduleList(day: 'Jumat'),
          ],
        ),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  final String day;

  const ScheduleList({required this.day});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ScheduleCard(time: '19:30', title: 'Yishi Zhi Zun', episode: 'Episode 16'),
        ScheduleCard(time: '17:42', title: 'Rick and Morty', episode: 'Episode 7'),
        ScheduleCard(time: '10:29', title: 'Tousouchuu: Great Mission', episode: 'Episode 50'),
        ScheduleCard(time: '09:22', title: 'Fanren Xiu Xian Chuan', episode: 'Episode 44'),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String time;
  final String title;
  final String episode;

  const ScheduleCard({
    required this.time,
    required this.title,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(title),
      subtitle: Text(episode),
      trailing: Text(time),
    );
  }
}
