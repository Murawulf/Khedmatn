import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/localization_service.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(title: Text(lang.translate('food'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CookCard(name: 'Fatma\'s Kitchen', specialty: 'Couscous & Brik', rating: 4.8, distance: '1.2 km'),
          _CookCard(name: 'Chef Ahmed', specialty: 'Grilled Fish & Salads', rating: 4.5, distance: '2.5 km'),
          _CookCard(name: 'Sarra Sweets', specialty: 'Tunisian Pastries', rating: 4.9, distance: '0.8 km'),
          _CookCard(name: 'Mami\'s Ojja', specialty: 'Traditional Ojja', rating: 4.2, distance: '3.0 km'),
        ],
      ),
    );
  }
}

class _CookCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final String distance;

  const _CookCard({required this.name, required this.specialty, required this.rating, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Column(
        children: [
          Container(
            height: 120,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.restaurant, size: 50, color: Colors.grey)),
          ),
          ListTile(
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('$specialty • $distance'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(rating.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.white, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
