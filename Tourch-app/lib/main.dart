import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:touchapp/screens/HomePage.dart';
import 'package:touchapp/screens/test.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await TorchController().initialize;
  WidgetsFlutterBinding.ensureInitialized();
  final PermissionStatus status = await Permission.camera.request();
  switch (status) {
    case PermissionStatus.granted:
      print('Torch permission granted');
      // Now you can safely use the torch functionality
      runApp(
          const MyApp()); // Assuming you have this function for toggling the torch
      break;
    case PermissionStatus.denied:
      print('Torch permission denied');
      // Handle the case where permission is denied (e.g., show a message)
      break;
    case PermissionStatus.permanentlyDenied:
      print('Torch permission permanently denied');
      // Handle the case where permission is permanently denied (e.g., open app settings)
      await openAppSettings(); // Open app settings to allow user to change permissions
      break;
    case PermissionStatus.restricted:
      print('Torch permission restricted');
      // Handle the case where the permission is restricted (e.g., on a managed device)
      break;
    default:
      print('Unknown permission status');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Torch Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePge(),
    );
  }
}
