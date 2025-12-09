import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class StorageService {
  static const String taskBoxName = 'tasks';
  static const String userBoxName = 'users';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(taskBoxName);
    await Hive.openBox(userBoxName);
  }

  // Tasks
  Future<void> addTask(TaskModel task) async {
    final box = Hive.box(taskBoxName);
    await box.put(task.id, task.toMap());
  }

  List<TaskModel> getTasks() {
    final box = Hive.box(taskBoxName);
    return box.values.map((e) => TaskModel.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  // Users
  Future<void> saveUser(UserModel user) async {
    final box = Hive.box(userBoxName);
    await box.put('current_user', user.toMap());
  }

  UserModel? getCurrentUser() {
    final box = Hive.box(userBoxName);
    final data = box.get('current_user');
    if (data == null) return null;
    return UserModel.fromMap(Map<String, dynamic>.from(data));
  }
  
  Future<void> clearUser() async {
     final box = Hive.box(userBoxName);
     await box.delete('current_user');
  }
}
