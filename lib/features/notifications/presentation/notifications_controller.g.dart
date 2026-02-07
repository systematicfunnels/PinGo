// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationsController)
final notificationsControllerProvider = NotificationsControllerProvider._();

final class NotificationsControllerProvider
    extends $NotifierProvider<NotificationsController, List<NotificationItem>> {
  NotificationsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  NotificationsController create() => NotificationsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotificationItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotificationItem>>(value),
    );
  }
}

String _$notificationsControllerHash() =>
    r'0f1d5bf87cf091b781c72798a0d8c34914abc65e';

abstract class _$NotificationsController
    extends $Notifier<List<NotificationItem>> {
  List<NotificationItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<NotificationItem>, List<NotificationItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<NotificationItem>, List<NotificationItem>>,
        List<NotificationItem>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
