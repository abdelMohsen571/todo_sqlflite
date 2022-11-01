import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sqflite/widgets/task_widget_builder.dart';

import '../shared/bloc/todo_cubit.dart';
import '../widgets/task_widget.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).donetasks;
        return TaskWidgetBuilder(tasks);
      },
    );
  }
}
