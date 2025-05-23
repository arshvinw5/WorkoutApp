import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout_app/datetime/date_time.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workouts.dart';

class HiveDatabase {
  //reference to hive box database
  final _myBox = Hive.box('workout_database_1');

  //check if there is already data stored, if not recod the start data (Put start date)
  bool previousDataExists() {
    print("Box keys: ${_myBox.keys}"); // Check keys in Hive

    if (_myBox.isEmpty) {
      print('Previous data does not exist.');
      _myBox.put('START_DATE', todaysDateYYYMMDD());
      return false;
    } else {
      print('Previous data exists.');
      return true;
    }
  }

  //return start data as yymmdd (To get the start date)
  String getStartDate() {
    return _myBox.get('START_DATE');
  }

  //write data
  //The function saveToDatabase() converts workout objects into lists of strings and stores them in Hive.
  void saveToDatabase(List<Workouts> workouts) {
    //covert workout object into lists of strings so that can be save in HIVE
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectExerciseList(workouts);

    //check if any exercises have been done then it will put a 0 or 1 for each yyyymmdd date
    if (exerciseComleted(workouts)) {
      _myBox.put('COMPLETION_STATUS_${todaysDateYYYMMDD()}', 1);
    } else {
      _myBox.put('COMPLETION_STATUS_${todaysDateYYYMMDD()}', 0);
    }

    //then save this in hive
    _myBox.put('WORKOUTS', workoutList);
    _myBox.put('EXERCISES', exerciseList);

    print("Saved Workouts: ${_myBox.get('WORKOUTS')}");
    print("Saved Exercises: ${_myBox.get('EXERCISES')}");
  }

  //read data and return list of workouts
  List<Workouts> readFromDatabase() {
    List<Workouts> mySavedWorkouts = [];

    List<dynamic> workoutNames = _myBox.get('WORKOUTS');
    final exercisesDetails = _myBox.get('EXERCISES');

    //create workout objects
    for (int i = 0; i < workoutNames.length; i++) {
      //each workout can have multiple exercises
      List<Exercise> exercisesInEachWorkouts = [];

      for (int j = 0; j < exercisesDetails[i].length; j++) {
        // Fix loop condition
        exercisesInEachWorkouts.add(Exercise(
          id: int.tryParse(exercisesDetails[i][j][0].toString()) ?? 0,
          name: exercisesDetails[i][j][1],
          weight: double.tryParse(exercisesDetails[i][j][2].toString()) ??
              0.0, // 👈 Convert String to double safely
          sets: int.tryParse(exercisesDetails[i][j][3].toString()) ??
              0, // 👈 Convert String to int safely
          reps: int.tryParse(exercisesDetails[i][j][4].toString()) ??
              0, // 👈 Convert String to int safely
          isDone: exercisesDetails[i][j][5].toString().toLowerCase() ==
              'true', // 👈 Normalize boolean conversion
          // 🔹 Load isDone as boolean
          timestamp:
              exercisesDetails[i][j][6] ?? DateTime.now().toIso8601String(),
          editedTime: exercisesDetails[i][j].length > 7 &&
                  exercisesDetails[i][j][7] != null
              ? exercisesDetails[i][j][7] // Load stored editedTime if available
              : exercisesDetails[i][j][6], // Default
        ));
      }

      //create individual workouts
      Workouts workout = Workouts(
        id: int.tryParse(workoutNames[i][0]) ?? 0,
        name: workoutNames[i][1],
        exercises: exercisesInEachWorkouts,
        timestamp: workoutNames[i][2],
        editedTime: workoutNames[i].length > 3 && workoutNames[i][3] != null
            ? workoutNames[i][3] // Load stored editedTime if available
            : workoutNames[i][2], // Default
      );

      mySavedWorkouts.add(workout);
    }

    return mySavedWorkouts;
  }

  //check if any exercis has been done

  //return completion status of a givn data yymmdd

  bool exerciseComleted(List<Workouts> workouts) {
    // go tru each workouts
    for (var workout in workouts) {
      //go thru each exericise
      for (var exercise in workout.exercises) {
        if (exercise.isDone) {
          return true;
        }
      }
    }
    return false;
  }

  // return completion status of a givn data yymmdd
  int getCompletionStatus(String yyyymmdd) {
    //return 0 or 1 , if null then return 0
    int completionStatus = _myBox.get('COMPLETION_STATUS_$yyyymmdd') ?? 0;
    return completionStatus;
  }

//never use this
  void resetDatabase() async {
    await _myBox.clear();
    print("Hive database has been reset.");
  }
}

//we need this to store date in Hive as string
//covert workout object into a list -> eg [upperbody , lowrbody]

List<List<String>> convertObjectToWorkoutList(List<Workouts> workouts) {
  List<List<String>> workoutList = [];

  for (var workout in workouts) {
    workoutList.add([
      workout.id.toString(), // Store ID
      workout.name,
      workout.timestamp, // Store timestamp
      workout.editedTime
    ]);
  }

  return workoutList;
}

//cobverts the exercise in a waorkout object into a list of strings

List<List<List<String>>> convertObjectExerciseList(List<Workouts> workouts) {
  //get exercies from each workout
  //fial out put list
  List<List<List<String>>> exerciseList = [];

  //go through the earch work outs
  for (int i = 0; i < workouts.length; i++) {
    //get the exercises from each workout
    List<Exercise> exerciseInWorkouts = workouts[i].exercises;

    List<List<String>> individualWorkout = [];

    for (int j = 0; j < exerciseInWorkouts.length; j++) {
      List<String> individualExercise = [];

      individualExercise.addAll([
        exerciseInWorkouts[j].id.toString(),
        exerciseInWorkouts[j].name,
        exerciseInWorkouts[j].weight.toString(),
        exerciseInWorkouts[j].sets.toString(),
        exerciseInWorkouts[j].reps.toString(),
        exerciseInWorkouts[j].isDone.toString(),
        exerciseInWorkouts[j].timestamp,
        exerciseInWorkouts[j].editedTime
      ]);

      individualWorkout.add(individualExercise);
    }

    exerciseList.add(individualWorkout);
  }

  return exerciseList;
}
