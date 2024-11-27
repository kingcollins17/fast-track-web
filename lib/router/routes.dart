import 'package:go_router/go_router.dart';
import 'package:fasttrack_web/routes.dart';

final routerConfig = GoRouter(
  initialLocation: '/accounts',
  routes: [
    accountRoutes,
    orgRoutes,
  ],
);
