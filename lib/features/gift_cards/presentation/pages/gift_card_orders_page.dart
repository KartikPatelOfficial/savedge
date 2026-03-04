import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../widgets/gift_card_order_card.dart';

class GiftCardOrdersPage extends StatelessWidget {
  const GiftCardOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<GiftCardsBloc>()..add(const LoadGiftCardOrders()),
      child: const GiftCardOrdersView(),
    );
  }
}

class GiftCardOrdersView extends StatefulWidget {
  const GiftCardOrdersView({super.key});

  @override
  State<GiftCardOrdersView> createState() => _GiftCardOrdersViewState();
}

class _GiftCardOrdersViewState extends State<GiftCardOrdersView> {
  GiftCardOrderStatusEntity? _selectedStatus;

  void _filterByStatus(GiftCardOrderStatusEntity? status) {
    setState(() => _selectedStatus = status);
    context.read<GiftCardsBloc>().add(LoadGiftCardOrders(status: status));
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
            child: const Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 16),
          ),
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Status filter chips
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip('All', _selectedStatus == null, () => _filterByStatus(null)),
                _buildFilterChip('Completed', _selectedStatus == GiftCardOrderStatusEntity.completed,
                    () => _filterByStatus(GiftCardOrderStatusEntity.completed)),
                _buildFilterChip('Pending', _selectedStatus == GiftCardOrderStatusEntity.pending,
                    () => _filterByStatus(GiftCardOrderStatusEntity.pending)),
                _buildFilterChip('Issuing', _selectedStatus == GiftCardOrderStatusEntity.issuing,
                    () => _filterByStatus(GiftCardOrderStatusEntity.issuing)),
                _buildFilterChip('Failed', _selectedStatus == GiftCardOrderStatusEntity.failed,
                    () => _filterByStatus(GiftCardOrderStatusEntity.failed)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Orders list
          Expanded(
            child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
              buildWhen: (prev, curr) =>
                  curr is GiftCardOrdersLoading ||
                  curr is GiftCardOrdersLoaded ||
                  curr is GiftCardOrdersError,
              builder: (context, state) {
                if (state is GiftCardOrdersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: Color(0xFF6F3FCC)),
                  );
                }
                if (state is GiftCardOrdersLoaded) {
                  if (state.orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt_long_rounded,
                              size: 56, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your gift card orders will appear here',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<GiftCardsBloc>().add(
                          LoadGiftCardOrders(status: _selectedStatus));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return GiftCardOrderCard(
                            order: state.orders[index]);
                      },
                    ),
                  );
                }
                if (state is GiftCardOrdersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text(state.message,
                            style: TextStyle(color: Colors.grey[600])),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => _filterByStatus(_selectedStatus),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.grey[700],
        ),
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF6F3FCC),
        side: BorderSide(
          color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[300]!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onSelected: (_) => onTap(),
      ),
    );
  }
}
