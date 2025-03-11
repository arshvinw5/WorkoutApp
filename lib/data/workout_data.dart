import 'package:flutter/material.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workouts.dart';

class WorkoutData extends ChangeNotifier {
  List<Workouts> workoutsList = [
    Workouts(name: 'Upper Body', exercises: [
      Exercise(name: 'Bicep Curl', weight: 10.5, sets: 3, reps: 12),
    ])
  ];

  // methd for getting the list of workouts
  List<Workouts> getWorkoutsList() => workoutsList;

  //get the lenth of a giiven workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workouts? releventWorkout = getReleventWorkout(workoutName);
    return releventWorkout?.exercises.length ?? 0;
  }

  //user to add workouts
  void addWorkout(String name) {
    workoutsList.add(Workouts(name: name, exercises: []));
    notifyListeners();
  }

  //add exercise to workout
  void addExerciseToWorkout(String workoutName, String exerciseName,
      double weight, int sets, int reps) {
    Workouts? releventWorkout = getReleventWorkout(workoutName);

    releventWorkout?.exercises.add(
        Exercise(name: exerciseName, weight: weight, sets: sets, reps: reps));

    notifyListeners();
  }

  //firstWhere → Searches the list for the first Workouts object where workout.name matches workoutName.
  //If no match is found, it throws an exception. (If there's a chance the workout might not exist, a safer approach would be using firstWhere with orElse.)

  //check off completed exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //find the relevant workout
    Exercise? releventExercise = getReleventExercise(workoutName, exerciseName);
    //to on and off the bool value
    releventExercise?.isDone = !releventExercise.isDone;

    notifyListeners();
  }

  //reurn the workout object givin the name
  Workouts? getReleventWorkout(String workoutName) {
    Workouts? releventWorkout = workoutsList.firstWhere(
      (workout) => workout.name == workoutName,
    );
    return releventWorkout;
  }

  //reurn the exercise object givin the name
  Exercise? getReleventExercise(String workoutName, String exerciseName) {
    //find the relevent workout
    Workouts? releventWorkout = getReleventWorkout(workoutName);

    //find the relevent exercise
    Exercise? releventExercise = releventWorkout?.exercises.firstWhere(
      (exercise) => exercise.name == exerciseName,
    );

    return releventExercise;
  }
}
