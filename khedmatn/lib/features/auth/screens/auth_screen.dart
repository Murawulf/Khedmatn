import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/localization_service.dart';
import '../../../core/models/user_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _selectedRole = 'client';
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(lang.translate('appName'), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)),
                const SizedBox(height: 10),
                Text(lang.translate('welcome'), style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 40),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: ['client', 'worker', 'admin'].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(lang.translate(role)),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedRole = val!),
                  decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Role'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) return;
                    final user = UserModel(
                      id: const Uuid().v4(),
                      name: _nameController.text,
                      role: _selectedRole,
                    );
                    await context.read<StorageService>().saveUser(user);
                    if (mounted) {
                       Navigator.of(context).pushReplacementNamed('/dashboard');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(lang.translate('login')),
                ),
                const SizedBox(height: 40),
                // Language Switcher
                Text(lang.translate('selectLanguage'), style: const TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () => lang.setLocale('en'), child: const Text('EN')),
                    TextButton(onPressed: () => lang.setLocale('fr'), child: const Text('FR')),
                    TextButton(onPressed: () => lang.setLocale('tn'), child: const Text('TN')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
