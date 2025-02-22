import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_drive_clone/core/main_binding.dart';
import 'package:in_drive_clone/features/presentation/controller/location_binding.dart';

import 'features/presentation/page/map_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      initialRoute: HomePage.route,
      getPages: [
        GetPage(
            page: () => const HomePage(),
            name: HomePage.route,
            binding: MapPageBinding())
      ],
    );
  }
}
