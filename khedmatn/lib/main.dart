import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/services/storage_service.dart';
import 'core/services/localization_service.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/errands/screens/errands_screen.dart';
import 'features/errands/screens/create_task_screen.dart';
import 'features/food/screens/food_screen.dart';
import 'features/rides/screens/rides_screen.dart';
import 'features/admin/screens/admin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  await storageService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storageService),
        ChangeNotifierProvider(create: (_) => LocalizationService()),
      ],
      child: const KhedmatnApp(),
    ),
  );
}

class KhedmatnApp extends StatelessWidget {
  const KhedmatnApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationService>(context);
    
    // Check user on each build is not ideal for nav, but ok for home decision here
    // Better to use a Stream or Consumer in a real app
    final user = context.read<StorageService>().getCurrentUser();

    return MaterialApp(
      title: 'Khedmatn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE70013)), // Tunisia Red
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      locale: localization.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        // Locale('tn'), // 'tn' is Tswana. Flutter might be confused if we expect Arabic behavior.
        // We will map 'tn' to 'en' behavior for widgets but use our custom strings.
      ],
      // If locale is 'tn', we might need to rely on fallback for Material widgets or implement a delegate.
      // For simplicity, we won't crash if 'tn' is passed to MaterialApp, 
      // but let's see if it's safe. It is safer to just use en/fr in supportedLocales 
      // and handle our custom translation manually.
      // But we passed 'tn' in the service.
      
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: user == null ? const AuthScreen() : const DashboardScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/errands': (context) => const ErrandsScreen(),
        '/errands/create': (context) => const CreateTaskScreen(),
        '/food': (context) => const FoodScreen(),
        '/rides': (context) => const RidesScreen(),
        '/admin': (context) => const AdminScreen(),
      },
    );
  }
}