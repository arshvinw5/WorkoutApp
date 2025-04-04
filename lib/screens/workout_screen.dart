import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/exercises_title.dart';
import 'package:workout_app/data/workout_data.dart';

class WorkoutScreen extends StatefulWidget {
  final int workoutId;
  final String workoutName;
  const WorkoutScreen(
      {super.key, required this.workoutName, required this.workoutId});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  //to tap the checkbox
  void onCheckBoxFunction(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  //text controller
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();

  //method to clearn controller
  void clearController() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  bool isEditedTime(int workoutId, int exerciseId) {
    bool isEdited = Provider.of<WorkoutData>(context, listen: false)
        .exercisEditedTime(workoutId, exerciseId);

    print('Edited: $isEdited');
    return isEdited;
  }

  //to delete exercise
  void deleteExercise(int workoutId, int exerciseId) {
    Provider.of<WorkoutData>(context, listen: false)
        .deleteExercise(workoutId, exerciseId);
  }

  //to create a new exrcise
  void createNewExercise(
    ExerciseDialogType type, {
    int? workoutId,
    int? exerciseId,
    String? newExerciseName,
    double? newWeight,
    int? newSets,
    int? newReps,
  }) {
    //saving method
    void saveExercise() {
      String newExerciseController = exerciseNameController.text;
      String newWeightController = weightController.text;
      String newSetsController = setsController.text;
      String newRepsController = repsController.text;

      if (type == ExerciseDialogType.add) {
        //add workout to list
        Provider.of<WorkoutData>(context, listen: false).addExerciseToWorkout(
            //add to exercise list so we need to convert the string to neccesary type of data
            widget.workoutName,
            newExerciseController,
            double.parse(newWeightController),
            int.parse(newSetsController),
            int.parse(newRepsController));
      } else if (type == ExerciseDialogType.edit) {
        //update to exercise list
        Provider.of<WorkoutData>(context, listen: false).updateExercise(
            widget.workoutId,
            exerciseId!,
            newExerciseController,
            double.parse(newWeightController),
            int.parse(newSetsController),
            int.parse(newRepsController));
      }

      //pop dialog box
      Navigator.pop(context);
      clearController();
    }

    //cancel method
    void cancelExercise() {
      Navigator.pop(context);
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add exercise'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //text field for exercise name
                  TextField(
                    controller: exerciseNameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //text field for weight
                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //text field for sets
                  TextField(
                    controller: setsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Sets',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //text field for reps
                  TextField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Reps',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ))
                ],
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: saveExercise,
                  child: Text('Save'),
                ),
                //cancel button
                MaterialButton(
                  onPressed: cancelExercise,
                  child: Text('Cancel'),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () => createNewExercise(ExerciseDialogType.add),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
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
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExercisesTitle(
                            exerciseName: workouts.exercises[index].name,
                            weight: workouts.exercises[index].weight,
                            sets: workouts.exercises[index].sets,
                            reps: workouts.exercises[index].reps,
                            isDone: workouts.exercises[index].isDone,
                            onCheckBoxFunction: (_) => onCheckBoxFunction(
                                widget.workoutName,
                                workouts.exercises[index].name),
                            onDeleteFunction: () => deleteExercise(
                                widget.workoutId, workouts.exercises[index].id),
                            dateTime: workouts.exercises[index].timestamp,
                            onEditFunction: () => createNewExercise(
                              ExerciseDialogType.edit,
                              workoutId: widget.workoutId,
                              exerciseId: workouts.exercises[index].id,
                              newExerciseName: workouts.exercises[index].name,
                              newWeight: workouts.exercises[index].weight,
                              newSets: workouts.exercises[index].sets,
                              newReps: workouts.exercises[index].reps,
                            ),
                            isEdited: isEditedTime(
                                widget.workoutId, workouts.exercises[index].id),
                            editedDateTime:
                                workouts.exercises[index].editedTime,
                          ));
                    }
                  }),
            ));
  }
}

enum ExerciseDialogType { add, edit }
