import 'dart:ffi';

class Exercise {
  final int id;
  String name;
  double weight;
  int sets;
  int reps;
  bool isDone;
  final String timestamp;
  String editedTime;

  Exercise(
      {required this.id,
      required this.name,
      required this.weight,
      required this.sets,
      required this.reps,
      this.isDone = false,
      required this.timestamp,
      this.editedTime = ''});
}
