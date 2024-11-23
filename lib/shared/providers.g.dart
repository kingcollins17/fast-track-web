// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'988548db85937bf94b83d6a887fb7e171aeb0e03';

/// See also [DioClient].
@ProviderFor(DioClient)
final dioClientProvider = NotifierProvider<DioClient, Dio>.internal(
  DioClient.new,
  name: r'dioClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DioClient = Notifier<Dio>;
String _$flusherHash() => r'68a8328db506a589b66a77c7792e58ac521ea4a2';

/// See also [Flusher].
@ProviderFor(Flusher)
final flusherProvider =
    AutoDisposeNotifierProvider<Flusher, Flushbar?>.internal(
  Flusher.new,
  name: r'flusherProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$flusherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Flusher = AutoDisposeNotifier<Flushbar?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
