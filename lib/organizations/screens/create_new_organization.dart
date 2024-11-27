// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fasttrack_web/organizations/api/api.dart';
import 'package:fasttrack_web/organizations/providers/providers.dart';
import 'package:fasttrack_web/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateNewOrganization extends ConsumerStatefulWidget {
  const CreateNewOrganization({super.key});

  @override
  ConsumerState<CreateNewOrganization> createState() => _CreateNewOrganizationState();
}

class _CreateNewOrganizationState extends ConsumerState<CreateNewOrganization> {
  final isLoading = false.valueX;
  String? name;
  @override
  void initState() {
    super.initState();
    attach(isLoading);
  }

  Future _create() async {
    try {
      if (name == null) return;
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      final response = await OrgMgtApi(ref.read(dioClientProvider)).createOrganization(name!);
      ref.invalidate(memberOrganizationsProvider);
      ref.read(flusherProvider.notifier).notify(
            '$response',
            context: context,
            duration: 10.sec,
          );
      await Future.delayed(4.sec, () => context.push('/organization/set-roles?organizationId='));
    } catch (e) {
      ref.read(flusherProvider.notifier).notify(
            '$e',
            context: context,
            duration: 10.sec,
            canDismiss: true,
          );
      
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacing * 2, vertical: spacing * 3),
        child: isLoading.value
            ? LoadingView(text: 'We are creating and setting up your organization')
            : Column(
                children: [
                  Text(
                    'Create a New Organization',
                    style: TextStyle(fontSize: spacing * 4, fontWeight: FontWeight.w700),
                  ).left,
                  spacer(),
                  Text(
                    'Create a new Organization to FastTracking with Teams',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colors.onSurface.withOpacity(0.5),
                    ),
                  ).left,
                  spacer(y: spacing * 4),
                  InputField(
                    label: 'Organization name',
                    hint: '',
                    onChanged: (value) => name = value,
                  ),
                  spacer(y: spacing * 5),
                  FilledButton(
                    onPressed: _create,
                    child: Text('Create',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        )),
                  ).left
                ],
              ),
      ),
    );
  }
}
