import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/datetime/date_time.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workouts.dart';

class WorkoutData extends ChangeNotifier {
  //creating a db object
  final db = HiveDatabase();

  List<Workouts> workoutsList = [
    Workouts(
        id: 1,
        name: 'Upper Body',
        timestamp: DateTime.now().toString(),
        exercises: [
          Exercise(name: 'Bicep Curl', weight: 10.5, sets: 3, reps: 12),
        ])
  ];

  //if there is workours already in db then get that workouts list

  void initilaseWorkoutsList() {
    if (db.previousDataExists()) {
      workoutsList = db.readFromDatabase();
      //otherwuse use default workouts
    } else {
      db.saveToDatabase(workoutsList);
    }

    //load heat map
    loadHeatMapData();
  }

  // methd for getting the list of workouts
  List<Workouts> getWorkoutsList() => workoutsList;

  //get the lenth of a giiven workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workouts? releventWorkout = getReleventWorkout(workoutName);
    return releventWorkout?.exercises.length ?? 0;
  }

  //user to add workouts
  void addWorkout(String name) {
    int newId = DateTime.now().millisecondsSinceEpoch;
    String timestamp = DateTime.now().toIso8601String();

    workoutsList.add(
        Workouts(id: newId, name: name, exercises: [], timestamp: timestamp));
    //save to db
    db.saveToDatabase(workoutsList);
    notifyListeners();
  }

  //add exercise to workout
  void addExerciseToWorkout(String workoutName, String exerciseName,
      double weight, int sets, int reps) {
    Workouts? releventWorkout = getReleventWorkout(workoutName);

    releventWorkout?.exercises.add(
        Exercise(name: exerciseName, weight: weight, sets: sets, reps: reps));

    //save to db
    db.saveToDatabase(workoutsList);
    notifyListeners();
  }

  //firstWhere → Searches the list for the first Workouts object where workout.name matches workoutName.
  //If no match is found, it throws an exception. (If there's a chance the workout might not exist, a safer approach would be using firstWhere with orElse.)

  //check off completed exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //find the relevant workout
    Exercise? releventExercise = getReleventExercise(workoutName, exerciseName);
    //Toggle the value (true <-> false)
    releventExercise?.isDone = !releventExercise.isDone;

    //save to db
    db.saveToDatabase(workoutsList);

    //load heat map
    loadHeatMapData();

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

  //start date
  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};

  //heatmap
  void loadHeatMapData() {
    DateTime startDate = createDateTineObject(getStartDate());

    //count number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    //go from start date to today, and add each completion status to the datasets list
    //"COMPLETION_STSTUS_YYYYMMDD" will be the key in the datavbase

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          covertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));

      //complettion status 0 or 1

      int complettionStatus = db.getCompletionStatus(yyyymmdd);

      //year

      int year = startDate.add(Duration(days: i)).year;
      //month

      int month = startDate.add(Duration(days: i)).month;
      //day
      int day = startDate.add(Duration(days: i)).day;

      final precentForEachDay = <DateTime, int>{
        DateTime(year, month, day): complettionStatus
      };

      //add to heatmapdataset
      heatMapDataSet.addEntries(precentForEachDay.entries);
    }
  }
}
