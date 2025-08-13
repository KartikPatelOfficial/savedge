import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_it/get_it.dart';

import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_redemption_options_page.dart';

/// QR Scanner page for scanning vendor QR codes to validate and claim coupons
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({
    super.key,
    required this.couponId,
    required this.expectedVendorId,
    required this.expectedVendorName,
  });

  final int couponId;
  final int expectedVendorId;
  final String expectedVendorName;

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;
  bool isProcessing = false;

  CouponService get _couponService => GetIt.I<CouponService>();

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      cameraController.stop();
    }
    cameraController.start();
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
            onDetect: (capture) {
              if (isScanning && !isProcessing && capture.barcodes.isNotEmpty) {
                final String? code = capture.barcodes.first.rawValue;
                if (code != null) {
                  _handleQRCode(code);
                }
              }
            },
          ),

          // Top bar with back button and title
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Scan QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Position the QR code within the frame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The QR code should contain vendor information\nfor validation purposes',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
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
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF6F3FCC),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Processing...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
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
        title: const Text('Camera Permission Required'),
        content: const Text('Please grant camera permission to scan QR codes.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleQRCode(String qrCode) async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
      isScanning = false;
    });

    try {
      // Parse QR code format: vendorId-vendorName (e.g., "1-HappyBox")
      final parts = qrCode.split('-');
      if (parts.length < 2) {
        throw Exception('Invalid QR code format');
      }

      final scannedVendorId = int.tryParse(parts[0]);
      if (scannedVendorId == null) {
        throw Exception('Invalid QR code format');
      }

      final scannedVendorName = parts
          .sublist(1)
          .join('-'); // Handle vendor names with hyphens

      // Validate vendor matches
      if (scannedVendorId != widget.expectedVendorId ||
          scannedVendorName.toLowerCase() !=
              widget.expectedVendorName.toLowerCase()) {
        throw Exception('This QR code is not valid for this vendor');
      }

      // Check if coupon can be redeemed
      final couponCheck = await _couponService.checkCoupon(widget.couponId);

      if (!couponCheck.canUserRedeem) {
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
            Navigator.of(
              context,
            ).pop(true); // Return to vendor page with success
          }
        } else {
          // User cancelled or failed to claim
          setState(() {
            isScanning = true; // Allow scanning again
          });
        }
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 24),
            const SizedBox(width: 8),
            const Text('Error'),
          ],
        ),
        content: Text(error.replaceAll('Exception: ', '')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isScanning = true;
              });
            },
            child: const Text('Try Again'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(
                context,
              ).pop(false); // Return to previous page with failure
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}