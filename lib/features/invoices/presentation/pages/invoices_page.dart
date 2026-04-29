import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const Color _primary = Color(0xFF6F3FCC);
  static const Color _textPrimary = Color(0xFF1A202C);
  static const Color _border = Color(0xFFE7EAF1);

  final InvoiceService _invoiceService = GetIt.I<InvoiceService>();
  final ScrollController _scrollController = ScrollController();
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  final NumberFormat _currencyFormat =
      NumberFormat.currency(symbol: '\u20B9', decimalDigits: 2);

  List<InvoiceListItem> _invoices = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMore = true;
  int _totalInvoiceCount = 0;

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
    if (!_scrollController.hasClients) return;

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
        _totalInvoiceCount = response.totalCount;
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
        _totalInvoiceCount = response.totalCount;
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
          content: Text(
            'Failed to download: ${e.toString().replaceAll('Exception: ', '')}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  InvoiceListItem? get _latestInvoice {
    if (_invoices.isEmpty) return null;

    return _invoices.reduce(
      (current, next) => current.invoiceDate.isAfter(next.invoiceDate)
          ? current
          : next,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _loadInvoices,
          color: _primary,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              _buildSliverAppBar(context),
              ..._buildContentSlivers(),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContentSlivers() {
    if (_isLoading) {
      return [
        SliverToBoxAdapter(child: _buildHeroBanner(isLoading: true)),
        SliverToBoxAdapter(child: _buildSectionHeader('RECENT INVOICES')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: _InvoiceCardSkeleton(),
              ),
              childCount: 3,
            ),
          ),
        ),
      ];
    }

    if (_hasError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateBody(
            icon: Icons.cloud_off_rounded,
            title: 'Could not load invoices',
            message: _errorMessage,
            actionLabel: 'Try again',
            onAction: _loadInvoices,
          ),
        ),
      ];
    }

    if (_invoices.isEmpty) {
      return [
        SliverToBoxAdapter(child: _buildHeroBanner()),
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateBody(
            icon: Icons.receipt_long_outlined,
            title: 'No invoices yet',
            message:
                'Your invoices will show up here after subscription or order payments are completed.',
          ),
        ),
      ];
    }

    return [
      SliverToBoxAdapter(child: _buildHeroBanner()),
      SliverToBoxAdapter(child: _buildSectionHeader('AVAILABLE INVOICES')),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == _invoices.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(color: _primary),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildInvoiceCard(_invoices[index]),
              );
            },
            childCount: _invoices.length + (_isLoadingMore ? 1 : 0),
          ),
        ),
      ),
    ];
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: _textPrimary),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: _textPrimary,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          const expandedHeight = 150.0;
          final minHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final t = ((constraints.maxHeight - minHeight) /
                  (expandedHeight - minHeight))
              .clamp(0.0, 1.0);
          final leftPadding = 20.0 + (52.0 * (1 - t));

          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.transparent, t),
            ),
            child: Stack(
              children: [
                if (t > 0.05)
                  Positioned(
                    bottom: 52,
                    left: 20,
                    child: Opacity(
                      opacity: t.clamp(0.0, 1.0),
                      child: const Text(
                        'Download-ready records and receipts',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: leftPadding,
                    bottom: 16,
                    right: 20,
                  ),
                  centerTitle: false,
                  title: Text(
                    'Invoices',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: t > 0.5 ? 24 : 20,
                      fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner({bool isLoading = false}) {
    final totalInvoices =
        _totalInvoiceCount > 0 ? _totalInvoiceCount : _invoices.length;
    final paidInvoices =
        _invoices.where((invoice) => invoice.paymentStatus == 1).length;
    final latestInvoice = _latestInvoice;
    final userName = latestInvoice?.userName.trim();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFFCFBFF),
            border: Border.all(
              color: _primary.withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: _primary.withValues(alpha: 0.10),
                offset: const Offset(0, 12),
                blurRadius: 32,
                spreadRadius: -6,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                left: -50,
                top: -60,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF10B981).withValues(alpha: 0.38),
                        const Color(0xFF10B981).withValues(alpha: 0.08),
                        const Color(0xFF10B981).withValues(alpha: 0),
                      ],
                      stops: const [0, 0.45, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -44,
                top: -26,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF9F7AEA).withValues(alpha: 0.38),
                        _primary.withValues(alpha: 0.10),
                        _primary.withValues(alpha: 0),
                      ],
                      stops: const [0, 0.52, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 56,
                bottom: -66,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF59E0B).withValues(alpha: 0.28),
                        const Color(0xFFF59E0B).withValues(alpha: 0.08),
                        const Color(0xFFF59E0B).withValues(alpha: 0),
                      ],
                      stops: const [0, 0.42, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: -34,
                child: Container(
                  width: 144,
                  height: 144,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.24),
                        const Color(0xFF3B82F6).withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
                child: isLoading
                    ? const _HeroBannerSkeleton()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice vault',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      _textPrimary.withValues(alpha: 0.42),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const Spacer(),
                              if (userName != null && userName.isNotEmpty)
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      userName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: _textPrimary
                                            .withValues(alpha: 0.52),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                totalInvoices.toString(),
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w900,
                                  color: _textPrimary,
                                  height: 1,
                                  letterSpacing: -1.8,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        totalInvoices == 1
                                            ? 'invoice ready'
                                            : 'invoices ready',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: _textPrimary,
                                          height: 1.1,
                                          letterSpacing: -0.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              _buildHeroBadge('$paidInvoices PAID'),
                              const SizedBox(width: 8),
                              _buildHeroBadge(
                                  '${_invoices.length} LOADED'),
                              const Spacer(),
                              if (latestInvoice != null)
                                Text(
                                  'Latest ${_dateFormat.format(latestInvoice.invoiceDate)}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: _textPrimary
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
          color: _textPrimary,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: const Color(0xFFEFEAFB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(InvoiceListItem invoice) {
    final palette = _paletteForInvoice(invoice);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _downloadInvoice(invoice),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: palette.border),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                palette.tint.withValues(alpha: 0.55),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: palette.shadow,
                blurRadius: 26,
                spreadRadius: -16,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                right: -32,
                top: -18,
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        palette.glow.withValues(alpha: 0.28),
                        palette.glow.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: palette.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: palette.accent.withValues(alpha: 0.10),
                            ),
                          ),
                          child: Icon(
                            _getTypeIcon(invoice.invoiceType),
                            color: palette.accent,
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: _textPrimary,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildTypeChip(
                                    invoice.invoiceTypeName,
                                    palette: palette,
                                  ),
                                  _buildStatusChip(invoice, palette: palette),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _currencyFormat.format(invoice.totalAmount),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: _textPrimary,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: _textPrimary.withValues(alpha: 0.42),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: [
                        _InlineMetaPill(
                          icon: Icons.calendar_today_outlined,
                          label: 'Issued',
                          value: _dateFormat.format(invoice.invoiceDate),
                          palette: palette,
                        ),
                        _InlineMetaPill(
                          icon: Icons.percent_rounded,
                          label: 'GST',
                          value: _currencyFormat.format(invoice.gstAmount),
                          palette: palette,
                        ),
                        _InlineMetaPill(
                          icon: invoice.subscriptionPlanName != null
                              ? Icons.card_membership_outlined
                              : Icons.receipt_long_outlined,
                          label: invoice.subscriptionPlanName != null
                              ? 'Plan'
                              : 'Base',
                          value: invoice.subscriptionPlanName ??
                              _currencyFormat.format(invoice.baseAmount),
                          palette: palette,
                          maxWidth: 220,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            invoice.paymentStatus == 1
                                ? 'Tap to open and share the PDF receipt.'
                                : 'Keep a copy of this invoice for your records.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.35,
                              fontWeight: FontWeight.w600,
                              color: _textPrimary.withValues(alpha: 0.54),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildDownloadButton(palette),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label, {required _InvoicePalette palette}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: palette.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: palette.accent,
        ),
      ),
    );
  }

  Widget _buildStatusChip(
    InvoiceListItem invoice, {
    required _InvoicePalette palette,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: palette.status.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        invoice.paymentStatusName,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: palette.status,
        ),
      ),
    );
  }

  Widget _buildDownloadButton(_InvoicePalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            palette.accent,
            palette.accent.withValues(alpha: 0.82),
          ],
        ),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: palette.accent.withValues(alpha: 0.24),
            blurRadius: 18,
            offset: const Offset(0, 10),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.south_east_rounded,
              size: 17,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Download',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }

  _InvoicePalette _paletteForInvoice(InvoiceListItem invoice) {
    final accent = _getTypeColor(invoice.invoiceType);
    final status = _statusColor(invoice.paymentStatus);

    return _InvoicePalette(
      accent: accent,
      status: status,
      tint: Color.lerp(Colors.white, accent, 0.08)!,
      glow: Color.lerp(accent, status, 0.35)!,
      border: Color.lerp(accent, Colors.white, 0.82)!,
      shadow: accent.withValues(alpha: 0.10),
    );
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return const Color(0xFF10B981);
      case 2:
        return Colors.red;
      case 3:
        return const Color(0xFF3B82F6);
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(int type) {
    switch (type) {
      case 0:
      case 2:
        return _primary;
      case 1:
        return const Color(0xFF10B981);
      case 3:
        return const Color(0xFFEF6C35);
      case 4:
      case 5:
        return const Color(0xFF3B82F6);
      case 6:
        return const Color(0xFFF59E0B);
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

class _InlineMetaPill extends StatelessWidget {
  const _InlineMetaPill({
    required this.icon,
    required this.label,
    required this.value,
    required this.palette,
    this.maxWidth,
  });

  final IconData icon;
  final String label;
  final String value;
  final _InvoicePalette palette;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: palette.accent.withValues(alpha: 0.86)),
        const SizedBox(width: 7),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                  color: _InvoicesPageState._textPrimary.withValues(alpha: 0.34),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _InvoicesPageState._textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (maxWidth != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: content,
      );
    }

    return content;
  }
}

