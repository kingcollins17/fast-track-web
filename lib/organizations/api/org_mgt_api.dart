import 'package:dio/dio.dart';
import 'package:fasttrack_web/organizations/api/api.dart';

import 'package:fasttrack_web/shared/shared.dart';

enum OrgType { standard, enterprise }

class OrgMgtApi extends BaseApi {
  OrgMgtApi(super.dio);

  Future createNewRole({
    required String role,
    required bool canAssignTasks,
    required bool canReviewTasks,
    required bool canCreateIssue,
    required bool canCreateFeature,
    required bool canCreateTeams,
    required bool canAssignToTeams,
    required bool canAssignRoles,
    required bool canSendInvites,
  }) async {
    final Response(:data, :statusCode) = await dio.post('', data: {
      "role": role,
      "can_assign_tasks": canAssignTasks,
      "can_review_tasks": canReviewTasks,
      "can_create_issue": canCreateIssue,
      "can_create_feature": canCreateFeature,
      "can_create_teams": canCreateTeams,
      "can_assign_to_teams": canAssignToTeams,
      "can_assign_roles": canAssignRoles,
      "can_send_invites": canSendInvites,
    });
    if (statusCode != 200) {
      throw BaseApiException(
        message: data['detail'].toString(),
        statusCode: statusCode!,
      );
    }
    return data['detail'].toString();
  }

  Future<List<OrganizationRole>> fetchOrganizationRoles(int orgId) async {
    final Response(:data, :statusCode) = await dio.get(
      '$url/organization/roles/all/$orgId',
    );
    if (statusCode != 200) {
      throw BaseApiException(
        message: data['detail'].toString(),
        statusCode: statusCode!,
      );
    }
    return (data['data'] as List).map((value) => OrganizationRole.fromJson(value)).toList();
  }

  Future createOrganization(String name, [OrgType type = OrgType.standard]) async {
    final Response(:data, :statusCode) = await dio.post(
      '$url/organization/create',
      queryParameters: {'name': name, 'type': type.name},
    );
    if (statusCode != 200) {
      throw BaseApiException(
        message: data['detail'].toString(),
        statusCode: statusCode!,
      );
    }
    return data['detail'].toString();
  }

  Future<List<Organization>> fetchMemberOrganizations({int page = 1, int perPage = 100}) async {
    final Response(:data, :statusCode) = await dio.get(
      '$url/organization/part',
      queryParameters: {'page': page, 'per_page': perPage},
    );
    if (statusCode != 200) {
      throw BaseApiException(
        message: data['detail'].toString(),
        statusCode: statusCode!,
      );
    }
    return (data['data'] as List)
        .map(
          (value) => Organization(
            id: value['id'],
            name: value['organization_name'],
            createdAt: DateTime.parse(value['created_at']),
          ),
        )
        .toList();
  }
}

final class Organization {
  final int id;
  final String name;
  final DateTime createdAt;

  Organization({required this.id, required this.name, required this.createdAt});
}

final class OrganizationRole {
  final int id;
  final String role;
  final bool canCreateIssue,
      canAssignTasks,
      canReviewTasks,
      canCreateFeature,
      canCreateTeams,
      canAssignToTeams,
      canAssignRoles,
      canSendInvites;

  final DateTime? createdAt;

  OrganizationRole({
    required this.id,
    required this.role,
    required this.canCreateIssue,
    required this.canAssignTasks,
    required this.canReviewTasks,
    required this.canCreateFeature,
    required this.canCreateTeams,
    required this.canAssignToTeams,
    required this.canAssignRoles,
    required this.canSendInvites,
    this.createdAt,
  });

  factory OrganizationRole.fromJson(value) => OrganizationRole(
        id: value['id'],
        role: value['role'],
        canCreateIssue: value['can_create_issue'],
        canAssignTasks: value['can_assign_tasks'],
        canReviewTasks: value['can_review_tasks'],
        canCreateFeature: value['can_create_feature'],
        canCreateTeams: value['can_create_teams'],
        canAssignToTeams: value['can_assign_to_teams'],
        canAssignRoles: value['can_assign_roles'],
        canSendInvites: value['can_send_invites'],
        createdAt: DateTime.tryParse(value['created_at']),
      );
  Map<String, bool> get permissions => {
        'Create Issue': canCreateIssue,
        'Assign Tasks': canAssignTasks,
        'Review Tasks': canReviewTasks,
        'Create Feature': canCreateFeature,
        'Create Teams': canCreateTeams,
        'Assign Teams': canAssignToTeams,
        'Assign Roles': canAssignRoles,
        'Send Invite': canSendInvites
      };
  static Map<String, String> get descriptions => {
        'Create Issue': 'Members can create an Issue in your Organization',
        'Assign Tasks': 'Members can assign Tasks in your Organization',
        'Review Tasks': 'Members can Review Tasks in your Organization',
        'Create Feature': 'Members can create a new feature in your Projects',
        'Create Teams': 'Membes can create new Teams',
        'Assign Teams': 'Members can assign other members to Teams',
        'Assign Roles': 'Members can assign Roles to other Members',
        'Send Invite': 'Members can invite other people to your organization'
      };
}
