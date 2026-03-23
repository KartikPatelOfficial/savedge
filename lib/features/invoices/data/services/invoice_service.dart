import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/invoices/data/models/invoice_models.dart';

/// Service for fetching user invoices
class InvoiceService {
  final Dio _dio;

  InvoiceService(this._dio);

  /// Get paginated list of invoices for the current user
  Future<InvoicesListResponse> getMyInvoices({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/api/invoices',
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );

      if (response.statusCode == 200) {
        return InvoicesListResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load invoices');
      }
    } on DioException catch (e) {
      debugPrint('InvoiceService.getMyInvoices error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to load invoices');
    }
  }

  /// Download invoice PDF and return the file path
  Future<String> downloadInvoicePdf(int invoiceId, String invoiceNumber) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/api/invoices/$invoiceId/download',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final bytes = response.data as List<int>;
        final dir = await getTemporaryDirectory();
        final fileName = '$invoiceNumber.pdf';
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(Uint8List.fromList(bytes));
        return file.path;
      } else {
        throw Exception('Failed to download invoice');
      }
    } on DioException catch (e) {
      debugPrint('InvoiceService.downloadInvoicePdf error: ${e.message}');
      throw Exception(e.response?.data?['message'] ?? 'Failed to download invoice');
    }
  }
}
