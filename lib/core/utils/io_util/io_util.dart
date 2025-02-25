import 'dart:io';
import 'dart:math';

import 'package:basigo_dirt/core/utils/io_util/io_util_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Handles all Input/Output related tasks
class IOUtil {
  /// Shows a bottomSheet with options to choose between gallery and camera.
  ///
  /// > * _@param:_ __[String]__ fileName => The name you want the file to be named.
  static Future<IOFile?> getImageModal({
    String fileName = '',
  }) async {
    final file = await Get.bottomSheet<IOFile?>(
      Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              child: const Row(
                children: [
                  Icon(
                    Icons.photo_library_rounded,
                    color: Color(0xffBF8D65),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Add from Gallery',
                    style: TextStyle(color: Color(0xff575353)),
                  ),
                ],
              ),
              onTap: () async {
                final file = await getImage(
                  fileName: fileName,
                  source: 'gallery',
                );
                Get.back<IOFile?>(result: file);
              },
            ),
            const SizedBox(height: 30),
            GestureDetector(
              child: const Row(
                children: [
                  Icon(
                    Icons.camera,
                    color: Color.fromARGB(255, 0, 215, 187),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Take a photo',
                    style: TextStyle(color: Color(0xff575353)),
                  ),
                ],
              ),
              onTap: () async {
                final file = await getImage(
                  fileName: fileName,
                  source: 'camera',
                );
                Get.back<IOFile?>(result: file);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    return file;
  }

  /// Picks an image from the device (gallery or camera) and returns in the form of [IOFile].
  ///
  /// > ___NOTE:__ This function is only limited to picking images only_
  ///
  /// > * _@param:_ __[String]__ fileName => The name you want the image to have.
  ///
  /// > * _@param:_ __[String]__ source => The source of the image. It can either be _`'gallery'`_ or _`'camera'`_;
  static Future<IOFile?> getImage({
    String fileName = '',
    String source = 'gallery',
  }) async {
    IOFile? ioFile;

    final picker = ImagePicker();

    // * Initialize the default imageSource to gallery
    ImageSource imageSource = ImageSource.gallery;

    switch (source) {
      case 'gallery':
        imageSource = ImageSource.gallery;
        break;
      case 'camera':
        imageSource = ImageSource.camera;
        break;
    }

    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
    );

    if (pickedFile != null) {
      final path = pickedFile.path;
      final name = pickedFile.name;
      final dateModified = await pickedFile.lastModified();
      final ext = pickedFile.name.split('.').last;
      final file = File(path);
      final bytes = await pickedFile.length();

      ioFile = IOFile(
        fileName: fileName.isEmpty ? name : '$fileName.$ext',
        ext: ext,
        path: path,
        lastModified: dateModified.toString(),
        file: file,
        size: bytesToMb(bytes),
      );
    }

    return ioFile;
  }

  static double bytesToMb(int bytes) {
    double mb = 0;

    if (bytes > 0) {
      final i = (log(bytes) / log(1024)).floor();

      mb = (bytes / pow(1024, i)).toPrecision(2);
    }

    return mb;
  }
}