class _InvoicePalette {
  const _InvoicePalette({
    required this.accent,
    required this.status,
    required this.tint,
    required this.glow,
    required this.border,
    required this.shadow,
  });

  final Color accent;
  final Color status;
  final Color tint;
  final Color glow;
  final Color border;
  final Color shadow;
}

class _StateBody extends StatelessWidget {
  const _StateBody({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 420),
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE7EAF1)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.06),
                blurRadius: 24,
                spreadRadius: -12,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F0FF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child:
                    Icon(icon, size: 34, color: const Color(0xFF6F3FCC)),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A202C),
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 22),
                FilledButton(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    actionLabel!,
                    style:
                        const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoiceCardSkeleton extends StatelessWidget {
  const _InvoiceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7EAF1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: const [
                _SkeletonBox(width: 52, height: 52, radius: 16),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 150, height: 16),
                      SizedBox(height: 8),
                      _SkeletonBox(width: 120, height: 12),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                _SkeletonBox(width: 82, height: 18),
              ],
            ),
            const SizedBox(height: 16),
            const _SkeletonBox(
                width: double.infinity, height: 92, radius: 18),
          ],
        ),
      ),
    );
  }
}

class _HeroBannerSkeleton extends StatelessWidget {
  const _HeroBannerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          children: [
            _SkeletonBox(width: 92, height: 12),
            Spacer(),
            _SkeletonBox(width: 88, height: 12),
          ],
        ),
        Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _SkeletonBox(width: 74, height: 54, radius: 16),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _SkeletonBox(width: 118, height: 12),
                  SizedBox(height: 8),
                  _SkeletonBox(width: 162, height: 18),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Row(
          children: [
            _SkeletonBox(width: 74, height: 24, radius: 999),
            SizedBox(width: 8),
            _SkeletonBox(width: 82, height: 24, radius: 999),
          ],
        ),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.width,
    required this.height,
    this.radius = 12,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
