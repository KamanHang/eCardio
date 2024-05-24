import 'package:ecardio/view/ConstantData.dart/exercise_data.dart';
import 'package:ecardio/view/ExerciseCard.dart';
import 'package:ecardio/view/ExerciseDetailsPage.dart';
import 'package:flutter/material.dart';


class DailyRecommendationPage extends StatefulWidget {
  final String id;
  const DailyRecommendationPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DailyRecommendationPage> createState() => _DailyRecommendationPageState();
}

class _DailyRecommendationPageState extends State<DailyRecommendationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Exercise Recommendation'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: ExerciseData.getExerciseCount(),
        itemBuilder: (context, index) {
          final exercise = ExerciseData.getExerciseDetails(index);
          return ExerciseCard(
            exerciseName: exercise['name'],
            image: exercise['image'],
            subtitle: exercise['subtitle'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailsPage(
                    exerciseName: exercise['name'],
                    steps: exercise['steps'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
