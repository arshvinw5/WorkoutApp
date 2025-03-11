import 'dart:ffi';

class Exercise {
  final String name;
  final double weight;
  final int sets;
  final int reps;
  bool isDone;

  Exercise(
      {required this.name,
      required this.weight,
      required this.sets,
      required this.reps,
      this.isDone = false});
}
