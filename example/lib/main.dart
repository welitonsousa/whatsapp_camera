import 'dart:io';

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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final files = ValueNotifier(<File>[]);

  @override
  void initState() {
    files.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    files.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("whatsapp camera")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          List<File>? res = await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WhatsappCamera()));
          if (res != null) files.value = res;
        },
      ),
      body: ListView.builder(
        itemCount: files.value.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            width: 200,
            child: Image.file(files.value[index]),
          );
        },
      ),
    );
  }
}
