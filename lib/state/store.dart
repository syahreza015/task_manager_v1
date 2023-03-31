import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_v1/state/actions.dart';

class AppState {
  Database? database;
  MaterialColor themeColor;
  Map<String, dynamic> currentData;
  List<Map<String, dynamic>> data;
  bool isEditing;
  AppState(
      {required this.database,
      required this.themeColor,
      required this.data,
      required this.currentData,
      required this.isEditing});

  factory AppState.initialState() {
    return AppState(
        database: null,
        themeColor: Colors.blueGrey,
        data: [],
        currentData: {},
        isEditing: false);
  }
}

AppState reducer(AppState state, dynamic action) {
  if (action is SetDatabase) {
    return AppState(
        database: action.database,
        themeColor: state.themeColor,
        data: state.data,
        currentData: state.currentData,
        isEditing: state.isEditing);
  } else if (action is SetData) {
    return AppState(
        database: state.database,
        themeColor: state.themeColor,
        data: action.data,
        currentData: state.currentData,
        isEditing: state.isEditing);
  } else if (action is SetTheme) {
    return AppState(
        database: state.database,
        themeColor: action.themeColor,
        data: state.data,
        currentData: state.currentData,
        isEditing: state.isEditing);
  } else if (action is SetCurrentData) {
    return AppState(
        database: state.database,
        themeColor: state.themeColor,
        data: state.data,
        currentData: action.currentData,
        isEditing: state.isEditing);
  } else if (action is SetEditingStatus) {
    return AppState(
        database: state.database,
        themeColor: state.themeColor,
        data: state.data,
        currentData: state.currentData,
        isEditing: !state.isEditing);
  }
  return state;
}

final store = Store(reducer, initialState: AppState.initialState());
