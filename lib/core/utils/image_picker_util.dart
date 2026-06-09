import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  /// Picks a single image from the gallery
  static Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  /// Picks multiple images from the gallery
  static Future<List<XFile>> pickMultipleImages() async {
    return await _picker.pickMultiImage();
  }

  /// Picks multiple media items (images/videos) from the gallery
  static Future<List<XFile>> pickMultipleMedia() async {
    return await _picker.pickMultipleMedia();
  }

  /// Picks a video from the gallery
  static Future<XFile?> pickVideo() async {
    return await _picker.pickVideo(source: ImageSource.gallery);
  }

  /// Picks an image from the camera
  static Future<XFile?> takePicture() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
