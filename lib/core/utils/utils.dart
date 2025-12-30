// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// final ApiRepository apiRepository = ApiRepository();

class CheckPermission {
  // ignore: strict_top_level_inference
  isStoragePermission() async {
    var installPackages = await Permission.requestInstallPackages.status;
    if (!installPackages.isGranted) {
      await Permission.requestInstallPackages.request();
    } else {
      return true;
    }
  }
}

class DirectoryPath {
  // ignore: strict_top_level_inference
  getPath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory("${tempDir!.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }
}
