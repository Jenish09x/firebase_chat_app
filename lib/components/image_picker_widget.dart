import 'dart:async';
import 'dart:io';

import 'package:firebase_chat_app/core/core.dart';
import 'package:firebase_chat_app/utils/common_button.dart';
import 'package:firebase_chat_app/utils/common_functions.dart';
import 'package:firebase_chat_app/utils/permission/permission_helper.dart';
import 'package:firebase_chat_app/utils/permission/permission_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Widget child;
  final bool multiSelect;
  final bool fromCamera;
  final void Function(File file)? onSelect;
  final void Function(List<File> files)? onMultiSelect;
  final int? selectionLimit;
  final bool isEnable;
  final int? sizeLimit;

  ImagePickerWidget({
    super.key,
    required this.child,
    this.multiSelect = false,
    this.fromCamera = false,
    this.onSelect,
    this.onMultiSelect,
    this.selectionLimit,
    this.isEnable = true,
    this.sizeLimit,
  }) {
    if (onSelect != null && onMultiSelect != null) {
      throw ArgumentError("Only one callback function can be provided.");
    }
    if (multiSelect && fromCamera) {
      throw ArgumentError("Multi select work on only from gallery");
    }
  }

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonButton.cupertino(
      onTap: widget.isEnable
          ? () {
              ImagePickerHelper().pickImage(
                multiSelect: widget.multiSelect,
                context: context,
                source: widget.fromCamera ? ImageSource.camera : ImageSource.gallery,
                onMultiSelect: widget.onMultiSelect,
                onSelect: widget.onSelect,
                sizeLimit: widget.sizeLimit,
              );
            }
          : null,
      child: widget.child,
    );
  }
}

class ImagePickerHelper {
  ImagePickerHelper._();

  static final ImagePickerHelper instance = ImagePickerHelper._();

  factory ImagePickerHelper() => instance;

  Future<void> pickImage({
    bool multiSelect = false,
    Function(File file)? onSelect,
    Function(List<File> files)? onMultiSelect,
    required BuildContext context,
    required ImageSource source,
    required int? sizeLimit,
  }) async {
    final LoadingDialogHandler loadingDialogHandler = LoadingDialogHandler(context: context);
    if (onSelect != null && onMultiSelect != null) {
      throw ArgumentError("Only one callback function can be provided.");
    }

    if (await _resolvePermission(source, context)) {
      final ImagePicker picker = ImagePicker();
      if (multiSelect) {
        loadingDialogHandler.handleLoading(true);

        final List<XFile> images = await picker.pickMultiImage(imageQuality: 60);

        if (images.isNotEmpty && onMultiSelect != null) {
          if (await checkSizeLimit(files: images, sizeLimit: sizeLimit)) {
            loadingDialogHandler.handleLoading(false);
            onMultiSelect(images.map((e) => File(e.path)).toList());
          } else {
            context.showErrorMessage(title: "Image size must be less than $sizeLimit MB");
          }
        }
      } else {
        final XFile? image = await picker.pickImage(source: source, imageQuality: 60);

        if (image != null && onSelect != null && context.mounted) {
          if (await checkSizeLimit(files: [image], sizeLimit: sizeLimit)) {
            loadingDialogHandler.handleLoading(false);
            onSelect(File(image.path));
          } else {
            context.showErrorMessage(title: "Image size must be less than $sizeLimit MB");
          }
        }
      }
    }
  }

  Future<bool> checkSizeLimit({int? sizeLimit, required List<XFile> files}) async {
    if (sizeLimit == null) return true;
    var maxFileSizeInBytes = sizeLimit * 1048576;
    for (int i = 0; i < files.length; i++) {
      var fileSize = await files[i].length();
      if (!(fileSize <= maxFileSizeInBytes)) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _resolvePermission(ImageSource source, BuildContext context) async {
    switch (source) {
      case ImageSource.camera:
        return _requestPermissionStatus(PermissionHelper.camera, "Camera", context);
      case ImageSource.gallery:
        if (!kIsWeb && Platform.isAndroid) {
          if (await CommonFunc.getAndroidVersion() < 33 && context.mounted) {
            return _requestPermissionStatus(PermissionHelper.storage, "Storage", context);
          }
        }
        return _requestPermissionStatus(PermissionHelper.photos, "Photos", context);
    }
  }

  Future<bool> _requestPermissionStatus(
    PermissionHelper permissionHelper,
    String permissionName,
    BuildContext context,
  ) async {
    PermissionResult permissionResult = await permissionHelper.requestPermission();
    switch (permissionResult) {
      case PermissionResult.granted:
        return true;
      case PermissionResult.denied || PermissionResult.permanentlyDenied:
        if (context.mounted) {
          PermissionHelper.showPermissionDeniedDialog(context: context, permissionName: permissionName);
        }
    }
    return false;
  }
}
