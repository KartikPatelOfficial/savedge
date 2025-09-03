import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/constants/categories_constants.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';

/// Top offers section showing top 10 vendors from API
class TopOffersSection extends StatelessWidget {
  const TopOffersSection({
    super.key,
    this.title = 'Top Offers',
    this.onVendorTap,
  });

  final String title;
  final Function(Vendor)? onVendorTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<VendorsBloc>()..add(const LoadVendors(pageSize: 10)),
      child: TopOffersView(title: title, onVendorTap: onVendorTap),
    );
  }
}

/// Top offers view with BLoC integration
class TopOffersView extends StatelessWidget {
  const TopOffersView({super.key, required this.title, this.onVendorTap});

  final String title;
  final Function(Vendor)? onVendorTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Vendors list with BLoC
          BlocBuilder<VendorsBloc, VendorsState>(
            builder: (context, state) {
              if (state is VendorsLoading) {
                return _buildLoadingState();
              } else if (state is VendorsError) {
                return _buildErrorState(state.message);
              } else if (state is VendorsLoaded) {
                return _buildVendorsList(state.vendors);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Color(0xFF6F3FCC)),
            const SizedBox(height: 16),
            Text(
              'Loading top offers...',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE53E3E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 32,
                color: Color(0xFFE53E3E),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load offers',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A5568),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorsList(List<Vendor> vendors) {
    if (vendors.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: vendors.take(5).map((vendor) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
          child: TopVendorCard(
            vendor: vendor,
            onTap: () => _onVendorTap(vendor),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.store_outlined,
                size: 32,
                color: Color(0xFF6F3FCC),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No offers available',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A5568),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Check back later for amazing deals',
              style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  void _onVendorTap(Vendor vendor) {
    if (onVendorTap != null) {
      onVendorTap!(vendor);
    }
  }
}

/// Individual top vendor card with real vendor data
class TopVendorCard extends StatelessWidget {
  const TopVendorCard({super.key, required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background image
              _buildBackgroundImage(),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Left content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6F3FCC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              vendor.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Vendor name
                          Text(
                            vendor.businessName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Description or address
                          Text(
                            vendor.description ?? vendor.address ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Right content - Category icon and arrow
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Category icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              CategoriesConstants.getCategoryIcon(
                                vendor.category,
                              ),
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.store,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Arrow indicator
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
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

  Widget _buildBackgroundImage() {
    // Check if vendor has primary image
    final image = vendor.images.firstWhere(
      (img) => img.isPrimary,
      orElse: () => vendor.images.isNotEmpty
          ? vendor.images[0]
          : VendorImage(
              id: 0,
              imageUrl: '',
              displayOrder: 0,
              isPrimary: false,
              imageType: 'unknown',
              imageTypeName: 'Unknown',
            ),
    );
    final primaryImageUrl = image.imageUrl;

    if (primaryImageUrl.isNotEmpty) {
      return Positioned.fill(
        child: Image.network(
          primaryImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildDefaultBackground(),
        ),
      );
    } else {
      return _buildDefaultBackground();
    }
  }

  Widget _buildDefaultBackground() {
    // Generate gradient based on vendor ID
    final gradients = [
      [const Color(0xFF6F3FCC), const Color(0xFF9F7AEA)], // Purple
      [const Color(0xFF38B2AC), const Color(0xFF4FD1C7)], // Teal
      [const Color(0xFFED8936), const Color(0xFFF56500)], // Orange
      [const Color(0xFFE53E3E), const Color(0xFFF56565)], // Red
      [const Color(0xFF3182CE), const Color(0xFF63B3ED)], // Blue
      [const Color(0xFF38A169), const Color(0xFF68D391)], // Green
    ];

    final colors = gradients[vendor.id % gradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
