// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:animations/animations.dart';
import 'package:fasttrack_web/organizations/api/api.dart';
import 'package:fasttrack_web/organizations/providers/providers.dart';
import 'package:fasttrack_web/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widgets/widgets.dart';

class SetOrganizationRoles extends ConsumerWidget {
  const SetOrganizationRoles({super.key});

  Future showCreateNewRoleForm(BuildContext context) async {
    return showModal(
        context: context,
        builder: (_) => ModalWrapper(
              alignment: ModalAlignment.center,
              child: AddNewRole(),
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgs = ref.watch(memberOrganizationsProvider);
    if (orgs.isLoading) {
      return LoadingView();
    }
    assert(orgs.hasValue);
    final roles = ref.watch(organizationRolesProvider(
      int.tryParse(context.params['organizationId'] ?? '') ?? orgs.value!.last.id,
    ));
    return Scaffold(
        appBar: AppBar(),
        body: switch (roles) {
          AsyncLoading() => LoadingView(text: 'Fetching Organization Roles'),
          AsyncData(:final value) => ListView(
              padding: EdgeInsets.symmetric(horizontal: spacing * 2, vertical: spacing * 2.5),
              children: [
                Text('Set Roles for your Organization',
                    style: TextStyle(
                      fontSize: spacing * 4,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  'Roles help you manage the actions what members of your organization can perform',
                  style: TextStyle(
                      fontSize: 16,
                      color: context.colors.onSurface.withOpacity(
                        0.5,
                      )),
                ),
                spacer(y: spacing * 4),
                Text('Current Roles', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                spacer(y: spacing * 2),
                ...List.generate(
                  value.length,
                  (i) => RoleWidget(role: value[i]),
                ),
                spacer(y: spacing * 2),
                TextButton.icon(
                  onPressed: () => showCreateNewRoleForm(context),
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedUserAdd01,
                    color: context.colors.primary,
                    size: spacing * 2,
                  ),
                  label: Text('Add new Role', style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          _ => spacer(),
        });
  }
}
