import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/invoices/data/models/invoice_models.dart';
import 'package:savedge/features/invoices/data/services/invoice_service.dart';
import 'package:share_plus/share_plus.dart';

/// Page displaying the user's invoices with download capability
class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  final InvoiceService _invoiceService = GetIt.I<InvoiceService>();
  final ScrollController _scrollController = ScrollController();

  List<InvoiceListItem> _invoices = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMoreInvoices();
    }
  }

  Future<void> _loadInvoices() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final response = await _invoiceService.getMyInvoices(pageNumber: 1);
      if (!mounted) return;
      setState(() {
        _invoices = response.items;
        _currentPage = 1;
        _hasMore = response.pageNumber < response.totalPages;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _loadMoreInvoices() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final response =
          await _invoiceService.getMyInvoices(pageNumber: _currentPage + 1);
      if (!mounted) return;
      setState(() {
        _invoices.addAll(response.items);
        _currentPage = response.pageNumber;
        _hasMore = response.pageNumber < response.totalPages;
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _downloadInvoice(InvoiceListItem invoice) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading invoice...'),
        duration: Duration(seconds: 1),
      ),
    );

    try {
      final filePath = await _invoiceService.downloadInvoicePdf(
        invoice.id,
        invoice.invoiceNumber,
      );
      if (!mounted) return;

      await Share.shareXFiles(
        [XFile(filePath, mimeType: 'application/pdf')],
        subject: invoice.invoiceNumber,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A202C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: const Text(
          'Invoices',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
      );
    }

    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadInvoices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F3FCC),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_invoices.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'No invoices yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your invoices will appear here after you make a purchase.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInvoices,
      color: const Color(0xFF6F3FCC),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _invoices.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _invoices.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
              ),
            );
          }
          return _buildInvoiceCard(_invoices[index]);
        },
      ),
    );
  }

  Widget _buildInvoiceCard(InvoiceListItem invoice) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final currencyFormat = NumberFormat.currency(symbol: '\u20B9', decimalDigits: 2);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _downloadInvoice(invoice),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _getTypeColor(invoice.invoiceType).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getTypeIcon(invoice.invoiceType),
                        color: _getTypeColor(invoice.invoiceType),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            invoice.invoiceNumber,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            invoice.invoiceTypeName,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currencyFormat.format(invoice.totalAmount),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 2),
                        _buildStatusChip(invoice),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.grey[200], height: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Text(
                      dateFormat.format(invoice.invoiceDate),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (invoice.subscriptionPlanName != null) ...[
                      const SizedBox(width: 16),
                      Icon(Icons.card_membership_outlined,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          invoice.subscriptionPlanName!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Icon(Icons.download_outlined,
                        size: 18, color: const Color(0xFF6F3FCC)),
                    const SizedBox(width: 4),
                    const Text(
                      'Download',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6F3FCC),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(InvoiceListItem invoice) {
    Color color;
    switch (invoice.paymentStatus) {
      case 1:
        color = const Color(0xFF059669);
        break;
      case 2:
        color = Colors.red;
        break;
      case 3:
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        invoice.paymentStatusName,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getTypeColor(int type) {
    switch (type) {
      case 0:
      case 2:
        return const Color(0xFF6F3FCC);
      case 1:
        return const Color(0xFF059669);
      case 3:
        return const Color(0xFFEF6C35);
      case 4:
      case 5:
        return const Color(0xFF3B82F6);
      case 6:
        return const Color(0xFF14B8A6);
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(int type) {
    switch (type) {
      case 0:
      case 2:
        return Icons.card_membership_rounded;
      case 1:
        return Icons.star_rounded;
      case 3:
        return Icons.local_offer_rounded;
      case 4:
        return Icons.confirmation_number_rounded;
      case 5:
        return Icons.card_giftcard_rounded;
      case 6:
        return Icons.campaign_rounded;
      default:
        return Icons.receipt_rounded;
    }
  }
}
