// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memberOrganizationsHash() =>
    r'f44a0de5d1de64df94d2411b8dad788c5c40b98b';

/// See also [memberOrganizations].
@ProviderFor(memberOrganizations)
final memberOrganizationsProvider = FutureProvider<List<Organization>>.internal(
  memberOrganizations,
  name: r'memberOrganizationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memberOrganizationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MemberOrganizationsRef = FutureProviderRef<List<Organization>>;
String _$organizationRolesHash() => r'87c509fa63e6e2c02bd872f6648295ddda40e4da';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [organizationRoles].
@ProviderFor(organizationRoles)
const organizationRolesProvider = OrganizationRolesFamily();

/// See also [organizationRoles].
class OrganizationRolesFamily
    extends Family<AsyncValue<List<OrganizationRole>>> {
  /// See also [organizationRoles].
  const OrganizationRolesFamily();

  /// See also [organizationRoles].
  OrganizationRolesProvider call(
    int organizationId,
  ) {
    return OrganizationRolesProvider(
      organizationId,
    );
  }

  @override
  OrganizationRolesProvider getProviderOverride(
    covariant OrganizationRolesProvider provider,
  ) {
    return call(
      provider.organizationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'organizationRolesProvider';
}

/// See also [organizationRoles].
class OrganizationRolesProvider extends FutureProvider<List<OrganizationRole>> {
  /// See also [organizationRoles].
  OrganizationRolesProvider(
    int organizationId,
  ) : this._internal(
          (ref) => organizationRoles(
            ref as OrganizationRolesRef,
            organizationId,
          ),
          from: organizationRolesProvider,
          name: r'organizationRolesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$organizationRolesHash,
          dependencies: OrganizationRolesFamily._dependencies,
          allTransitiveDependencies:
              OrganizationRolesFamily._allTransitiveDependencies,
          organizationId: organizationId,
        );

  OrganizationRolesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationId,
  }) : super.internal();

  final int organizationId;

  @override
  Override overrideWith(
    FutureOr<List<OrganizationRole>> Function(OrganizationRolesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationRolesProvider._internal(
        (ref) => create(ref as OrganizationRolesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationId: organizationId,
      ),
    );
  }

  @override
  FutureProviderElement<List<OrganizationRole>> createElement() {
    return _OrganizationRolesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationRolesProvider &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrganizationRolesRef on FutureProviderRef<List<OrganizationRole>> {
  /// The parameter `organizationId` of this provider.
  int get organizationId;
}

class _OrganizationRolesProviderElement
    extends FutureProviderElement<List<OrganizationRole>>
    with OrganizationRolesRef {
  _OrganizationRolesProviderElement(super.provider);

  @override
  int get organizationId =>
      (origin as OrganizationRolesProvider).organizationId;
}

String _$currentOrganizationHash() =>
    r'a91dd8bd872deb8d0dcaf3598a39082e9e9fecd0';

/// See also [CurrentOrganization].
@ProviderFor(CurrentOrganization)
final currentOrganizationProvider =
    AsyncNotifierProvider<CurrentOrganization, Organization>.internal(
  CurrentOrganization.new,
  name: r'currentOrganizationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentOrganizationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentOrganization = AsyncNotifier<Organization>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
