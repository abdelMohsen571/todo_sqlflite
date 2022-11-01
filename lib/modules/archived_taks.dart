import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/bloc/todo_cubit.dart';
import '../widgets/task_widget.dart';
import '../widgets/task_widget_builder.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).archivetasks;
        return TaskWidgetBuilder(tasks);
      },
    );
  }
}
