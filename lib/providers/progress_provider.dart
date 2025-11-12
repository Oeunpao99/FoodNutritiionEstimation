import 'package:flutter/material.dart';
import '../models/progress_model.dart';

class ProgressProvider with ChangeNotifier {
  final List<Progress> _progress = [];

  List<Progress> get progress => _progress;

  void addProgress(Progress progress) {
    _progress.add(progress);
    notifyListeners();
  }
}
