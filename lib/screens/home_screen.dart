import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_drawer.dart';
import 'package:workout_app/components/heat_map.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/datetime/date_time.dart';
import 'package:workout_app/screens/workout_screen.dart';
import 'package:workout_app/theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initilaseWorkoutsList();
  }

  @override
  Widget build(BuildContext context) {
    //text controller
    final newWorkoutNameController = TextEditingController();

    //method to clearn controller
    // void clearController() {
    //   newWorkoutNameController.clear();
    // }

    //saving method
    // void saveWorkout() {
    //   String newWorkoutName = newWorkoutNameController.text;
    //   //add workout to list
    //   Provider.of<WorkoutData>(context, listen: false)
    //       .addWorkout(newWorkoutName);
    //   //pop dialog box
    //   Navigator.pop(context);
    //   clearController();
    // }

    //cancel method

    void cancelWorkout() {
      Navigator.pop(context);
    }

    //method to drop into workout screen
    void navigateToWorkoutScreen(int workoutId, String workoutName) =>
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkoutScreen(
                    workoutId: workoutId, workoutName: workoutName)));

    void deleteWorkout(int id) {
      Provider.of<WorkoutData>(context, listen: false).deleteWorkout(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Workout Removed...',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        duration: Duration(seconds: 2),
      ));
    }

    //create workout dialog box
    void createWorkoutDialog(WorkoutDialogType type,
        {int? id, String? currentName}) {
      //form key
      final _formKey = GlobalKey<FormState>();

      //If the user is editing an workout, then take the current (existing) values of that exercise
      if (type == WorkoutDialogType.edit) {
        newWorkoutNameController.text = currentName ?? '';
      }
      void saveWorkout() {
        if (_formKey.currentState!.validate()) {
          String newWorkoutName = newWorkoutNameController.text;

          if (type == WorkoutDialogType.add) {
            //add to workoutlist
            Provider.of<WorkoutData>(context, listen: false)
                .addWorkout(newWorkoutName);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Workout Added...',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              duration: Duration(seconds: 2),
            ));
          } else if (type == WorkoutDialogType.edit && id != null) {
            //update to workoutlist
            Provider.of<WorkoutData>(context, listen: false)
                .updateWorkoutName(id, newWorkoutName);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Workout Updated...',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ));
          }

          //close dialog box and clear controller
          Navigator.pop(context);
          newWorkoutNameController.clear();
        }
      }

      //cancel method
      void cancelWorkout() {
        Navigator.pop(context);
      }

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  type == WorkoutDialogType.add
                      ? 'Add workout'
                      : "Edit Workout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: newWorkoutNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return type == WorkoutDialogType.add
                            ? 'Workout name not added'
                            : 'Workout name not updated';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                actions: [
                  //cancel button
                  MaterialButton(
                    onPressed: cancelWorkout,
                    child: Text('Cancel'),
                  ),
                  //save button
                  MaterialButton(
                    onPressed: saveWorkout,
                    child: Text('Save'),
                  ),
                ],
              ));
    }

    bool isEdited(int id) {
      bool isEdited = Provider.of<WorkoutData>(context, listen: false)
          .workoutEditedTime(id);
      print('Edited: $isEdited');
      return isEdited;
    }

    final darkTheme = Provider.of<ThemeProvider>(context).isDarkMood;

    //If you want to wait for the dialog to finish and do something afterward based on the result,
    // then you should mark your function as async and return a Future.
    // to add best practices

    Future<void> showDeleteConfirmationDialog(int id) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete this item ?'),
            content: Text('Are you sure you want to delete this workout ?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteWorkout(id);
                },
              ),
            ],
          );
        },
      );
    }

    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => createWorkoutDialog(WorkoutDialogType.add),
              child: const Icon(
                Icons.add,
              ),
            ),
            body: ListView(
              children: [
                //heatmap
                HeatMapScreen(
                    datasets: value.heatMapDataSet,
                    startDateYYYYMMDD: value.getStartDate()),
                //list of workouts
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getWorkoutsList().length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => navigateToWorkoutScreen(
                            value.workoutsList[index].id,
                            value.getWorkoutsList()[index].name),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(8.0),
                                label: 'Edit',
                                icon: Icons.edit,
                                onPressed: (context) => createWorkoutDialog(
                                  WorkoutDialogType.edit,
                                  id: value.workoutsList[index].id,
                                  currentName: value.workoutsList[index].name,
                                ),
                              ),
                              SlidableAction(
                                borderRadius: BorderRadius.circular(8.0),
                                label: 'Delete',
                                icon: Icons.delete,
                                onPressed: (context) =>
                                    showDeleteConfirmationDialog(
                                        value.workoutsList[index].id),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: darkTheme
                                    ? Color(0xFFF0FF42)
                                    : Colors.black12),
                            child: ListTile(
                              title: Text(
                                value.getWorkoutsList()[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: isEdited(value.workoutsList[index].id)
                                  ? Text(
                                      'Edited: ${formatDateTime(DateTime.parse(value.getWorkoutsList()[index].editedTime).toLocal())}',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : Text(
                                      'Created: ${formatDateTime(DateTime.parse(value.getWorkoutsList()[index].timestamp).toLocal())}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

enum WorkoutDialogType { add, edit }

//toLocal() is a method in Dart (used with DateTime objects) that converts a UTC time to the local time zone of the device running the app.
