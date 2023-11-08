// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/taskModel.dart';
import 'package:todo_app/Provider/task_provider.dart';
import 'package:todo_app/Screen/home_screen.dart';
import 'package:todo_app/Widgets/custom_taskform.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.task});
  final Task task;
  @override
  State<EditScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<EditScreen> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController categoryController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing task details
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    categoryController = TextEditingController(text: widget.task.category);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskServiceProvider>(
      context,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Update Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTaskForm(
                      controller: titleController, labelText: 'Title'),
                  CustomTaskForm(
                    controller: descriptionController,
                    labelText: 'Description',
                    maxLines: 10,
                  ),
                  CustomTaskForm(
                      controller: categoryController, labelText: 'Category'),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer(
                      builder: (BuildContext context, value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 258.0,
                      ),
                      child: Card(
                          elevation: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: ElevatedButton(
                                onPressed: () async {
                                  final String userId = _auth.currentUser!.uid;
                                  await taskProvider.updateTask(Task(
                                      id: widget.task.id,
                                      userId: userId,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      category: categoryController.text));
                                  await Future.delayed(Duration.zero);

                                  Get.to(const HomeScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.deepOrangeAccent,
                                ),
                                child: const Text("save")),
                          )),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
