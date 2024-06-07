import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String nama;
  final String nim;
  final String kelas;

  // Constructor to receive data when navigating to the profile screen
  const ProfileScreen({
    Key? key,
    required this.nama,
    required this.nim,
    required this.kelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                // Use NetworkImage for online images
                backgroundImage: NetworkImage(
                  'https://s3.amazonaws.com/assets.unprimdn.ac.id/images/students/47420/47420-medium.jpeg',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Nama: $nama',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'NIM: $nim',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Kelas: $kelas',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
