import 'package:go_router/go_router.dart';
import 'screens/screens.dart';

final orgRoutes = GoRoute(
  path: '/organization',
  builder: (_, __) => const SelectOrganization(),
  routes: [
    GoRoute(
      path: 'create',
      builder: (_, __) => const CreateNewOrganization(),
    ),
    GoRoute(path: 'set-roles', builder: (_, __) => const SetOrganizationRoles()),
  ],
);
