import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Ganti Profil'),
                    onPressed: () {
                      // Aksi untuk mengganti profil
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.download),
                    label: Text('Unduh'),
                    onPressed: () {
                      // Aksi untuk mengunduh anime
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: Icon(Icons.settings),
                    label: Text('Pengaturan'),
                    onPressed: () {
                      // Aksi untuk membuka pengaturan
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
