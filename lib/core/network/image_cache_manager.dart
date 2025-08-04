import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/io_client.dart';

/// Custom cache manager for handling images with SSL bypass in debug mode
class CustomImageCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'customImageCache';

  static final CustomImageCacheManager _instance = CustomImageCacheManager._();
  factory CustomImageCacheManager() => _instance;

  CustomImageCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 100,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileService: _createHttpFileService(),
          ),
        );

  static HttpFileService _createHttpFileService() {
    final httpClient = HttpClient();
    
    // Bypass SSL certificate validation in debug mode for local development
    if (kDebugMode) {
      httpClient.badCertificateCallback = (cert, host, port) => true;
    }
    
    final client = IOClient(httpClient);
    return HttpFileService(httpClient: client);
  }
}
