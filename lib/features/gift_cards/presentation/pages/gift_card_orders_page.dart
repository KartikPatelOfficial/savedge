import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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

  static const _filters = <(String, GiftCardOrderStatusEntity?)>[
    ('All', null),
    ('Completed', GiftCardOrderStatusEntity.completed),
    ('Pending', GiftCardOrderStatusEntity.pending),
    ('Issuing', GiftCardOrderStatusEntity.issuing),
    ('Failed', GiftCardOrderStatusEntity.failed),
    ('Refunded', GiftCardOrderStatusEntity.refunded),
  ];

  void _filterByStatus(GiftCardOrderStatusEntity? status) {
    HapticFeedback.selectionClick();
    setState(() => _selectedStatus = status);
    context.read<GiftCardsBloc>().add(LoadGiftCardOrders(status: status));
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      body: Column(
        children: [
          // ── Custom header ─────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(20, topPad + 12, 20, 16),
            color: Colors.white,
            child: Column(
              children: [
                // Nav row
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18, color: Color(0xFF374151)),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'My Orders',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // balance the back button
                  ],
                ),

                const SizedBox(height: 14),

                // ── Filter chips ──────────────────────────────────────
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final (label, status) = _filters[index];
                      final isSelected = _selectedStatus == status;
                      return GestureDetector(
                        onTap: () => _filterByStatus(status),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6F3FCC)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF6F3FCC)
                                  : const Color(0xFFE5E7EB),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              if (isSelected) ...[
                                const Icon(Icons.check_rounded,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Orders list ───────────────────────────────────────────
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
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3EFFE),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(Icons.receipt_long_rounded,
                                size: 36, color: Color(0xFF7C3AED)),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No orders yet',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Your gift card orders will appear here',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      HapticFeedback.mediumImpact();
                      context.read<GiftCardsBloc>().add(
                          LoadGiftCardOrders(status: _selectedStatus));
                    },
                    color: const Color(0xFF6F3FCC),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 350),
                            child: SlideAnimation(
                              verticalOffset: 30,
                              child: FadeInAnimation(
                                child: GiftCardOrderCard(
                                    order: state.orders[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                if (state is GiftCardOrdersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.error_outline_rounded,
                              size: 28, color: Color(0xFFDC2626)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _filterByStatus(_selectedStatus),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6F3FCC),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Try Again',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
}
