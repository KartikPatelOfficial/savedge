/// Invoice list item model matching backend InvoiceListItemDto
class InvoiceListItem {
  final int id;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final String userName;
  final String? email;
  final int invoiceType;
  final String? subscriptionPlanName;
  final double baseAmount;
  final double gstAmount;
  final double totalAmount;
  final int paymentStatus;
  final String? pdfUrl;

  InvoiceListItem({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.userName,
    this.email,
    required this.invoiceType,
    this.subscriptionPlanName,
    required this.baseAmount,
    required this.gstAmount,
    required this.totalAmount,
    required this.paymentStatus,
    this.pdfUrl,
  });

  factory InvoiceListItem.fromJson(Map<String, dynamic> json) {
    return InvoiceListItem(
      id: json['id'] as int,
      invoiceNumber: json['invoiceNumber'] as String,
      invoiceDate: DateTime.parse(json['invoiceDate'] as String),
      userName: json['userName'] as String,
      email: json['email'] as String?,
      invoiceType: json['invoiceType'] as int,
      subscriptionPlanName: json['subscriptionPlanName'] as String?,
      baseAmount: (json['baseAmount'] as num).toDouble(),
      gstAmount: (json['gstAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as int,
      pdfUrl: json['pdfUrl'] as String?,
    );
  }

  String get invoiceTypeName {
    switch (invoiceType) {
      case 0:
        return 'Subscription';
      case 1:
        return 'Free Trial';
      case 2:
        return 'Renewal';
      case 3:
        return 'Coupon Purchase';
      case 4:
        return 'Voucher Order';
      case 5:
        return 'Gift Card Order';
      case 6:
        return 'Promotion';
      default:
        return 'Other';
    }
  }

  String get paymentStatusName {
    switch (paymentStatus) {
      case 0:
        return 'Pending';
      case 1:
        return 'Paid';
      case 2:
        return 'Failed';
      case 3:
        return 'Refunded';
      default:
        return 'Unknown';
    }
  }
}

/// Paginated invoice list response
class InvoicesListResponse {
  final List<InvoiceListItem> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final int totalPages;

  InvoicesListResponse({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
  });

  factory InvoicesListResponse.fromJson(Map<String, dynamic> json) {
    return InvoicesListResponse(
      items: (json['items'] as List)
          .map((e) => InvoiceListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}
