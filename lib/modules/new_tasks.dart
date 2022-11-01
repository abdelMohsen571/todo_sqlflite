import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqflite/shared/bloc/todo_cubit.dart';
import 'package:todo_app_sqflite/widgets/task_widget_builder.dart';

import '../widgets/task_widget.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).newtasks;
        return TaskWidgetBuilder(tasks);
      },
    );
  }
}
