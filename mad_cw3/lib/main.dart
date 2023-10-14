import 'package:flutter/material.dart';
import 'dart:async';

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class DailyTask {
  String day;
  List<Task> tasks;

  DailyTask({required this.day, required this.tasks});
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
    home: TaskListScreen(),
  ));
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<DailyTask> dailyTasks = [];
  String currentDay = ''; // Store the current day being edited

  final TextEditingController _textController = TextEditingController();
  bool showMessage = false;

  void addTask(String taskName) {
    if (currentDay.isEmpty) {
      // If no day is selected, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a day'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      // Find the DailyTask for the current day or create a new one
      var dailyTask = dailyTasks.firstWhere(
            (task) => task.day == currentDay,
        orElse: () {
          final newDailyTask = DailyTask(day: currentDay, tasks: []);
          dailyTasks.add(newDailyTask);
          return newDailyTask;
        },
      );
      dailyTask.tasks.add(Task(name: taskName));
    });
    _textController.clear();
  }

  void toggleTaskCompletion(int dayIndex, int taskIndex) {
    setState(() {
      dailyTasks[dayIndex].tasks[taskIndex].isCompleted =
      !dailyTasks[dayIndex].tasks[taskIndex].isCompleted;
    });

    // Display "Task is completed" for 2 seconds
    showMessage = true;
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showMessage = false;
      });
      // Schedule the task deletion after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        deleteTask(dayIndex, taskIndex);
      });
    });
  }

  void deleteTask(int dayIndex, int taskIndex) {
    setState(() {
      dailyTasks[dayIndex].tasks.removeAt(taskIndex);
    });
  }

  void deleteDay(int dayIndex) {
    setState(() {
      dailyTasks.removeAt(dayIndex);
    });
  }

  void updateTaskName(int dayIndex, int taskIndex, String newName) {
    setState(() {
      dailyTasks[dayIndex].tasks[taskIndex].name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: dailyTasks.isEmpty
          ? Center(
        child: Text(
          'No Tasks',
          style: TextStyle(fontSize: 24),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dailyTasks.length,
              itemBuilder: (context, dayIndex) {
                final dailyTask = dailyTasks[dayIndex];
                return ExpansionTile(
                  title: Row(
                    children: [
                      Text(dailyTask.day),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteDay(dayIndex);
                        },
                      ),
                    ],
                  ),
                  children: dailyTask.tasks.map((task) {
                    final taskIndex = dailyTask.tasks.indexOf(task);
                    return ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (bool? value) {
                          toggleTaskCompletion(dayIndex, taskIndex);
                        },
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: TextEditingController()
                                ..text = task.name,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'Task description',
                                contentPadding: EdgeInsets.zero, // Remove padding
                                focusedBorder: InputBorder.none, // Remove underline
                                enabledBorder: InputBorder.none, // Remove underline
                              ),
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: task.isCompleted
                                    ? Colors.grey
                                    : null,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String updatedTaskName = task.name;
                                  return AlertDialog(
                                    title: Text('Edit Task'),
                                    content: TextField(
                                      onChanged: (value) {
                                        updatedTaskName = value;
                                      },
                                      controller: TextEditingController()
                                        ..text = task.name,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Update'),
                                        onPressed: () {
                                          updateTaskName(
                                              dayIndex, taskIndex, updatedTaskName);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              deleteTask(dayIndex, taskIndex);
                            },
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          if (showMessage)
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Task is completed',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final taskName = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );

          if (taskName != null) {
            addTask(taskName);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Day: $currentDay'),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Show a dialog to select the day
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select a Day'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('Monday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Monday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Tuesday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Tuesday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Wednesday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Wednesday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Thursday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Thursday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Friday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Friday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Saturday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Saturday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: Text('Sunday'),
                              onTap: () {
                                setState(() {
                                  currentDay = 'Sunday';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Select Day'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter task name...',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final taskName = _textController.text.trim();
                Navigator.pop(context, taskName);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}