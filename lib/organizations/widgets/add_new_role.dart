import 'package:fasttrack_web/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fasttrack_web/organizations/api/api.dart';

class AddNewRole extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddNewRole> createState() => _AddNewRoleState();
}

class _AddNewRoleState extends ConsumerState<AddNewRole> {
  final isLoading = false.valueX;
  String? roleName;
  final permissions = {
    'Create Issue': false,
    'Assign Tasks': false,
    'Review Tasks': false,
    'Create Feature': false,
    'Create Teams': false,
    'Assign Teams': false,
    'Assign Roles': false,
    'Send Invite': false,
  };
  final desc = OrganizationRole.descriptions;
  @override
  void initState() {
    super.initState();
    attach(isLoading);
  }

  Future createRole() async {
    if (roleName == null) return;
    final dio = ref.read(dioClientProvider);
    try {
      final response = await OrgMgtApi(dio).createNewRole(
        role: roleName!,
        canAssignTasks: permissions['Assign Tasks']!,
        canReviewTasks: permissions['Review Tasks']!,
        canCreateIssue: permissions['Create Issue']!,
        canCreateFeature: permissions['Create Feature']!,
        canCreateTeams: permissions['Create Teams']!,
        canAssignToTeams: permissions['Assign Teams']!,
        canAssignRoles: permissions['Assign Roles']!,
        canSendInvites: permissions['Send Invite']!,
      );
      ref.read(flusherProvider.notifier).notify('$response');
    } catch (e) {
      ref.read(flusherProvider.notifier).notify('$e');
    } finally {
      isLoading.value = false;
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: spacing * 2, vertical: spacing * 3),
      color: context.colors.surface,
      child: Column(
        children: [
          InputField(
              onChanged: (value) => roleName = value,
              label: 'Role name',
              hint: 'Short name for your role'),
          spacer(y: spacing),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...permissions.keys.map((value) {
                  return CheckboxListTile(
                    value: permissions[value],
                    onChanged: (arg) {
                      setState(() {
                        permissions[value] = arg ?? false;
                      });
                    },
                    title: Text(value),
                    subtitle: Text(
                      desc[value]!,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.onSurface.withOpacity(0.5),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          spacer(y: spacing * 2),
          FilledButton(
            onPressed: () {},
            child: Text(
              'Save Role',
              style: TextStyle(
                fontSize: 16,
                color: context.colors.onSurface.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
