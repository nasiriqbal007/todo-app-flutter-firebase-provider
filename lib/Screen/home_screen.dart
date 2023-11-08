import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/taskModel.dart';
import 'package:todo_app/Provider/auth_provider.dart';
import 'package:todo_app/Provider/task_provider.dart';
import 'package:todo_app/Routes/routes.dart';
import 'package:todo_app/Screen/edit_screen.dart';
import 'package:todo_app/Screen/task_screen.dart';
import 'package:todo_app/Utils/user_status.dart';
import 'package:todo_app/Widgets/customButtons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskServiceProvider taskProvider = TaskServiceProvider();
  String? titleFilter;
  List<Task> allTasks = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final String userId = _auth.currentUser?.uid ?? '';

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text('Your Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 200,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(
                      () {
                        titleFilter = value;
                      },
                    );
                  },
                  decoration: const InputDecoration(
                      labelText: 'Filter by Title',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: taskProvider.taskServices.getTaskStream(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching tasks'));
              } else {
                final tasks = snapshot.data!.docs.map((doc) {
                  return Task.fromJson(doc.data() as Map<String, dynamic>);
                }).toList();

                allTasks = tasks;

                List<Task> filteredTasks = allTasks.where((task) {
                  return titleFilter == null ||
                      titleFilter!.isEmpty ||
                      task.title
                          .toLowerCase()
                          .contains(titleFilter!.toLowerCase());
                }).toList();

                if (titleFilter != null && titleFilter!.isNotEmpty) {
                  // Show tasks outside of categories when a filter is applied
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.amberAccent,
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomIconButton(
                                    icon: Icons.edit,
                                    onPressed: () async {
                                      await taskProvider.updateTask(task);
                                      Get.to(EditScreen(task: task));
                                    }),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await taskProvider.deleteTask(
                                        task.id, userId, task.category);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Show tasks inside categories when no filter is applied
                  var userCategories =
                      Set<String>.from(tasks.map((task) => task.category));
                  var tasksGroupedByCategory = <String, List<Task>>{};

                  for (var category in userCategories) {
                    tasksGroupedByCategory[category] = tasks.where((task) {
                      return task.category == category;
                    }).toList();
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: userCategories.map((category) {
                      List<Task> categoryTasks =
                          tasksGroupedByCategory[category] ?? [];

                      return ExpansionTile(
                        clipBehavior: Clip.hardEdge,
                        collapsedIconColor: Colors.black38,
                        iconColor: Colors.black38,
                        title: Text(
                          category,
                          style: const TextStyle(color: Colors.black),
                        ),
                        children: categoryTasks.map((task) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.amberAccent,
                              child: ListTile(
                                title: Text(task.title),
                                subtitle: Text(task.description),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomIconButton(
                                      icon: Icons.edit,
                                      onPressed: () async {
                                        await taskProvider.updateTask(task);

                                        Get.to(EditScreen(task: task));
                                      },
                                      iconColor: Colors.green,
                                    ),
                                    CustomIconButton(
                                      icon: Icons.delete,
                                      onPressed: () async {
                                        await taskProvider.deleteTask(
                                            task.id, userId, category);
                                      },
                                      iconColor: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const TaskScreen());
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add_task_rounded),
      ),
      drawer: Drawer(
        width: 250,
        child: Container(
          color: Colors.amberAccent,
          child: ListView(
            children: <Widget>[
              Card(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return const Text('Error fetching user data');
                            } else {
                              final Map<String, dynamic>? data = snapshot.data
                                  ?.data() as Map<String, dynamic>?;
                              final String? username = data?['username'];
                              final String? email = data?['email'];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(
                                      Icons.person_outlined,
                                    ),
                                    title: Text(
                                      '$username',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.email),
                                    title: Text(
                                      '$email',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: CustomIconButton(
                                        icon: Icons.logout_outlined,
                                        onPressed: () async {
                                          authProvider.signOut();

                                          await UserStatusChecker
                                              .clearUserData();
                                          Get.offAllNamed(
                                              AppRoutes.loginScreen);
                                        }),
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
