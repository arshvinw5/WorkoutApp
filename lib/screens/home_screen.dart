import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/screens/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //text controller
    final newWorkoutNameController = TextEditingController();

    //method to clearn controller
    void clearController() {
      newWorkoutNameController.clear();
    }

    //saving method
    void saveWorkout() {
      String newWorkoutName = newWorkoutNameController.text;
      //add workout to list
      Provider.of<WorkoutData>(context, listen: false)
          .addWorkout(newWorkoutName);
      //pop dialog box
      Navigator.pop(context);
      clearController();
    }

    //cancel method

    void cancelWorkout() {
      Navigator.pop(context);
    }

    //method to drop into workout screen
    void navigateToWorkoutScreen(String workoutName) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutScreen(workoutName: workoutName)));

    //create workout dialog box
    void createWorkoutDialog() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: TextField(
                  controller: newWorkoutNameController,
                  decoration: InputDecoration(
                      labelText: 'Create a workout ?',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                actions: [
                  //save button
                  MaterialButton(
                    onPressed: saveWorkout,
                    child: Text('Save'),
                  ),
                  //cancel button
                  MaterialButton(
                    onPressed: cancelWorkout,
                    child: Text('Cancel'),
                  )
                ],
              ));
    }

    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Workout Tracker',
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: createWorkoutDialog,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: ListView.builder(
                itemCount: value.getWorkoutsList().length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(value.getWorkoutsList()[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => navigateToWorkoutScreen(
                      value.getWorkoutsList()[index].name,
                    ),
                  ),
                ),
              ),
            ));
  }
}
