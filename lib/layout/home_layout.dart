import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sqflite/modules/archived_taks.dart';
import 'package:todo_app_sqflite/modules/done_tasks.dart';
import 'package:todo_app_sqflite/modules/new_tasks.dart';
import 'package:todo_app_sqflite/shared/bloc/todo_cubit.dart';

import '../shared/component.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  final dateFormatter = DateFormat('MMMM dd h:mm a');
  /* @override
  void initState() {
  // TODO: implement initState
  createDatabase();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.cuttentIndx]),
            ),
            body: cubit.screens[cubit.cuttentIndx],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                //setState(() {});
                if (cubit.bottomsheet) {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: Colors.grey[200],
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "title",
                                        prefixIcon: Icon(Icons.title)),
                                    controller: titleController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "title not found ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Time",
                                        prefixIcon: Icon(
                                            Icons.access_time_filled_outlined)),
                                    controller: timeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "time not found ";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 365)))
                                          .then((value) {
                                        dateController.text = DateFormat.yMMMd()
                                            .format(value as DateTime);
                                        //   dateFormatter.format(value as DateTime);
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Date",
                                        prefixIcon: Icon(Icons.calendar_month)),
                                    controller: dateController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "date not found ";
                                      } else {
                                        return null;
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomeSheet(isShow: true);
                    //setState(() {});
                  });
                  cubit.changeBottomeSheet(isShow: false);
                } else {
                  cubit
                      .insertDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text)
                      .then((value) {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      cubit.changeBottomeSheet(isShow: true);
                    }
                  });
                }
              },
              child: cubit.bottomsheet ? (Icon(Icons.edit)) : Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                //setState(() {});
                cubit.changIndex(index);
              },
              currentIndex: cubit.cuttentIndx,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "Taks"),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archive"),
              ],
            ),
          );
        },
      ),
    );
  }
}
