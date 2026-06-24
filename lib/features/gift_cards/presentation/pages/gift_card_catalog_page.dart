import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/gift_cards/data/services/gift_card_favorites_service.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/domain/repositories/gift_card_repository.dart';
import 'package:savedge/features/gift_cards/presentation/bloc/gift_card_catalog_cubit.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_empty_state.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_search_bar.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_skeleton.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gift_card_product_card.dart';

/// Full browsable gift-voucher catalog with server-side search, category
/// filtering and infinite-scroll pagination.
///
/// The landing page ([GiftCardsPage]) only shows a short preview; tapping
/// "View all" pushes this page so the 300+ catalog never bloats the landing
/// scroll.
class GiftCardCatalogPage extends StatelessWidget {
  const GiftCardCatalogPage({super.key, this.initialCategory});

  /// Pre-selects a category when the user arrives from a category preview.
  final GiftCardCategoryEntity? initialCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GiftCardCatalogCubit(getIt<GiftCardRepository>())
        ..start(categoryId: initialCategory?.id),
      child: const _CatalogView(),
    );
  }
}

class _CatalogView extends StatefulWidget {
  const _CatalogView();

  @override
  State<_CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<_CatalogView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _favorites = getIt<GiftCardFavoritesService>();
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 600) {
      context.read<GiftCardCatalogCubit>().loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<GiftCardCatalogCubit>().setSearch(value);
    });
  }

  void _onSearchSubmitted(String value) {
    _searchDebounce?.cancel();
    FocusScope.of(context).unfocus();
    context.read<GiftCardCatalogCubit>().setSearch(value);
  }

  void _openDetail(GiftCardProductEntity p) {
    Navigator.pushNamed(context, '/gift-card-detail', arguments: p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GcTokens.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: GcTokens.primary,
          onRefresh: () => context.read<GiftCardCatalogCubit>().refresh(),
          child: BlocBuilder<GiftCardCatalogCubit, GiftCardCatalogState>(
            builder: (context, state) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: _buildSlivers(context, state),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers(
    BuildContext context,
    GiftCardCatalogState state,
  ) {
    return [
      _buildAppBar(),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: GcSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
          ),
        ),
      ),
      if (state.categories.isNotEmpty)
        SliverToBoxAdapter(
          child: _CategoryFilterRow(
            categories: state.categories,
            selectedId: state.categoryId,
            onSelect: (id) =>
                context.read<GiftCardCatalogCubit>().selectCategory(id),
          ),
        ),
      ..._buildBody(context, state),
      const SliverToBoxAdapter(child: SizedBox(height: 32)),
    ];
  }

  List<Widget> _buildBody(BuildContext context, GiftCardCatalogState state) {
    if (state.isInitialLoading) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: GcProductGridSkeleton(count: 8),
          ),
        ),
      ];
    }

    if (state.errorMessage != null && state.products.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: GcEmptyState(
            icon: Icons.cloud_off_rounded,
            title: 'Couldn\'t load vouchers',
            message: state.errorMessage!,
            actionLabel: 'Try again',
            onAction: () => context.read<GiftCardCatalogCubit>().refresh(),
          ),
        ),
      ];
    }

    if (state.isEmpty) {
      final searching = (state.searchTerm ?? '').isNotEmpty;
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: GcEmptyState(
            icon: Icons.search_off_rounded,
            title: 'No vouchers found',
            message: searching
                ? 'Try a different brand name or clear the search.'
                : 'No vouchers are available in this category yet.',
            actionLabel: searching ? 'Clear search' : null,
            onAction: searching
                ? () {
                    _searchController.clear();
                    context.read<GiftCardCatalogCubit>().setSearch(null);
                  }
                : null,
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.70,
          ),
          delegate: SliverChildBuilderDelegate((_, i) {
            final p = state.products[i];
            return GiftCardProductCard(
              product: p,
              favorites: _favorites,
              onTap: () => _openDetail(p),
            );
          }, childCount: state.products.length),
        ),
      ),
      SliverToBoxAdapter(child: _buildFooter(state)),
    ];
  }

  Widget _buildFooter(GiftCardCatalogState state) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: GcTokens.primary,
            ),
          ),
        ),
      );
    }
    if (state.hasReachedMax && state.products.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Center(
          child: Text(
            'You\'ve seen all ${state.products.length} vouchers',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: GcTokens.textTertiary,
            ),
          ),
        ),
      );
    }
    return const SizedBox(height: 8);
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
        ),
      ),
      titleSpacing: 0,
      title: const Text(
        'All gift vouchers',
        style: TextStyle(
          color: GcTokens.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

/// Horizontal, single-line row of category filter chips (with a leading "All"
/// chip). Server-side filtering, so it works correctly across all pages.
class _CategoryFilterRow extends StatelessWidget {
  const _CategoryFilterRow({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  final List<GiftCardCategoryEntity> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          if (i == 0) {
            return _chip('All', selectedId == null, () => onSelect(null));
          }
          final c = categories[i - 1];
          return _chip(c.name, selectedId == c.id, () => onSelect(c.id));
        },
      ),
    );
  }

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? GcTokens.primary : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: isSelected ? GcTokens.primary : const Color(0xFFEFEAFB),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: GcTokens.primary.withValues(alpha: 0.30),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ]
              : GcTokens.tinyShadow,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : GcTokens.textPrimary,
          ),
        ),
      ),
    );
  }
}
