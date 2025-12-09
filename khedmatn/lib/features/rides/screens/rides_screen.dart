import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/services/localization_service.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(title: Text(lang.translate('rides'))),
       body: Column(
         children: [
           Expanded(
             flex: 1,
             child: Container(
               color: Colors.blue[50],
               width: double.infinity,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Icon(Icons.map, size: 50, color: Colors.blue),
                   SizedBox(height: 10),
                   Text('Map View (Simulated)'),
                 ],
               ),
             ),
           ),
           Expanded(
             flex: 2,
             child: Container(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(lang.translate('findRide'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 10),
                   Expanded(
                     child: ListView(
                       children: const [
                          Card(
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.person)),
                              title: Text('Tunis -> Aryanah'),
                              subtitle: Text('Leaving in 15 mins • 3 Seats left'),
                              trailing: Text('5 TND', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.person)),
                              title: Text('Marsa -> Centre Ville'),
                              subtitle: Text('Leaving in 30 mins • 1 Seat left'),
                              trailing: Text('7 TND', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                          ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           )
         ],
       ),
       floatingActionButton: FloatingActionButton.extended(
         onPressed: (){},
         icon: const Icon(Icons.add),
         label: Text(lang.translate('createTask')), // Reusing string for "Request Ride"
       ),
    );
  }
}
