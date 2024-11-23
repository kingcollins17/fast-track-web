import 'package:go_router/go_router.dart';

import 'screens/screens.dart';

final accountRoutes = GoRoute(
  path: '/accounts',
  builder: (_, __) => const AuthScreen(),
);
