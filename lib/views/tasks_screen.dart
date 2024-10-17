import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
  }

  void _addTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTaskScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
      body: _taskList(),
    );
  }

  Widget _taskList() {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        if (taskViewModel.tasks.isEmpty) {
          return const Center(
            child: Text('No tasks found'),
          );
        }
        return ListView.builder(
          itemCount: taskViewModel.tasks.length,
          itemBuilder: (context, index) {
            final task = taskViewModel.tasks[index];
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.all(5),
              child: ListTile(
                title: Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: Text(task.description),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(
                            task: task,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit)),
              ),
            );
          },
        );
      },
    );
  }
}
