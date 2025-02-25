import 'dart:io';

import 'package:basigo_dirt/core/utils/io_util/io_util.dart';

/// A input/output file with various properties e.g type and lastModified.
class IOFile {
  final String fileName;
  final String ext;

  /// The absolute path of the file.
  final String path;
  String? lastModified;

  /// The network url of the file. This is incase the file is loaded from the network.
  String? networkUrl;

  /// The [File] representation of the [IOFile].
  final File file;

  String? documentId;

  /// Will be true if the file is a video file.
  ///
  /// Defaults to [false]
  final bool isVideo;

  /// The size of file in mb.
  ///
  /// Defaults to [0] if unknown.
  double size;

  String? mimeType;

  IOFile({
    required this.fileName,
    required this.ext,
    required this.path,
    this.lastModified,
    this.networkUrl,
    this.documentId,
    required this.file,
    this.isVideo = false,
    this.size = 0,
    this.mimeType,
  });

  factory IOFile.fromJson(Map<String, dynamic> data) => IOFile(
        networkUrl: data['url'],
        mimeType: data['mimetype'],
        size: IOUtil.bytesToMb(data['metadata']?['size'] ?? 0),
        fileName: data['metadata']?['originalname'] ?? 'file',
        ext: data['metadata']?['originalname']?.split('.').last ?? '',
        path: '',
        file: File(''),
      );
}
