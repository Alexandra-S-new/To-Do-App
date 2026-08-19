import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesTodo {
  static const _nextIdKey = 'next_todo_id';
  static const _todosKey = 'todos';
  static const _isDarkModeKey = 'isDarkMode';

  Future<int> getNextId() async {
    final prefs = await SharedPreferences.getInstance();
    final nextId = prefs.getInt(_nextIdKey) ?? 1;
    await prefs.setInt(_nextIdKey, nextId + 1);

    return nextId;
  }

  Future<void> saveAll(List<ToDo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _todosKey,
      jsonEncode(todos.map((todo) => todo.toMap()).toList()),
    );
  }

  Future<List<ToDo>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTodos = prefs.getString(_todosKey);
    if (savedTodos == null) {
      return [];
    }
    try {
      final decodedTodos = jsonDecode(savedTodos) as List;
      return decodedTodos.map((todoMap) {
        return ToDo.fromMap(Map<String, dynamic>.from(todoMap));
      }).toList();
    } catch (e) {
      debugPrint('Fehler beim Laden der ToDos: $e');
      return [];
    }
  }

  Future<void> removeAllTodos() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_todosKey);
    await prefs.remove(_nextIdKey);
  }

  static Future<void> setDarkMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, enabled);
  }

  static Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }
}
