import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

/// Reusable Image Picker and Cropper Module
class ImagePickerCropperModule {
  static final ImagePicker _imagePicker = ImagePicker();

  /// Pick image from gallery and open cropper
  /// Returns the cropped image file or null if cancelled
  static Future<File?> pickAndCropImage({
    required BuildContext context,
    double cropBoxSize = 300,
    CropAspectRatio aspectRatio = const CropAspectRatio(ratioX: 1, ratioY: 1),
  }) async {
    try {
      // Step 1: Pick image from gallery
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (pickedFile == null) {
        return null; // User cancelled image picker
      }

      // Step 2: Open cropper
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.black87,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black87,
            statusBarColor: Colors.black87,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking/cropping image: $e');
      return null;
    }
  }
}
