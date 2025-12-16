import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';

/// Top offers section showing top 10 vendors from API
class TopOffersSection extends StatefulWidget {
  const TopOffersSection({
    super.key,
    this.title = 'Top Offers',
    this.onVendorTap,
  });

  final String title;
  final Function(Vendor)? onVendorTap;

  @override
  State<TopOffersSection> createState() => _TopOffersSectionState();
}

class _TopOffersSectionState extends State<TopOffersSection> {
  bool _dispatched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If a VendorsBloc is already provided up the tree, trigger top offers load once
    final existingBloc = context.read<VendorsBloc?>();
    if (existingBloc != null && !_dispatched) {
      existingBloc.add(const LoadTopOfferVendors());
      _dispatched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use existing VendorsBloc if available; otherwise create one and load top offers
    final vendorsBloc = context.read<VendorsBloc?>();
    if (vendorsBloc == null) {
      return BlocProvider(
        create: (context) =>
            getIt<VendorsBloc>()..add(const LoadTopOfferVendors()),
        child: TopOffersView(
          title: widget.title,
          onVendorTap: widget.onVendorTap,
        ),
      );
    }
    return TopOffersView(title: widget.title, onVendorTap: widget.onVendorTap);
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
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Background image
                _buildBackgroundImage(),
                // Enhanced gradient overlay with better blend
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.75),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.25),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.35, 0.65, 1.0],
                    ),
                  ),
                ),
                // Content with improved spacing
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      // Left content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Category badge with glassmorphism effect
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                vendor.category.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            Spacer(),
                            // Vendor name with better typography
                            Text(
                              vendor.businessName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: -0.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Right content - Modern arrow with better design
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildDefaultBackground();
          },
          errorBuilder: (context, error, stackTrace) =>
              _buildDefaultBackground(),
        ),
      );
    } else {
      return _buildDefaultBackground();
    }
  }

  Widget _buildDefaultBackground() {
    // Enhanced gradient palettes with richer colors
    final gradients = [
      [
        const Color(0xFF6F3FCC),
        const Color(0xFF9F7AEA),
        const Color(0xFFB794F6),
      ], // Purple
      [
        const Color(0xFF319795),
        const Color(0xFF38B2AC),
        const Color(0xFF4FD1C7),
      ], // Teal
      [
        const Color(0xFFDD6B20),
        const Color(0xFFED8936),
        const Color(0xFFF6AD55),
      ], // Orange
      [
        const Color(0xFFC53030),
        const Color(0xFFE53E3E),
        const Color(0xFFF56565),
      ], // Red
      [
        const Color(0xFF2C5282),
        const Color(0xFF3182CE),
        const Color(0xFF63B3ED),
      ], // Blue
      [
        const Color(0xFF2F855A),
        const Color(0xFF38A169),
        const Color(0xFF68D391),
      ], // Green
    ];

    final colors = gradients[vendor.id % gradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Multiple decorative circles with blur effect
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 80,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
