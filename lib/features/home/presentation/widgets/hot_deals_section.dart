import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

/// Hot deals section widget with real coupon data
class HotDealsSection extends StatelessWidget {
  const HotDealsSection({super.key, this.deals = const []});

  final List<HotDeal> deals;

  @override
  Widget build(BuildContext context) {
    // Try to use existing BLoC from parent, but don't watch for changes
    final couponsBloc = context.read<CouponsBloc?>();
    
    if (couponsBloc == null) {
      // Fallback: create a new BLoC if not provided by parent
      return BlocProvider(
        create: (context) =>
            getIt<CouponsBloc>()..add(const LoadFeaturedCoupons(pageSize: 5)),
        child: const HotDealsView(),
      );
    }
    
    return const HotDealsView();
  }
}

class HotDealsView extends StatelessWidget {
  const HotDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 260,
          child: BlocBuilder<CouponsBloc, CouponsState>(
            builder: (context, state) {
              if (state is CouponsLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
                );
              } else if (state is CouponsError) {
                return _buildErrorWidget(state.message);
              } else if (state is CouponsLoaded) {
                return _buildCouponsList(context, state.coupons);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCouponsList(BuildContext context, List<Coupon> coupons) {
    if (coupons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 40,
                color: Color(0xFF6F3FCC),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No deals available',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A5568),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return StackedDealsCards(
      coupons: coupons,
      onCouponTap: (coupon) => _navigateToCouponDetail(context, coupon),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE53E3E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 40,
              color: Color(0xFFE53E3E),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load deals',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCouponDetail(BuildContext context, Coupon coupon) {
    // Navigate to vendor detail page to see the coupon
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorDetailPage(vendorId: coupon.vendorId),
      ),
    );
  }
}

/// Model class for hot deal items (now using vendor data)
class HotDeal {
  const HotDeal({
    required this.name,
    required this.rating,
    required this.offer,
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String rating;
  final String offer;
  final String? imageUrl;
  final VoidCallback? onTap;
}

/// Stacked deals cards widget with beautiful animations
class StackedDealsCards extends StatefulWidget {
  const StackedDealsCards({super.key, required this.coupons, this.onCouponTap});

  final List<Coupon> coupons;
  final Function(Coupon)? onCouponTap;

  @override
  State<StackedDealsCards> createState() => _StackedDealsCardsState();
}

class _StackedDealsCardsState extends State<StackedDealsCards>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);

    // Initialize animation controllers
    _animationControllers = List.generate(
      widget.coupons.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300 + (index * 100)),
        vsync: this,
      ),
    );

    // Initialize scale animations
    _scaleAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.elasticOut),
          ),
        )
        .toList();

    // Initialize slide animations
    _slideAnimations = _animationControllers
        .map(
          (controller) =>
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
              ),
        )
        .toList();

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _animationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _animationControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coupons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Main stacked cards
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.coupons.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _animationControllers[index],
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: ScaleTransition(
                      scale: _scaleAnimations[index],
                      child: _buildStackCard(widget.coupons[index], index),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Page indicators
        _buildPageIndicators(),
      ],
    );
  }

  Widget _buildStackCard(Coupon coupon, int index) {
    final isCenter = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: EdgeInsets.symmetric(vertical: isCenter ? 0 : 10),
      child: Transform.scale(
        scale: isCenter ? 1.0 : 0.85,
        child: GestureDetector(
          onTap: () => widget.onCouponTap?.call(coupon),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // Gradient background
                _buildGradientBackground(coupon, index),
                // Decorative elements
                _buildDecorations(index),
                // Content
                _buildCardContent(coupon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground(Coupon coupon, int index) {
    final gradients = [
      [const Color(0xFF6F3FCC), const Color(0xFF9F7AEA)],
      [const Color(0xFF38B2AC), const Color(0xFF4FD1C7)],
      [const Color(0xFFED8936), const Color(0xFFF56500)],
      [const Color(0xFFE53E3E), const Color(0xFFF56565)],
      [const Color(0xFF3182CE), const Color(0xFF63B3ED)],
    ];

    final colors = gradients[index % gradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }

  Widget _buildDecorations(int index) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Circular decorations
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
            bottom: -40,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Floating icons
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(Coupon coupon) {
    String discountText;
    if (coupon.discountType.toLowerCase() == 'percentage') {
      discountText = '${coupon.discountValue.toInt()}% OFF';
    } else {
      discountText = '₹${coupon.discountValue.toInt()} OFF';
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Discount badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              discountText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const Spacer(),
          // Title
          Text(
            coupon.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Description
          if (coupon.description.isNotEmpty)
            Text(
              coupon.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 12),
          // Minimum amount info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      coupon.minimumAmountDisplay.isEmpty
                          ? 'No minimum'
                          : coupon.minimumAmountDisplay,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Arrow indicator
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
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
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.coupons.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == _currentIndex ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == _currentIndex
                ? const Color(0xFF6F3FCC)
                : const Color(0xFF6F3FCC).withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  // Mock data helpers - replace with real API calls
  String _getMockVendorName(int vendorId) {
    final vendorNames = [
      'Tasty Bites',
      'Sweet Treats',
      'Burger House',
      'Fashion Hub',
      'Spa Retreat',
    ];
    return vendorNames[vendorId % vendorNames.length];
  }

  String _getMockCategory(int vendorId) {
    final categories = [
      'Restaurant',
      'Dessert',
      'Fast food',
      'Clothing store',
      'Spa',
    ];
    return categories[vendorId % categories.length];
  }
}
