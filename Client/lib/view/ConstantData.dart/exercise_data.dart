class ExerciseData {
  static List<Map<String, dynamic>> exercises = [
    {
      'name': 'Jumping Jacks',
      'image': 'assets/images/jumpingjack.png',
      'subtitle': 'Full body workout',
      'steps': [
        'Stand with your feet together and your hands at your sides.',
        'Jump while spreading your arms and legs.',
        'Return to the starting position by jumping again.',
      ],
    },
    {
      'name': 'Jogging',
      'image': 'assets/images/jogging.png',
      'subtitle': 'Cardiovascular exercise',
      'steps': [
        'Start by standing with your feet hip-width apart.',
        'Lift your knees up towards your chest alternately as if you were running.',
        'Continue for the desired duration.',
      ],
    },
    {
      'name': 'Skipping',
      'image': 'assets/images/skipping.png',
      'subtitle': 'Cardiovascular exercise',
      'steps': [
        'Start by standing with your feet hip-width apart.',
        'Lift your knees up towards your chest alternately as if you were running.',
        'Continue for the desired duration.',
      ],
    },
    {
      'name': 'Mountain Climber',
      'image': 'assets/images/mountainclimbers.png',
      'subtitle': 'Cardiovascular exercise',
      'steps': [
        'Start by standing with your feet hip-width apart.',
        'Lift your knees up towards your chest alternately as if you were running.',
        'Continue for the desired duration.',
      ],
    },
    {
      'name': 'Sit Ups',
      'image': 'assets/images/situps.png',
      'subtitle': 'Core exercise',
      'steps': [
        'Start by standing with your feet hip-width apart.',
        'Lift your knees up towards your chest alternately as if you were running.',
        'Continue for the desired duration.',
      ],
    },
    // Add more exercises here as needed
  ];

  static Map<String, dynamic> getExerciseDetails(int index) {
    return exercises[index];
  }

  static int getExerciseCount() {
    return exercises.length;
  }
}
