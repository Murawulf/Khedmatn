import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(lang.translate('createTask'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController, 
                decoration: InputDecoration(
                  labelText: lang.translate('taskTitle'),
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descController, 
                decoration: InputDecoration(
                  labelText: lang.translate('taskDesc'),
                   border: OutlineInputBorder()
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _priceController, 
                decoration: InputDecoration(
                  labelText: lang.translate('price'),
                   border: OutlineInputBorder(),
                   suffixText: 'TND'
                ), 
                keyboardType: TextInputType.number
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!)
                ),
                child: Column(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 30),
                    const SizedBox(height: 8),
                    Text(lang.translate('location'), style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('36.8065° N, 10.1815° E (Tunis - Simulated)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), 
                  backgroundColor: Colors.red, 
                  foregroundColor: Colors.white
                ),
                onPressed: () async {
                   if (_titleController.text.isEmpty) return;
                   final task = TaskModel(
                     id: const Uuid().v4(),
                     title: _titleController.text,
                     description: _descController.text,
                     price: double.tryParse(_priceController.text) ?? 0.0,
                     lat: 36.8065, // Tunis
                     lng: 10.1815,
                   );
                   await context.read<StorageService>().addTask(task);
                   if (mounted) Navigator.pop(context);
                },
                child: Text(lang.translate('submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
