import 'package:flutter/material.dart';

class HealthBlogs extends StatefulWidget {
  const HealthBlogs({super.key});

  @override
  State<HealthBlogs> createState() => _HealthBlogsState();
}

class _HealthBlogsState extends State<HealthBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is Blog Channel"),
    );
  }
}