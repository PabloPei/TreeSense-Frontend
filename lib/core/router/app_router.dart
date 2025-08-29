import 'package:go_router/go_router.dart';
import 'package:treesense/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/auth/presentation/pages/password_page.dart';
import 'package:treesense/features/auth/presentation/pages/splash_page.dart';
import 'package:treesense/features/auth/presentation/state/auth_provider.dart';
import 'package:treesense/features/user/presentation/pages/user_profile_page.dart';
import 'package:treesense/features/table/presentation/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final ref = ProviderScope.containerOf(context);

      return await AuthGuard.guardRoutes(context, state, ref);
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const UserProfilePage(),
      ),
    ],
  );
}

class AuthGuard {
  static final AuthStorage _authStorage = AuthStorage();

  static Future<String?> guardRoutes(
    BuildContext context,
    GoRouterState state,
    ProviderContainer ref,
  ) async {
    final isLoginRoute = state.uri.path == '/login';
    final isSplashRoute = state.uri.path == '/splash';

    if (isSplashRoute) return null;

    final refreshTokenUseCase = ref.read(refreshTokenProvider);

    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      return '/login';
    }

    final accessTokenExpired = await _authStorage.isAccessTokenExpired();

    bool isAuthenticated = !accessTokenExpired;

    if (accessTokenExpired) {
      try {
        await refreshTokenUseCase();
        isAuthenticated = true;
      } catch (_) {
        isAuthenticated = false;
      }
    }

    if (!isAuthenticated && !isLoginRoute) {
      return '/login';
    }

    if (isAuthenticated && isLoginRoute) {
      return '/home';
    }

    return null;
  }
}
