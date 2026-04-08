import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_empty_state.dart';
import '../widgets/gc_order_detail_card.dart';
import '../widgets/gc_skeleton.dart';

enum _OrdersTab { all, active, processing, failed }

extension on _OrdersTab {
  String get label {
    switch (this) {
      case _OrdersTab.all:
        return 'All';
      case _OrdersTab.active:
        return 'Active';
      case _OrdersTab.processing:
        return 'Processing';
      case _OrdersTab.failed:
        return 'Failed';
    }
  }

  bool match(GiftCardOrderStatusEntity s) {
    switch (this) {
      case _OrdersTab.all:
        return true;
      case _OrdersTab.active:
        return s == GiftCardOrderStatusEntity.completed;
      case _OrdersTab.processing:
        return s == GiftCardOrderStatusEntity.pending ||
            s == GiftCardOrderStatusEntity.paymentCompleted ||
            s == GiftCardOrderStatusEntity.issuing;
      case _OrdersTab.failed:
        return s == GiftCardOrderStatusEntity.failed ||
            s == GiftCardOrderStatusEntity.cancelled ||
            s == GiftCardOrderStatusEntity.refunded;
    }
  }
}

class GiftCardOrdersPage extends StatelessWidget {
  const GiftCardOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GiftCardsBloc>()..add(const LoadGiftCardOrders()),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  const _OrdersView();

  @override
  State<_OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  _OrdersTab _tab = _OrdersTab.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GcTokens.background,
      appBar: AppBar(
        backgroundColor: GcTokens.background,
        surfaceTintColor: GcTokens.background,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'My Gift Cards',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: GcTokens.textPrimary,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: GcTokens.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final t in _OrdersTab.values) ...[
                    _tabPill(t),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: GcTokens.primary,
        onRefresh: () async {
          context
              .read<GiftCardsBloc>()
              .add(const LoadGiftCardOrders());
        },
        child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
          buildWhen: (_, s) =>
              s is GiftCardOrdersLoading ||
              s is GiftCardOrdersLoaded ||
              s is GiftCardOrdersError,
          builder: (context, state) {
            if (state is GiftCardOrdersLoading) {
              return ListView(
                children: const [
                  SizedBox(height: 12),
                  GcListSkeleton(count: 5),
                ],
              );
            }
            if (state is GiftCardOrdersError) {
              return ListView(
                children: [
                  GcEmptyState(
                    icon: Icons.error_outline_rounded,
                    title: 'Could not load your orders',
                    message: state.message,
                    actionLabel: 'Retry',
                    onAction: () => context
                        .read<GiftCardsBloc>()
                        .add(const LoadGiftCardOrders()),
                  ),
                ],
              );
            }
            if (state is GiftCardOrdersLoaded) {
              final filtered =
                  state.orders.where((o) => _tab.match(o.status)).toList();
              if (filtered.isEmpty) {
                return ListView(
                  children: const [
                    GcEmptyState(
                      icon: Icons.card_giftcard_rounded,
                      title: 'No gift cards yet',
                      message:
                          'Your purchased gift cards will appear here so you can grab the codes anytime.',
                    ),
                  ],
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: filtered.length,
                itemBuilder: (_, i) => GcOrderDetailCard(order: filtered[i]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _tabPill(_OrdersTab tab) {
    final selected = _tab == tab;
    return GestureDetector(
      onTap: () => setState(() => _tab = tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? GcTokens.primary : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: selected ? GcTokens.primary : const Color(0xFFEFEAFB),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: GcTokens.primary.withValues(alpha: 0.32),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Text(
          tab.label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: selected ? Colors.white : GcTokens.textPrimary,
          ),
        ),
      ),
    );
  }
}
