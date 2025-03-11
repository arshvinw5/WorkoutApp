import 'package:flutter/material.dart';

class ExercisesTitle extends StatelessWidget {
  final String exerciseName;
  final double weight;
  final int sets;
  final int reps;
  final bool isDone;

  const ExercisesTitle(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(label: Text('${weight.toString()} kg')),
            Chip(label: Text('${sets.toString()} sets')),
            Chip(label: Text('${reps.toString()} reps'))
          ],
        ),
      ),
    );
  }
}
