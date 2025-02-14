import 'package:flutter/material.dart';

class ShowBookPage extends StatefulWidget {
  const ShowBookPage({super.key, required this.bookId});
  final String bookId;

  @override
  State<ShowBookPage> createState() => _ShowBookPageState();
}

class _ShowBookPageState extends State<ShowBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: Container(),
    );
  }
}
