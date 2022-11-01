part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class changBottomeNavBar extends TodoState {}

class createDatabaseState extends TodoState {}

class getDatabaseState extends TodoState {}

class insertDatabaseState extends TodoState {}

class updateDatabaseState extends TodoState {}

class deleteDatabaseState extends TodoState {}

class changeBottomSheetState extends TodoState {}
