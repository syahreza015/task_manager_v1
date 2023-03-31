import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SetDatabase {
  Database database;
  SetDatabase({required this.database});
}

class SetData {
  List<Map<String, dynamic>> data;
  SetData({required this.data});
}

class SetTheme {
  MaterialColor themeColor;
  SetTheme({required this.themeColor});
}

class SetCurrentData {
  Map<String, dynamic> currentData;
  SetCurrentData({required this.currentData});
}

class SetEditingStatus {}
