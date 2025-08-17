import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/features/auth/presentation/Widgets/developers_message.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logos/home_logo.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        MessageLoader.get('app_title'),
                        style: AppTextStyles.titleStyle,
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: LinearProgressIndicator(),
                      ),
                    ],
                  ),
                ),
                const DevelopersMessage(),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });
          return const SizedBox.shrink();
        }

        return Scaffold(
          body: Center(child: Text(MessageLoader.get('error_loading_app'))),
        );
      },
    );
  }
}
