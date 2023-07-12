import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartflow/navigation/config.dart';
import 'package:smartflow/screens/home_screen.dart';
import 'package:smartflow/screens/irrigate_screen.dart';
import 'package:smartflow/screens/loading_screen.dart';
import 'package:smartflow/screens/setup_screen.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          name: RouteNames.loading,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const MaterialPage(
              // child: LoadingScreen(),
              child: LoadingScreen(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.home,
              name: RouteNames.home,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage(
                  child: HomeScreen(),
                );
              },
            ),
            GoRoute(
              path: RouteNames.irrigate,
              name: RouteNames.irrigate,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage(
                  child: IrrigateScreen(),
                );
              },
            ),
            GoRoute(
              path: RouteNames.setup,
              name: RouteNames.setup,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage(
                  child: SetupScreen(),
                );
              },
            ),
          ]),
    ],
  );
}
