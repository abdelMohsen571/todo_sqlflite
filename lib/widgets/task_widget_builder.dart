import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/widgets/task_widget.dart';

class TaskWidgetBuilder extends StatelessWidget {
  final List<Map> tasks;

  TaskWidgetBuilder(this.tasks);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => TaskWidget(tasks[index]),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
              ),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                color: Colors.grey,
                size: 100,
              ),
              Text(
                "No tasks added yet , pleade add some tasks ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
