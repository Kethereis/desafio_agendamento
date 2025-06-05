import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/post_model.dart';

class SchedulingViewModel extends ChangeNotifier {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  void pickDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (date != null) {
      selectedDate = date;
      final formattedDate = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
      dateController.text = formattedDate;
      notifyListeners();
    }

  }

  void pickTime(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      selectedTime = time;
      timeController.text = time.format(context);
      notifyListeners();
    }
  }

  Future<void> savePostToCache() async {
    if (selectedDate == null || selectedTime == null) return;

    final randomIndex = Random().nextInt(5) + 1;

    final newPost = PostModel(
      title: titleController.text,
      subtitle: subtitleController.text,
      date: dateController.text,
      hour: timeController.text,
      image: 'assets/img_$randomIndex.jpg',
    );

    final prefs = await SharedPreferences.getInstance();

    final key = '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';

    final currentListJson = prefs.getStringList(key) ?? [];
    currentListJson.add(jsonEncode(newPost.toJson()));

    await prefs.setStringList(key, currentListJson);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }
}
