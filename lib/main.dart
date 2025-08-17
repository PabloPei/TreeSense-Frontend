import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import '/core/theme/app_theme.dart';
import '/shared/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: MessageLoader.get('app_title'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarySeedColor),
      ),
    );
  }
}
