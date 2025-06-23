import 'package:file_picker/file_picker.dart';

class PickedFileResult {
  final String filePath;
  final PlatformFile file;

  PickedFileResult({required this.filePath, required this.file});
}

class FilePickerUtil {
  static const int maxSizeInBytes = 10 * 1024 * 1024;

  static Future<PickedFileResult?> pickFile({
    List<String> allowedExtensions = const ['jpg', 'png', 'jpeg', 'pdf'],
    Function()? onFileTooLarge,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.size > maxSizeInBytes) {
        onFileTooLarge?.call();
        return null;
      }

      if (file.path != null) {
        return PickedFileResult(filePath: file.path!, file: file);
      }
    }

    return null;
  }
}
