import 'package:fasttrack_web/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fasttrack_web/organizations/api/api.dart';

class RoleWidget extends StatefulWidget {
  const RoleWidget({super.key, required this.role});
  final OrganizationRole role;

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  final show = false.valueX;
  @override
  void initState() {
    super.initState();
    attach(show);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.role;
    final permissions = data.permissions;
    final desc = OrganizationRole.descriptions;

    return Column(
      children: [
        ListTile(
          onTap: () => show.value = !show.value,
          leading: const HugeIcon(
            icon: HugeIcons.strokeRoundedUserLock01,
            color: mikadoYellow,
            size: spacing * 3,
          ),
          title: Text(widget.role.role, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_back_ios, size: 12).rotate(show.value ? 90 : -90),
          subtitle: Text(
            'Created on ' + (data.createdAt?.readable.split('at').first ?? ''),
            style: TextStyle(
              color: context.colors.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        if (show.value)
          Padding(
            padding: const EdgeInsets.only(left: spacing * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...permissions.keys.map((value) {
                  return CheckboxListTile(
                    value: permissions[value],
                    onChanged: (_) {},
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
          )
      ],
    );
  }
}
