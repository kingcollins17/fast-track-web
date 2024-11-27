// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:fasttrack_web/organizations/api/api.dart';
import 'package:fasttrack_web/organizations/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fasttrack_web/shared/shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class SelectOrganization extends ConsumerWidget {
  const SelectOrganization({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgs = ref.watch(memberOrganizationsProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(spacing * 3.0),
          child: switch (orgs) {
            AsyncLoading() => LoadingView(text: 'We are fetching your Organizations...'),
            AsyncData(:final value) => value.isEmpty
                ? _NoOrgFound()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      spacer(y: spacing * 2),
                      Text(
                        'Select your Organization',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: spacing * 4, fontWeight: FontWeight.w700),
                      ),
                      spacer(),
                      Text(
                        'Organizations are like your workspace, '
                        'they serve as the central point of your project management',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colors.onSurface.withOpacity(0.5),
                        ),
                      ),
                      spacer(y: spacing * 3),
                      _OrgSelector(),
                      spacer(y: spacing * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            label: Text('Create new'),
                            onPressed: () => context.go('/organization/create'),
                            icon: Icon(HugeIcons.strokeRoundedFileAdd),
                          ).left,
                          FilledButton(
                              onPressed: () {},
                              child: Text(
                                'Select',
                                style: TextStyle(color: context.colors.onSurface.withOpacity(0.8)),
                              ))
                        ],
                      ),
                      spacer(y: spacing * 4),
                    ],
                  ),
            AsyncError(:final error) => Text('$error'),
            _ => spacer(),
          }),
    );
  }
}

class _OrgSelector extends ConsumerWidget {
  const _OrgSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentOrganizationProvider.notifier);
    final orgs = ref.watch(memberOrganizationsProvider) as AsyncData<List<Organization>>;
    return DropdownButtonFormField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      value: orgs.value.first,
      items: List.generate(
        orgs.value.length,
        (index) => DropdownMenuItem(
          value: orgs.value[index],
          child: Row(
            children: [
              HugeIcon(icon: orgIcon, color: mikadoYellow, size: spacing * 2),
              spacer(y: 0, x: spacing),
              Text(orgs.value[index].name),
            ],
          ),
        ),
      ),
      onChanged: current.setCurrent,
    );
  }
}

class _NoOrgFound extends StatelessWidget {
  const _NoOrgFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You are not part of any Organizations',
          style: TextStyle(fontSize: spacing * 3, fontWeight: FontWeight.w700),
        ).left,
        spacer(),
        Text(
          'Create your own organization',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            color: context.colors.onSurface.withOpacity(0.6),
          ),
        ).left,
        spacer(y: spacing * 2),
        TextButton.icon(
          label: Text('Create new'),
          onPressed: () => context.go('/organization/create'),
          icon: Icon(HugeIcons.strokeRoundedFileAdd),
        ).left,
      ],
    );
  }
}
