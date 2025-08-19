import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';

/// Modern, beautiful home page with stunning animations and glassmorphism design
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentBottomNavIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  late AnimationController _heroAnimationController;
  late AnimationController _floatingElementsController;
  late Animation<double> _heroAnimation;
  late Animation<double> _floatingAnimation;

  double _scrollOffset = 0.0;
  bool _isScrollingUp = true;

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _floatingElementsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _heroAnimation = CurvedAnimation(
      parent: _heroAnimationController,
      curve: Curves.easeOutCubic,
    );

    _floatingAnimation = CurvedAnimation(
      parent: _floatingElementsController,
      curve: Curves.easeInOut,
    );

    _scrollController.addListener(_onScroll);

    // Start animations
    _heroAnimationController.forward();
    _floatingElementsController.repeat(reverse: true);
  }

  void _onScroll() {
    final newOffset = _scrollController.offset;
    final isScrollingUp = newOffset < _scrollOffset;

    if (isScrollingUp != _isScrollingUp) {
      setState(() {
        _isScrollingUp = isScrollingUp;
      });
    }

    setState(() {
      _scrollOffset = newOffset;
    });
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _floatingElementsController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      extendBodyBehindAppBar: true,
      drawer: HomeDrawer(
        userName: 'Jacob David',
        onMenuItemTap: _onDrawerMenuItemTap,
      ),
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          _buildMainContent(),
          _buildFloatingActionButton(),
        ],
      ),
      bottomNavigationBar: _buildModernBottomNavBar(),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6F3FCC).withOpacity(0.1),
                const Color(0xFF9C4DFF).withOpacity(0.05),
                Colors.white,
              ],
            ),
          ),
          child: Stack(
            children: [
              _buildFloatingCircle(
                top: 100 + (_floatingAnimation.value * 20),
                left: 50 + (_floatingAnimation.value * 30),
                size: 120,
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
              ),
              _buildFloatingCircle(
                top: 300 + (_floatingAnimation.value * -15),
                right: 30 + (_floatingAnimation.value * 25),
                size: 80,
                color: const Color(0xFF9C4DFF).withOpacity(0.08),
              ),
              _buildFloatingCircle(
                bottom: 200 + (_floatingAnimation.value * 18),
                left: 20 + (_floatingAnimation.value * -20),
                size: 100,
                color: const Color(0xFF4CAF50).withOpacity(0.06),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingCircle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  Widget _buildMainContent() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildModernAppBar(),
        SliverToBoxAdapter(
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  _buildHeroSection(),
                  _buildQuickActions(),
                  _buildModernSpecialOffers(),
                  _buildCategoriesSection(),
                  _buildStatsSection(),
                  _buildHotDealsSection(),
                  _buildSubscriptionSection(),
                  _buildMarketplaceSection(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      flexibleSpace: AnimatedBuilder(
        animation: _heroAnimation,
        builder: (context, child) {
          return FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.7),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Transform.translate(
                    offset: Offset(0, (1 - _heroAnimation.value) * 30),
                    child: Opacity(
                      opacity: _heroAnimation.value,
                      child: Row(
                        children: [
                          _buildModernMenuButton(),
                          const SizedBox(width: 16),
                          _buildLocationSelector(),
                          const Spacer(),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernMenuButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6F3FCC), Color(0xFF9C4DFF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onMenuTap,
          borderRadius: BorderRadius.circular(16),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.menu_rounded, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: _onLocationTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                size: 16,
                color: Color(0xFF6F3FCC),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Mota Varachha',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  'Surat',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Color(0xFF6F3FCC),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildGlassActionButton(
          icon: Icons.favorite_rounded,
          onTap: _onFavoriteTap,
        ),
        const SizedBox(width: 8),
        _buildGlassActionButton(
          icon: Icons.notifications_rounded,
          onTap: _onNotificationTap,
          hasBadge: true,
        ),
      ],
    );
  }

  Widget _buildGlassActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(icon, size: 22, color: const Color(0xFF6F3FCC)),
              ),
            ),
          ),
          if (hasBadge)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53E3E),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return AnimatedBuilder(
      animation: _heroAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.all(20),
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6F3FCC),
                const Color(0xFF9C4DFF),
                const Color(0xFF4CAF50).withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Animated background elements
              Positioned(
                top: -20 + (_floatingAnimation.value * 10),
                right: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -40 + (_floatingAnimation.value * -5),
                left: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Transform.translate(
                  offset: Offset(0, (1 - _heroAnimation.value) * 50),
                  child: Opacity(
                    opacity: _heroAnimation.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome to SavEdge',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Discover amazing deals and save more\non every purchase',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
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
                              child: const Text(
                                'Explore Now',
                                style: TextStyle(
                                  color: Color(0xFF6F3FCC),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.search_rounded,
              title: 'Search',
              subtitle: 'Find deals',
              color: const Color(0xFF4CAF50),
              onTap: _onSearchTap,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.qr_code_scanner_rounded,
              title: 'Scan QR',
              subtitle: 'Quick redeem',
              color: const Color(0xFFFF6B7A),
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.local_offer_rounded,
              title: 'My Offers',
              subtitle: 'View saved',
              color: const Color(0xFFFF9800),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSpecialOffers() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Special Offers',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              itemCount: _getSpecialOffers().length,
              itemBuilder: (context, index) {
                final offer = _getSpecialOffers()[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 20 : 8,
                          right: index == _getSpecialOffers().length - 1
                              ? 20
                              : 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [offer.color, offer.color.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: offer.color.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            _buildOfferBackground(),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    offer.subtitle,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      offer.buttonText,
                                      style: TextStyle(
                                        color: offer.color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferBackground() {
    return Stack(
      children: [
        Positioned(
          top: -20,
          right: -30,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          right: 20,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              TextButton(
                onPressed: _onCategoriesSeeAllTap,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6F3FCC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: _getCategories().length,
            itemBuilder: (context, index) {
              final category = _getCategories()[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 600),
                columnCount: 4,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: _buildModernCategoryCard(category),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModernCategoryCard(CategoryItem category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: category.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        category.color.withOpacity(0.1),
                        category.color.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(category.icon, color: category.color, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, const Color(0xFFF8FAFC)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '125+',
              'Active\nOffers',
              const Color(0xFF6F3FCC),
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.2)),
          Expanded(
            child: _buildStatItem(
              '50K+',
              'Happy\nUsers',
              const Color(0xFF4CAF50),
            ),
          ),
          Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.2)),
          Expanded(
            child: _buildStatItem(
              '₹2L+',
              'Money\nSaved',
              const Color(0xFFFF6B7A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.3),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildHotDealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hot Deals 🔥',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6F3FCC),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _getHotDeals().length,
            itemBuilder: (context, index) {
              final deal = _getHotDeals()[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(child: _buildHotDealCard(deal, index)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHotDealCard(HotDeal deal, int index) {
    final colors = [
      const Color(0xFFFF6B7A),
      const Color(0xFF4CAF50),
      const Color(0xFF2196F3),
      const Color(0xFFFF9800),
    ];
    final color = colors[index % colors.length];

    return Container(
      width: 280,
      margin: EdgeInsets.only(left: index == 0 ? 20 : 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: deal.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.restaurant, color: color, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        deal.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: color, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            deal.rating,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withOpacity(0.8)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          deal.offer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildSubscriptionSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subscription Plans',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),
          SubscriptionPlansSection(),
        ],
      ),
    );
  }

  Widget _buildMarketplaceSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Marketplace',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              TextButton(
                onPressed: _onMarketplaceSeeAllTap,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6F3FCC),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MarketplaceSection(
            items: _getMarketplaceItems(),
            onSeeAllTap: _onMarketplaceSeeAllTap,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      bottom: 100,
      right: 20,
      child: AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              math.sin(_floatingAnimation.value * 2 * math.pi) * 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6F3FCC), Color(0xFF9C4DFF)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6F3FCC).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_rounded, 'Home', 0),
          _buildNavItem(Icons.search_rounded, 'Search', 1),
          _buildNavItem(Icons.local_offer_rounded, 'Offers', 2),
          _buildNavItem(Icons.person_rounded, 'Profile', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentBottomNavIndex == index;
    return GestureDetector(
      onTap: () => _onBottomNavTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6F3FCC) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 20,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Event handlers
  void _onLocationTap() {
    HapticFeedback.lightImpact();
    debugPrint('Location tap');
  }

  void _onFavoriteTap() {
    HapticFeedback.lightImpact();
    debugPrint('Favorite tap');
  }

  void _onNotificationTap() {
    HapticFeedback.lightImpact();
    debugPrint('Notification tap');
  }

  void _onSearchTap() {
    HapticFeedback.lightImpact();
    debugPrint('Search tap');
  }

  void _onCategoriesSeeAllTap() {
    HapticFeedback.lightImpact();
    debugPrint('Categories see all tap');
  }

  void _onMarketplaceSeeAllTap() {
    HapticFeedback.lightImpact();
    debugPrint('Marketplace see all tap');
  }

  void _onBottomNavTap(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _currentBottomNavIndex = index;
    });
    debugPrint('Bottom nav tap: $index');
  }

  void _onMenuTap() {
    HapticFeedback.lightImpact();
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onDrawerMenuItemTap(String menuTitle) {
    HapticFeedback.lightImpact();
    debugPrint('Drawer menu item tapped: $menuTitle');
    switch (menuTitle) {
      case 'Current Offers':
        break;
      case 'Stores':
        break;
      case 'About Us':
        break;
      case 'Feedback':
        break;
      case 'Contact Us':
        break;
      case 'Follow Us':
        break;
      case 'Brand Vouchers':
        break;
    }
  }

  // Data providers
  List<SpecialOffer> _getSpecialOffers() {
    return [
      SpecialOffer(
        title: 'Special Offer for July',
        subtitle: 'We are here with the best deserts in town!',
        buttonText: 'Order Now',
        color: const Color(0xFFFF6B7A),
        icon: Icons.local_offer,
        onTap: () => debugPrint('July offer tapped'),
      ),
      SpecialOffer(
        title: 'Summer Special',
        subtitle: 'We are here with the best drinks in town!',
        buttonText: 'Order Now',
        color: const Color(0xFF4CAF50),
        icon: Icons.local_drink,
        onTap: () => debugPrint('Summer offer tapped'),
      ),
    ];
  }

  List<CategoryItem> _getCategories() {
    return [
      CategoryItem(
        title: 'Restaurant',
        icon: Icons.restaurant,
        color: const Color(0xFFFF6B7A),
        onTap: () => debugPrint('Restaurant category tapped'),
      ),
      CategoryItem(
        title: 'Saloon',
        icon: Icons.content_cut,
        color: const Color(0xFF4CAF50),
        onTap: () => debugPrint('Saloon category tapped'),
      ),
      CategoryItem(
        title: 'Theater',
        icon: Icons.movie,
        color: const Color(0xFF2196F3),
        onTap: () => debugPrint('Theater category tapped'),
      ),
      CategoryItem(
        title: 'Fast Food',
        icon: Icons.fastfood,
        color: const Color(0xFFFF9800),
        onTap: () => debugPrint('Fast Food category tapped'),
      ),
    ];
  }

  List<HotDeal> _getHotDeals() {
    return [
      HotDeal(
        name: 'Amrutam Restaurant',
        rating: '4.9',
        offer: 'Up to 50% OFF',
        onTap: () => debugPrint('Amrutam Restaurant tapped'),
      ),
      HotDeal(
        name: 'Amruta',
        rating: '4.8',
        offer: 'Up to 30% OFF',
        onTap: () => debugPrint('Amruta tapped'),
      ),
    ];
  }

  List<MarketplaceItem> _getMarketplaceItems() {
    return [
      MarketplaceItem(
        name: 'iPhone 16 Pro Max',
        brand: 'amazon',
        price: '₹50,000',
        onTap: () => debugPrint('iPhone 16 Pro Max tapped'),
      ),
      MarketplaceItem(
        name: 'Apple Watch Series 9',
        brand: 'apple',
        price: '₹1,50,000',
        onTap: () => debugPrint('Apple Watch Series 9 tapped'),
      ),
      MarketplaceItem(
        name: 'Samsung Galaxy S24',
        brand: 'samsung',
        price: '₹50,000',
        onTap: () => debugPrint('Samsung Galaxy S24 tapped'),
      ),
      MarketplaceItem(
        name: 'iPhone 16 Pro Max',
        brand: 'amazon',
        price: '₹50,000',
        onTap: () => debugPrint('iPhone 16 Pro Max (2) tapped'),
      ),
    ];
  }
}
