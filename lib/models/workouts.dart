import 'package:workout_app/models/exercise.dart';

class Workouts {
  final int id;
  final String name;
  final List<Exercise> exercises;
  final String timestamp;

  Workouts(
      {required this.id,
      required this.name,
      required this.exercises,
      required this.timestamp});
}
