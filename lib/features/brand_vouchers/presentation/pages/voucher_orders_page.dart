import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entities/brand_voucher_entity.dart';
import '../bloc/brand_vouchers_bloc.dart';
import '../widgets/voucher_order_card.dart';

class VoucherOrdersPage extends StatelessWidget {
  const VoucherOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrandVouchersBloc>()
        ..add(const LoadVoucherOrders()),
      child: const VoucherOrdersView(),
    );
  }
}

class VoucherOrdersView extends StatefulWidget {
  const VoucherOrdersView({super.key});

  @override
  State<VoucherOrdersView> createState() => _VoucherOrdersViewState();
}

class _VoucherOrdersViewState extends State<VoucherOrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
          'My Voucher Orders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF6F3FCC),
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          indicatorColor: const Color(0xFF6F3FCC),
          indicatorWeight: 2,
          onTap: (index) => _loadOrdersByStatus(context, index),
          tabs: const [
            Tab(text: 'All Orders'),
            Tab(text: 'Pending'),
            Tab(text: 'Fulfilled'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadOrdersByStatus(context, _tabController.index);
          await Future.delayed(const Duration(seconds: 1));
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildOrdersList(null), // All orders
            _buildOrdersList(VoucherOrderStatusEntity.pending),
            _buildOrdersList(VoucherOrderStatusEntity.fulfilled),
            _buildOrdersList(VoucherOrderStatusEntity.rejected),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(VoucherOrderStatusEntity? status) {
    return BlocBuilder<BrandVouchersBloc, BrandVouchersState>(
      builder: (context, state) {
        if (state is VoucherOrdersLoading) {
          return _buildLoadingState();
        } else if (state is VoucherOrdersLoaded) {
          final filteredOrders = status == null 
              ? state.orders
              : state.orders.where((order) => order.status == status).toList();
              
          if (filteredOrders.isEmpty) {
            return _buildEmptyState(status);
          }
          return _buildOrdersGrid(filteredOrders);
        } else if (state is VoucherOrdersError) {
          return _buildErrorState(context, state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildOrdersGrid(List<VoucherOrderEntity> orders) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return VoucherOrderCard(
                  order: orders[index],
                  onTap: () => _showOrderDetails(context, orders[index]),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF6F3FCC),
          ),
          SizedBox(height: 16),
          Text(
            'Loading your orders...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(VoucherOrderStatusEntity? status) {
    String title;
    String subtitle;
    IconData icon;
    
    switch (status) {
      case VoucherOrderStatusEntity.pending:
        title = 'No Pending Orders';
        subtitle = 'You don\'t have any pending voucher orders';
        icon = Icons.pending_actions_rounded;
        break;
      case VoucherOrderStatusEntity.fulfilled:
        title = 'No Fulfilled Orders';
        subtitle = 'Your completed vouchers will appear here';
        icon = Icons.check_circle_outline_rounded;
        break;
      case VoucherOrderStatusEntity.rejected:
        title = 'No Rejected Orders';
        subtitle = 'You don\'t have any rejected orders';
        icon = Icons.cancel_outlined;
        break;
      default:
        title = 'No Orders Found';
        subtitle = 'You haven\'t placed any voucher orders yet';
        icon = Icons.receipt_long_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 40,
                color: const Color(0xFF6F3FCC),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _loadOrdersByStatus(context, _tabController.index),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F3FCC),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _loadOrdersByStatus(BuildContext context, int tabIndex) {
    VoucherOrderStatusEntity? status;
    
    switch (tabIndex) {
      case 1:
        status = VoucherOrderStatusEntity.pending;
        break;
      case 2:
        status = VoucherOrderStatusEntity.fulfilled;
        break;
      case 3:
        status = VoucherOrderStatusEntity.rejected;
        break;
      default:
        status = null; // All orders
    }

    context.read<BrandVouchersBloc>().add(
      LoadVoucherOrders(status: status),
    );
  }

  void _showOrderDetails(BuildContext context, VoucherOrderEntity order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoucherOrderDetailsSheet(order: order),
    );
  }
}

class VoucherOrderDetailsSheet extends StatelessWidget {
  final VoucherOrderEntity order;

  const VoucherOrderDetailsSheet({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
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
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderInfo(),
                  const SizedBox(height: 20),
                  _buildVoucherDetails(),
                  if (order.hasVoucherDetails) ...[
                    const SizedBox(height: 20),
                    _buildVoucherCode(),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildDetailRow('Order ID', '#${order.id}'),
          _buildDetailRow('Brand', order.brandName),
          _buildDetailRow('Voucher Amount', '₹${order.voucherAmount.toStringAsFixed(2)}'),
          _buildDetailRow('Processing Fee', '₹${order.processingFee.toStringAsFixed(2)}'),
          if (order.paymentMethod == VoucherPaymentMethodEntity.points)
            _buildDetailRow('Total Points Used', '${order.totalPointsUsed.toStringAsFixed(0)} Points'),
          if (order.paymentMethod == VoucherPaymentMethodEntity.razorpay && order.amountPaid != null)
            _buildDetailRow('Amount Paid', '₹${order.amountPaid!.toStringAsFixed(2)}'),
          _buildDetailRow('Payment Method', '${order.paymentMethod.icon} ${order.paymentMethod.displayName}'),
          _buildDetailRow('Order Date', _formatDate(order.created)),
          _buildDetailRow('Status', order.status.displayName, isStatus: true),
        ],
      ),
    );
  }

  Widget _buildVoucherDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB3D9FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: Color(0xFF0EA5E9),
              ),
              const SizedBox(width: 8),
              const Text(
                'Voucher Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            order.status.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          if (order.fulfilledAt != null) ...[
            const SizedBox(height: 8),
            Text(
              'Fulfilled on: ${_formatDate(order.fulfilledAt!)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
          if (order.expiresAt != null) ...[
            const SizedBox(height: 8),
            Text(
              'Expires on: ${_formatDate(order.expiresAt!)}',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVoucherCode() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.card_giftcard_rounded,
                size: 16,
                color: Color(0xFF059669),
              ),
              const SizedBox(width: 8),
              const Text(
                'Your Voucher',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (order.voucherCode != null) ...[
            _buildVoucherDetailRow('Voucher Code', order.voucherCode!),
          ],
          if (order.voucherPin != null) ...[
            _buildVoucherDetailRow('PIN', order.voucherPin!),
          ],
          if (order.notes != null && order.notes!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'Instructions: ${order.notes}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: isStatus
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(order.status),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A202C),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF86EFAC)),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF059669),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(VoucherOrderStatusEntity status) {
    switch (status) {
      case VoucherOrderStatusEntity.pending:
        return const Color(0xFFFF9800);
      case VoucherOrderStatusEntity.processing:
        return const Color(0xFF2196F3);
      case VoucherOrderStatusEntity.fulfilled:
        return const Color(0xFF059669);
      case VoucherOrderStatusEntity.rejected:
        return const Color(0xFFEF4444);
      case VoucherOrderStatusEntity.cancelled:
        return const Color(0xFF6B7280);
    }
  }

  String _formatDate(DateTime date) {
    // Convert UTC to local time
    final localDate = date.toLocal();
    return '${localDate.day}/${localDate.month}/${localDate.year} at ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}';
  }
}