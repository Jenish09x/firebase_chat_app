import 'package:firebase_chat_app/components/alert_dialog.dart';
import 'package:firebase_chat_app/utils/permission/permission_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  final Permission permission;

  const PermissionHelper._private(this.permission);

  static const PermissionHelper notification = PermissionHelper._private(Permission.notification);
  static const PermissionHelper camera = PermissionHelper._private(Permission.camera);
  static const PermissionHelper location = PermissionHelper._private(Permission.location);
  static const PermissionHelper microphone = PermissionHelper._private(Permission.microphone);
  static const PermissionHelper photos = PermissionHelper._private(kIsWeb ? Permission.unknown : Permission.photos);
  static const PermissionHelper videos = PermissionHelper._private(kIsWeb ? Permission.unknown : Permission.videos);
  static const PermissionHelper storage = PermissionHelper._private(kIsWeb ? Permission.unknown : Permission.storage);

  PermissionResult _getPermissionResult(PermissionStatus status) {
    return switch (status) {
      PermissionStatus.denied => PermissionResult.denied,
      PermissionStatus.granted || PermissionStatus.provisional || PermissionStatus.limited => PermissionResult.granted,
      PermissionStatus.restricted || PermissionStatus.permanentlyDenied => PermissionResult.permanentlyDenied,
    };
  }

  ServiceResult _getServiceResult(ServiceStatus status) {
    return switch (status) {
      ServiceStatus.disabled => ServiceResult.disabled,
      ServiceStatus.enabled => ServiceResult.enabled,
      ServiceStatus.notApplicable => ServiceResult.notApplicable,
    };
  }

  Future<PermissionResult> requestPermission() async {
    if (permission == Permission.unknown) return PermissionResult.granted;
    final status = await permission.request();
    return _getPermissionResult(status);
  }

  Future<PermissionResult> checkPermission() async {
    if (permission == Permission.unknown) return PermissionResult.granted;
    final status = await permission.status;
    return _getPermissionResult(status);
  }

  Future<ServiceResult> checkService() async {
    if (permission is PermissionWithService) {
      final status = await (permission as PermissionWithService).serviceStatus;
      return _getServiceResult(status);
    }
    return ServiceResult.notApplicable;
  }

  static void showPermissionDeniedDialog({required BuildContext context, required String permissionName}) {
    AppAlertDialog.show(
      context: context,
      title: "$permissionName permission denied",
      content:
          "You have permanently denied for $permissionName permission. To enable $permissionName permission please go to site settings and enable $permissionName permission.",
      doneText: "Open Settings",
      onDone: openAppSettings,
    );
  }
}
