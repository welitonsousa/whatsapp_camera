import 'package:flutter/material.dart';
import 'package:whatsapp_camera/camera/camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("whatsapp camera")),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.camera),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const WhatsappCamera()));
          },
        ),
      ),
    );
  }
}
