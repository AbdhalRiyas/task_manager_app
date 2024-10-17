import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_viewmodel.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({required this.task, super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _description = widget.task.description;
  }

  void _editTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<TaskViewModel>(context, listen: false).updateTask(
        Task(
          id: widget.task.id,
          title: _title,
          description: _description,
        ),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task updated successfully: $_title'),
        ),
      );
    }
  }

  void _deleteTask() {
    Provider.of<TaskViewModel>(context, listen: false)
        .deleteTask(widget.task.id!);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted successfully: ${widget.task.title}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            onPressed: _deleteTask,
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length < 3 ||
                      value.length > 50) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _editTask,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: const Text('Edit Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
