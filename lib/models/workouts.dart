import 'package:workout_app/models/exercise.dart';

class Workouts {
  final int id;
  String name;
  final List<Exercise> exercises;
  final String timestamp;
  String editedTime;

  Workouts(
      {required this.id,
      required this.name,
      required this.exercises,
      required this.timestamp,
      this.editedTime = ''});
}
