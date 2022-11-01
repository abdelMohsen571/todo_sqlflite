import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_taks.dart';
import '../../modules/done_tasks.dart';
import '../../modules/new_tasks.dart';
import '../component.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  static TodoCubit get(context) => BlocProvider.of(context);

  int cuttentIndx = 0;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ["New Tasks", "Done Tasks", "Archived Tasks"];

  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  // Get a location using getDatabasesPath
  //create database
  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)')
          .then((value) => print('Table Created'))
          .catchError((onError) {
        print(onError.toString());
      });
      print('Database Created');
    }, onOpen: (database) {
      getDatabase(database);
      print('Database Opended');
    }).then((value) {
      database = value;
      emit(createDatabaseState());
    });
  }

// insert database
  insertDatabase({
    @required String? title,
    @required String? time,
    @required String? date,
  }) async {
    await database.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO tasks(title , date , time ,status ) VALUES("$title" , "$date" , "$time" , "new" )');
        print("added successed ");
        emit(insertDatabaseState());
        getDatabase(database);
      } catch (e) {
        print("error on insert data");
      }
    });
  }

  getDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        }
        if (element['status'] == 'done') {
          donetasks.add(element);
        }
        if (element['status'] == 'archive') {
          archivetasks.add(element);
        }
      });
      emit(getDatabaseState());
    });
    ;
  }

  // Update some record
  void updateDatabase(@required String status, @required int id) async {
    database.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
      getDatabase(database);
      emit(updateDatabaseState());
    });
  }

  void deleteDatabase(@required int id) async {
    database.rawDelete('DELETE FROM tasks   WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(deleteDatabaseState());
    });
  }

  void changIndex(index) {
    cuttentIndx = index;
    emit(changBottomeNavBar());
  }

  bool bottomsheet = true;
  changeBottomeSheet({required bool isShow}) {
    bottomsheet = isShow;
    emit(changeBottomSheetState());
  }
}
