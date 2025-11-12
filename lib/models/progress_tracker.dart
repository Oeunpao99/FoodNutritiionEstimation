// lib/models/progress_tracker.dart

import 'package:fnapp/models/FoodRecord.dart';
 // Import the FoodRecord model file (create it if you haven't)

class ProgressTracker {
  static final List<FoodRecord> _records = [];

  static void addRecord(FoodRecord record) {
    _records.add(record);
  }

  static List<FoodRecord> getRecords() {
    return _records;
  }
}
