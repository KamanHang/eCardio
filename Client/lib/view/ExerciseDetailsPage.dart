import 'package:flutter/material.dart';

class ExerciseDetailsPage extends StatelessWidget {
  final String exerciseName;
  final List<String> steps;

  const ExerciseDetailsPage({
    required this.exerciseName,
    required this.steps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to do $exerciseName:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Display steps
            for (var i = 0; i < steps.length; i++)
              Text(
                '${i + 1}. ${steps[i]}',
                style: TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
