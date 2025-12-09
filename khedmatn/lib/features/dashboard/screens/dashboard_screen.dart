import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/services/storage_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    final user = context.read<StorageService>().getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.translate('appName')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<StorageService>().clearUser();
              if (context.mounted) Navigator.of(context).pushReplacementNamed('/auth');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, ${user?.name ?? ""}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('${lang.translate(user?.role ?? "client")}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _ServiceCard(
                    title: lang.translate('errands'),
                    icon: Icons.run_circle_outlined,
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, '/errands'),
                  ),
                  _ServiceCard(
                    title: lang.translate('food'),
                    icon: Icons.restaurant_menu,
                    color: Colors.green,
                    onTap: () => Navigator.pushNamed(context, '/food'),
                  ),
                  _ServiceCard(
                    title: lang.translate('rides'),
                    icon: Icons.local_taxi,
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(context, '/rides'),
                  ),
                  if (user?.role == 'admin')
                    _ServiceCard(
                      title: lang.translate('admin'),
                      icon: Icons.admin_panel_settings_outlined,
                      color: Colors.purple,
                      onTap: () => Navigator.pushNamed(context, '/admin'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({required this.title, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.1), // ignoring deprecation for now to ensure compat, or use withValues if supported.
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
