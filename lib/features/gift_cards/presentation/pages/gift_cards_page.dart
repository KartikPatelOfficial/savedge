import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../widgets/gift_card_product_card.dart';

class GiftCardsPage extends StatelessWidget {
  const GiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<GiftCardsBloc>()..add(const LoadGiftCardCategories()),
      child: const GiftCardsView(),
    );
  }
}

class GiftCardsView extends StatefulWidget {
  const GiftCardsView({super.key});

  @override
  State<GiftCardsView> createState() => _GiftCardsViewState();
}

class _GiftCardsViewState extends State<GiftCardsView> {
  GiftCardCategoryEntity? _selectedCategory;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectCategory(GiftCardCategoryEntity? category) {
    setState(() {
      _selectedCategory = category;
      _searchController.clear();
    });
    context.read<GiftCardsBloc>().add(
          LoadGiftCardProducts(categoryId: category?.id),
        );
  }

  void _searchProducts(String query) {
    context.read<GiftCardsBloc>().add(
          LoadGiftCardProducts(
            categoryId: _selectedCategory?.id,
            searchTerm: query.isEmpty ? null : query,
          ),
        );
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
        title: const Text(
          'Gift Cards',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A202C),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gift-card-orders');
            },
            icon: const Icon(
              Icons.receipt_long_rounded,
              color: Color(0xFF6F3FCC),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _searchController,
              onSubmitted: _searchProducts,
              decoration: InputDecoration(
                hintText: 'Search gift cards...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey[400], size: 20),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Categories horizontal list
          BlocBuilder<GiftCardsBloc, GiftCardsState>(
            buildWhen: (prev, curr) =>
                curr is GiftCardCategoriesLoading ||
                curr is GiftCardCategoriesLoaded ||
                curr is GiftCardCategoriesError,
            builder: (context, state) {
              if (state is GiftCardCategoriesLoaded) {
                return _buildCategoryChips(state.categories);
              }
              return const SizedBox.shrink();
            },
          ),

          // Products grid
          Expanded(
            child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
              buildWhen: (prev, curr) =>
                  curr is GiftCardProductsLoading ||
                  curr is GiftCardProductsLoaded ||
                  curr is GiftCardProductsError,
              builder: (context, state) {
                if (state is GiftCardProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6F3FCC),
                    ),
                  );
                }
                if (state is GiftCardProductsLoaded) {
                  return _buildProductsGrid(state.products);
                }
                if (state is GiftCardProductsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 48, color: Colors.grey[400]),
                        const SizedBox(height: 12),
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => _selectCategory(_selectedCategory),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                // Initial state - show prompt
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard_rounded,
                          size: 64, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        'Select a category to browse gift cards',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(List<GiftCardCategoryEntity> categories) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = _selectedCategory == null;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                selected: isSelected,
                label: const Text('All'),
                labelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color:
                      isSelected ? Colors.white : const Color(0xFF6F3FCC),
                ),
                backgroundColor: Colors.white,
                selectedColor: const Color(0xFF6F3FCC),
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFF6F3FCC)
                      : Colors.grey[300]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onSelected: (_) => _selectCategory(null),
              ),
            );
          }

          final cat = categories[index - 1];
          final isSelected = _selectedCategory?.id == cat.id;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(cat.name),
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF6F3FCC),
              ),
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF6F3FCC),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF6F3FCC)
                    : Colors.grey[300]!,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              avatar: cat.imageUrl != null
                  ? CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        cat.imageUrl!,
                      ),
                      radius: 12,
                    )
                  : null,
              onSelected: (_) => _selectCategory(cat),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(List<GiftCardProductEntity> products) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard_rounded, size: 48, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              'No gift cards found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GiftCardProductCard(
          product: products[index],
          onTap: () {
            Navigator.pushNamed(
              context,
              '/gift-card-detail',
              arguments: products[index],
            );
          },
        );
      },
    );
  }
}
