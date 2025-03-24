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
    void navigateToWorkoutScreen(String workoutName) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutScreen(workoutName: workoutName)));

    void deleteWorkout(int id) {
      Provider.of<WorkoutData>(context, listen: false).deleteWorkout(id);
    }

    //create workout dialog box
    void createWorkoutDialog(WorkoutDialogType type,
        {int? id, String? currentName}) {
      void saveWorkout() {
        String newWorkoutName = newWorkoutNameController.text;

        if (type == WorkoutDialogType.add) {
          //add to workoutlist
          Provider.of<WorkoutData>(context, listen: false)
              .addWorkout(newWorkoutName);
        } else if (type == WorkoutDialogType.edit && id != null) {
          //update to workoutlist
          Provider.of<WorkoutData>(context, listen: false)
              .updateWorkoutName(id, newWorkoutName);
        }

        //close dialog box and clear controller
        Navigator.pop(context);
        newWorkoutNameController.clear();
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
                      : "Edit Workout: ${currentName.toString()}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: TextField(
                  controller: newWorkoutNameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
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

    final darkTheme = Provider.of<ThemeProvider>(context).isDarkMood;

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
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              label: 'Edit',
                              icon: Icons.edit,
                              onPressed: (context) => createWorkoutDialog(
                                WorkoutDialogType.edit,
                                id: value.workoutsList[index].id,
                                currentName: value.workoutsList[index].name,
                              ),
                            ),
                            SlidableAction(
                              label: 'Delete',
                              icon: Icons.delete,
                              onPressed: (context) =>
                                  deleteWorkout(value.workoutsList[index].id),
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
                            subtitle: Text(formatDateTime(DateTime.parse(
                                    value.getWorkoutsList()[index].timestamp)
                                .toLocal())),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () => navigateToWorkoutScreen(
                                value.getWorkoutsList()[index].name,
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
