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

  //saving method
  void saveExercise() {
    String newExerciseController = exerciseNameController.text;
    String newWeightController = weightController.text;
    String newSetsController = setsController.text;
    String newRepsController = repsController.text;

    //add workout to list
    Provider.of<WorkoutData>(context, listen: false).addExerciseToWorkout(
        //add to exercise list so we need to convert the string to neccesary type of data
        widget.workoutName,
        newExerciseController,
        double.parse(newWeightController),
        int.parse(newSetsController),
        int.parse(newRepsController));
    //pop dialog box
    Navigator.pop(context);
    clearController();
  }

  //cancel method
  void cancelExercise() {
    Navigator.pop(context);
  }

  //method to clearn controller
  void clearController() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  //to create a new exrcise
  void createNewExercise() {
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
                onPressed: createNewExercise,
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
                            onCheckBoxFunction: (value) => onCheckBoxFunction(
                                widget.workoutName,
                                workouts.exercises[index].name)),
                      );
                    }
                  }),
            ));
  }
}
