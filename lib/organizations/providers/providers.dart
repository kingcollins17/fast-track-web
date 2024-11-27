import 'package:fasttrack_web/accounts/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fasttrack_web/shared/shared.dart';

import 'package:fasttrack_web/providers.dart';

import '../api/api.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<Organization>> memberOrganizations(MemberOrganizationsRef ref) async {
  await ref.read(authProvider.future);
  final authState = ref.watch(authProvider) as AsyncData<AuthState>;
  assert(authState.value.isAuthenticated, 'You are not signed in');
  return OrgMgtApi(ref.read(dioClientProvider)).fetchMemberOrganizations();
}

@Riverpod(keepAlive: true)
class CurrentOrganization extends _$CurrentOrganization with SaveableState<Organization> {
  @override
  Future<Organization> build() async {
    await ref.read(memberOrganizationsProvider.future);
    final orgs = ref.watch(memberOrganizationsProvider);
    assert(orgs is AsyncData && orgs.value != null, 'memberOrganizationsProvider must have data');
    assert(orgs.value?.isNotEmpty ?? false, 'You are not part of any Organizations');
    return orgs.value!.last;
  }

  void setCurrent(Organization? value) {
    if (value == null) return;
    state = AsyncValue.data(value);
    save();
  }

  @override
  Organization fromJson(json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  String get key => 'currentOrganization';

  @override
  Map<String, dynamic> toJson(Organization state) {
    return {'id': state.id, 'name': state.name, 'createdAt': state.createdAt.toString()};
  }

  @override
  Organization get value => state.value!;
}

@Riverpod(keepAlive: true)
Future<List<OrganizationRole>> organizationRoles(
  OrganizationRolesRef ref,
  int organizationId,
) async {
  final dio = ref.watch(dioClientProvider);
  return OrgMgtApi(dio).fetchOrganizationRoles(organizationId);
}
