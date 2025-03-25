import 'dart:ffi';

class Exercise {
  final int id;
  final String name;
  final double weight;
  final int sets;
  final int reps;
  bool isDone;
  final String timestamp;

  Exercise(
      {required this.id,
      required this.name,
      required this.weight,
      required this.sets,
      required this.reps,
      this.isDone = false,
      required this.timestamp});
}
