import 'package:mime_dart/src/db.dart';
import 'package:mime_dart/src/mime_data/mime_data.dart';

/// Mime Base Class
/// 
/// It contains three methods for getting different mime types
/// 
/// - [getExtensionFromType]
/// 
/// - [getTypeFromExtension]
/// 
/// - [getMime]
class Mime {
  /// This method helps in getting extensions from type
  /// 
  /// [type] takes a [String] input. For Example: `application/pdf`
  /// 
  /// Returns `[pdf]`
  static List<String>? getExtensionFromType(String type) {
    if (type.isEmpty) {
      return null;
    }

    if (!database.containsKey(type)) {
      return null;
    }
    MimeData mime = MimeData.fromJson(database[type] as Map<String, Object?>);

    if (mime.extensions != null && mime.extensions!.isNotEmpty) {
      return mime.extensions;
    }

    return null;
  }

  /// This method helps in getting type from extension
  /// 
  /// [extension] takes [String] as input. For Example: `pdf`
  /// 
  /// Returns `[application/pdf]`
  static List<String>? getTypeFromExtension(String extension) {
    if (extension.isEmpty) {
      return null;
    }

    List<String> types = [];
    for (final entry in database.entries) {
      final mime = MimeData.fromJson(entry.value as Map<String, Object?>);

      if (mime.extensions != null && mime.extensions!.contains(extension)) {
        types.add(entry.key);
      }
    }

    if (types.isEmpty) {
      return null;
    }

    return types;
  }

  /// This method helps in getting MimeData from type
  /// 
  /// [type] takes [String] as input. For Example: `application/pdf`
  /// 
  /// returns [MimeData] object with relevant fields
  static MimeData? getMime(String type) {
    if (!database.containsKey(type)) {
      return null;
    }

    return MimeData.fromJson(database[type] as Map<String, Object?>);
  }
}
