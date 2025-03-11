import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/exercises_title.dart';
import 'package:workout_app/data/workout_data.dart';

class WorkoutScreen extends StatefulWidget {
  final String workoutName;
  const WorkoutScreen({super.key, required this.workoutName});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: Text(widget.workoutName),
              ),
              body: ListView.builder(
                  itemCount:
                      value.numberOfExercisesInWorkout(widget.workoutName),
                  itemBuilder: (context, index) {
                    final workouts =
                        value.getReleventWorkout(widget.workoutName);

                    //null safety
                    if (workouts == null) {
                      return Scaffold(
                        body: Center(
                          child: Text('Workout is not found'),
                        ),
                      );
                    } else {
                      return ExercisesTitle(
                          exerciseName: workouts.exercises[index].name,
                          weight: workouts.exercises[index].weight,
                          sets: workouts.exercises[index].sets,
                          reps: workouts.exercises[index].reps,
                          isDone: workouts.exercises[index].isDone);
                    }
                  }),
            ));
  }
}
