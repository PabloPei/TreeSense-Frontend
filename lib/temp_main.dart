// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Ajusta el import a la ruta real de tu HomePage en el feature "table".
import 'package:treesense/features/table/presentation/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        // Ruta temporal de perfil. Reemplazar por tu pantalla real.
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const _TempProfilePage(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TreeSense Web',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      routerConfig: router,
    );
  }
}

class _TempProfilePage extends StatelessWidget {
  const _TempProfilePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text('Perfil (temporal)'))),
    );
  }
}
