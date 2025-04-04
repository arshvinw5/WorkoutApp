import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_app/datetime/date_time.dart';

class ExercisesTitle extends StatelessWidget {
  final String exerciseName;
  final double weight;
  final int sets;
  final int reps;
  final bool isDone;
  final Function(bool?)? onCheckBoxFunction;
  final Function()? onDeleteFunction;
  final Function()? onEditFunction;
  final String dateTime;
  final bool isEdited;
  final String editedDateTime;

  const ExercisesTitle(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.isDone,
      required this.onCheckBoxFunction,
      required this.onDeleteFunction,
      required this.dateTime,
      required this.onEditFunction,
      required this.isEdited,
      required this.editedDateTime});

  @override
  Widget build(BuildContext context) {
    print('isEdited: $dateTime');
    print('editedDateTime: $editedDateTime');
    return isDone
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.red),
            child: ListTile(
              title: Text(exerciseName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  SizedBox(height: 10),
                  isEdited
                      ? Text(
                          'Edited: ${formatDateTime(DateTime.parse(editedDateTime))}')
                      : Text(
                          'Created: ${formatDateTime(DateTime.parse(dateTime))}'),
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
            child: Slidable(
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                  onPressed: (context) => onEditFunction!(),
                ),
                SlidableAction(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  onPressed: (context) => onDeleteFunction!(),
                ),
              ]),
              child: ListTile(
                title: Text(exerciseName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 8.0),
                          child: Chip(
                              label: Text(
                            '${weight.toString()} kg',
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(label: Text('${sets.toString()} sets')),
                        ),
                        Chip(label: Text('${reps.toString()} reps')),
                      ],
                    ),
                    SizedBox(height: 10),
                    isEdited
                        ? Text(
                            'Edited: ${formatDateTime(DateTime.parse(editedDateTime))}')
                        : Text(
                            'Created: ${formatDateTime(DateTime.parse(dateTime))}'),
                  ],
                ),
                trailing: Checkbox(
                    value: isDone,
                    onChanged: (value) => onCheckBoxFunction!(value)),
              ),
            ),
          );
  }
}

/* 

Why Does onChanged: (value) => onCheckBoxFunction!(value) Need a Value?

    The Checkbox widget automatically provides a value (true/false).

    Since onCheckBoxFunction in ExercisesTitle expects a function that takes a bool?, it must receive this value.

    However, _WorkoutScreenState’s onCheckBoxFunction does not use this value, so we discard it using _ in onCheckBoxFunction: (_) => onCheckBoxFunction(...).

Why Doesn’t onDeleteFunction: () => deleteExercise(...) Need a Parameter?

    SlidableAction doesn’t pass any arguments to onDeleteFunction, so it must be a function with no parameters.

    That’s why we wrap deleteExercise inside () => deleteExercise(...).

    */
