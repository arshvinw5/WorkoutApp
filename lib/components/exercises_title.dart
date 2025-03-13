import 'package:flutter/material.dart';

class ExercisesTitle extends StatelessWidget {
  final String exerciseName;
  final double weight;
  final int sets;
  final int reps;
  final bool isDone;
  final Function(bool?)? onCheckBoxFunction;

  const ExercisesTitle(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isDone,
      required this.onCheckBoxFunction});

  @override
  Widget build(BuildContext context) {
    return isDone
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.red),
            child: ListTile(
              title: Text(exerciseName),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                        label: Text(
                      '${weight.toString()} kg',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(label: Text('${sets.toString()} sets')),
                  ),
                  Chip(label: Text('${reps.toString()} reps'))
                ],
              ),
              trailing: Checkbox(
                  value: isDone,
                  onChanged: (value) => onCheckBoxFunction!(value)),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black12),
            child: ListTile(
              title: Text(exerciseName),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(
                        label: Text(
                      '${weight.toString()} kg',
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(label: Text('${sets.toString()} sets')),
                  ),
                  Chip(label: Text('${reps.toString()} reps'))
                ],
              ),
              trailing: Checkbox(
                  value: isDone,
                  onChanged: (value) => onCheckBoxFunction!(value)),
            ),
          );
  }
}
