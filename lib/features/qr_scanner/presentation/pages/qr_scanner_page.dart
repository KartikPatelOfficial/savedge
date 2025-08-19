import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_redemption_options_page.dart';

/// QR Scanner page for scanning vendor QR codes to validate and claim coupons
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({
    super.key,
    required this.couponId,
    required this.expectedVendorUid,
    required this.expectedVendorName,
  });

  final int couponId;
  final String expectedVendorUid;
  final String expectedVendorName;

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with WidgetsBindingObserver {
  late MobileScannerController cameraController;
  bool isScanning = true;
  bool isProcessing = false;
  bool _isDisposed = false;
  Timer? _debounceTimer;

  CouponService get _couponService => GetIt.I<CouponService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    _checkCameraPermission();
  }

  void _initializeCamera() {
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
      returnImage: false,
      // Prevent image buffer overflow
      formats: [
        BarcodeFormat.qrCode,
      ], // Only scan QR codes to improve performance
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (!_isDisposed && Platform.isAndroid) {
      _restartCamera();
    }
  }

  void _restartCamera() async {
    if (_isDisposed) return;

    try {
      await cameraController.stop();
      await Future.delayed(const Duration(milliseconds: 100));
      if (!_isDisposed && mounted) {
        await cameraController.start();
      }
    } catch (e) {
      debugPrint('Error restarting camera: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (_isDisposed || !mounted) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _stopCamera();
        break;
      case AppLifecycleState.resumed:
        _startCamera();
        break;
      case AppLifecycleState.inactive:
        // Pause camera to free resources
        _stopCamera();
        break;
    }
  }

  Future<void> _stopCamera() async {
    if (_isDisposed) return;

    try {
      await cameraController.stop();
    } catch (e) {
      debugPrint('Error stopping camera: $e');
    }
  }

  void _startCamera() async {
    if (_isDisposed || !mounted) return;

    try {
      await cameraController.start();
    } catch (e) {
      debugPrint('Error starting camera: $e');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _debounceTimer?.cancel();

    // Properly dispose camera controller to prevent memory leaks
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // QR Scanner View
          MobileScanner(
            controller: cameraController,
            onDetect: _onQRCodeDetected,
            errorBuilder: (context, error) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Camera Error',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _restartCamera,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Top bar with back button and title
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Scan QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Instructions at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Scan Vendor QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Position the QR code at ${widget.expectedVendorName} within the camera frame to validate and redeem your coupon.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Processing overlay
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Validating QR Code...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please wait while we verify the vendor information',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      _showPermissionDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Camera Permission Required',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A202C),
          ),
        ),
        content: const Text(
          'To scan QR codes, we need access to your camera. Please grant camera permission in your device settings.',
          style: TextStyle(fontSize: 16, color: Color(0xFF4A5568), height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF718096),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Open Settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRCodeDetected(BarcodeCapture capture) {
    if (!isScanning || isProcessing || capture.barcodes.isEmpty) return;

    final String? code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    // Debounce multiple detections
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted && isScanning && !isProcessing) {
        setState(() {
          isScanning = false; // Stop scanning immediately
        });
        _handleQRCode(code);
      }
    });
  }

  Future<void> _handleQRCode(String qrCode) async {
    if (isProcessing || _isDisposed) return;

    setState(() {
      isProcessing = true;
      isScanning = false;
    });

    try {
      // Stop camera to free resources during processing
      await _stopCamera();

      // Parse QR code format: 'savedge://vendor/$vendorId'
      final uri = Uri.tryParse(qrCode);
      if (uri == null || uri.scheme != 'savedge' || uri.host != 'vendor') {
        throw Exception(
          'Invalid QR code format. Please scan a valid vendor QR code.',
        );
      }

      if (uri.pathSegments.isEmpty) {
        throw Exception('Invalid vendor QR code. No vendor ID found.');
      }

      final scannedVendorId = uri.pathSegments[0];

      // Validate vendor matches
      if (scannedVendorId != widget.expectedVendorUid) {
        throw Exception(
          'This QR code belongs to a different vendor. Please scan the QR code from ${widget.expectedVendorName}.',
        );
      }

      // Check if coupon can be redeemed
      final couponCheck = await _couponService.checkCoupon(widget.couponId);

      // Allow to proceed if user has unused coupons or can still claim more
      if (!couponCheck.canUserRedeem && !couponCheck.hasUnusedCoupons) {
        throw Exception(
          'Coupon cannot be redeemed: ${couponCheck.redeemabilityReasons.join(', ')}',
        );
      }

      // Navigate to redemption options page
      if (mounted) {
        final result = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (context) =>
                CouponRedemptionOptionsPage(couponData: couponCheck),
          ),
        );

        if (result == true) {
          // Coupon was successfully claimed
          if (mounted) {
            Navigator.of(context).pop(true); // Return success
          }
        } else {
          // User cancelled or failed to claim
          _resetScanning();
        }
      }
    } catch (e) {
      debugPrint('QR Code handling error: $e');
      _showErrorDialog(e.toString());
    } finally {
      if (mounted && !_isDisposed) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  void _resetScanning() {
    if (mounted && !_isDisposed) {
      setState(() {
        isScanning = true;
        isProcessing = false;
      });
      // Restart camera
      _startCamera();
    }
  }

  void _showErrorDialog(String error) {
    if (!mounted || _isDisposed) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE53E3E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline,
                color: Color(0xFFE53E3E),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Scanning Error',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
            ),
          ],
        ),
        content: Text(
          error.replaceAll('Exception: ', ''),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4A5568),
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetScanning();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF718096),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(false); // Return to previous page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
