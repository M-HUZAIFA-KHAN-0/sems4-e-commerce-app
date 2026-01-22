import 'package:first/core/app_imports.dart';

class ImagePickerCropperModule {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<CroppedFile?> pickAndCropImage({
    required BuildContext context,
    CropAspectRatio aspectRatio = const CropAspectRatio(ratioX: 1, ratioY: 1),
  }) async {
    try {
      // Pick image from gallery
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (pickedFile == null) return null;

      // Crop image (mobile + web safe)
      return await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.textBlack,
            toolbarWidgetColor: AppColors.backgroundWhite,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: true),
          WebUiSettings(context: context),
        ],
      );
    } catch (e) {
      debugPrint('Error picking/cropping image: $e');
      return null;
    }
  }
}
