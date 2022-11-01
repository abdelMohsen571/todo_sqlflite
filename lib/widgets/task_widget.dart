import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/shared/bloc/todo_cubit.dart';

class TaskWidget extends StatelessWidget {
  late Map model;

  TaskWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        TodoCubit.get(context).deleteDatabase(model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Center(
              child: CircleAvatar(
                radius: 35,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${model['date']}"),
                    Text("${model['id']}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']} ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${model['time']} ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  TodoCubit.get(context).updateDatabase('done', model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  TodoCubit.get(context).updateDatabase('archive', model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                ))
          ],
        ),
      ),
    );
  }
}
