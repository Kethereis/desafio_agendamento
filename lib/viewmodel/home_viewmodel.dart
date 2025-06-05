import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/post_model.dart';

class HomeViewmodel extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<PostModel>> events = {};

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  void setSelectedDay(DateTime selected, DateTime focused) {
    _selectedDay = selected;
    _focusedDay = focused;
    notifyListeners();
  }

  List<PostModel> getEventsForDay(DateTime day) {
    final date = DateTime.utc(day.year, day.month, day.day);
    return events[date] ?? [];
  }

  Future<void> loadCachedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (final key in keys) {
      final list = prefs.getStringList(key);
      if (list == null) continue;

      final dateParts = key.split('-').map(int.parse).toList();
      final date = DateTime.utc(dateParts[0], dateParts[1], dateParts[2]);

      events[date] = list.map((e) => PostModel.fromJson(jsonDecode(e))).toList();
    }

    notifyListeners();
  }

}
