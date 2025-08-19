import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:savedge/core/network/image_cache_manager.dart';

/// Simple test widget to debug image loading issues
class ImageTestPage extends StatelessWidget {
  const ImageTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    const testImageUrl =
        'https://10.0.2.2:44447/api/ImageProxy/eb6072e3-c0e5-4ccb-adc9-bbfd8ac1705f_Analysis%20Class%20Diagram.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Loading Test'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Testing Image Loading',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('URL: $testImageUrl', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),

            // Test 1: CachedNetworkImage with custom cache manager
            const Text('1. CachedNetworkImage with Custom Cache Manager:'),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: testImageUrl,
                cacheManager: CustomImageCacheManager(),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Loading with custom cache...'),
                      ],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.red[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(height: 8),
                        Text('Error: $error'),
                        const SizedBox(height: 4),
                        Text(
                          'URL: $url',
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Test 2: Regular CachedNetworkImage
            const Text('2. Regular CachedNetworkImage:'),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: testImageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Loading with default cache...'),
                      ],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.orange[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.orange),
                        const SizedBox(height: 8),
                        Text('Error: $error'),
                        const SizedBox(height: 4),
                        Text(
                          'URL: $url',
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Test 3: Regular NetworkImage
            const Text('3. Regular NetworkImage:'),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                testImageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                          const SizedBox(height: 8),
                          const Text('Loading with NetworkImage...'),
                        ],
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  if (kDebugMode) {
                    print('NetworkImage Error: $error');
                    print('StackTrace: $stackTrace');
                  }
                  return Container(
                    color: Colors.blue[100],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.blue),
                          const SizedBox(height: 8),
                          Text('NetworkImage Error: $error'),
                          const SizedBox(height: 4),
                          Text(
                            'URL: $testImageUrl',
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Network status info
            const Text(
              'Debug Info:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Running in ${kDebugMode ? "Debug" : "Release"} mode'),
            Text('SSL bypass: ${kDebugMode ? "Enabled" : "Disabled"}'),
            const Text('Base URL: https://10.0.2.2:44447'),
          ],
        ),
      ),
    );
  }
}
