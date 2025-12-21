import 'package:flutter/material.dart';

class JobsHome extends StatelessWidget {
  const JobsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electrician Jobs'),
      ),
      body: const Center(
        child: Text('Welcome to Electrician App'),
      ),
    );
  }
}
