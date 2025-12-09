import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/models/task_model.dart';

class ErrandsScreen extends StatefulWidget {
  const ErrandsScreen({super.key});

  @override
  State<ErrandsScreen> createState() => _ErrandsScreenState();
}

class _ErrandsScreenState extends State<ErrandsScreen> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    final storage = context.read<StorageService>();
    final user = storage.getCurrentUser();
    final tasks = storage.getTasks();

    return Scaffold(
      appBar: AppBar(title: Text(lang.translate('errands'))),
      body: ListView.builder(
        itemCount: tasks.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: task.status == 'pending' ? Colors.orange[100] : Colors.green[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(task.status.toUpperCase(), style: TextStyle(fontSize: 12, color: Colors.black87)),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(task.description),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('GPS: ${task.lat.toStringAsFixed(4)}, ${task.lng.toStringAsFixed(4)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${task.price} TND', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16)),
                      if (user?.role == 'worker' && task.status == 'pending')
                        ElevatedButton(
                          onPressed: () async {
                            // Update task
                            final updatedTask = TaskModel(
                               id: task.id,
                               title: task.title,
                               description: task.description,
                               price: task.price,
                               lat: task.lat,
                               lng: task.lng,
                               status: 'assigned',
                               workerId: user?.id,
                            );
                            await storage.addTask(updatedTask);
                            setState(() {});
                          },
                          child: const Text('Accept'),
                        )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: user?.role == 'client'
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/errands/create');
                setState(() {});
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
