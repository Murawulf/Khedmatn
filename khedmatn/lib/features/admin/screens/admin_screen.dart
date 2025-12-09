import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/localization_service.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lang.translate('admin')),
          bottom: TabBar(
            tabs: [
              Tab(text: lang.translate('jobs')),
              Tab(text: lang.translate('payouts')),
              Tab(text: lang.translate('disputes')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ListTile(title: Text('Task #1023 - Delivery'), subtitle: Text('Completed'), trailing: Icon(Icons.check_circle, color: Colors.green)),
                ListTile(title: Text('Task #1024 - Cleaning'), subtitle: Text('In Progress'), trailing: Icon(Icons.timer, color: Colors.orange)),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ListTile(title: Text('Worker: Ahmed'), subtitle: Text('Pending: 150 TND'), trailing: Icon(Icons.payment)),
                ListTile(title: Text('Worker: Samia'), subtitle: Text('Paid: 300 TND'), trailing: Icon(Icons.check, color: Colors.green)),
              ],
            ),
             ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ListTile(title: Text('Dispute #55'), subtitle: Text('Item damaged during delivery'), trailing: Icon(Icons.warning, color: Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
