import 'dart:io';

import 'package:flutter/material.dart';

import '../models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<task> tasks = [
    task(id: '1', name: 'Estudiar', progress: 30),
    task(id: '2', name: 'Cocinar', progress: 10),
    task(id: '3', name: 'Limpiar', progress: 15),
    task(id: '4', name: 'Ejercicio', progress: 0)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tareas Diarias',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, int index) {
            return _taskTile(tasks[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 1, onPressed: addNewTask, child: const Icon(Icons.add)));
  }

  Widget _taskTile(task task) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${task.id}');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Borrar tarea",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(task.name.substring(0, 3)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(task.name),
        trailing: Text(
          '${task.progress}' "%",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(task.name);
        },
      ),
    );
  }

  addNewTask() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Nueva Tarea: '),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => addTaskToList(textController.text),
                  elevation: 5,
                  child: const Text("Agregar"),
                  textColor: Colors.blue,
                )
              ],
            );
          });
    }
  }

  void addTaskToList(String name) {
    if (name.length > 1) {
      this.tasks.add(
          new task(id: DateTime.now().toString(), name: name, progress: 20));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
