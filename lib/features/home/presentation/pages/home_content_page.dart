import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';

/// Beautiful home content page with modern design and real data integration
class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: HomeDrawer(
        userName: 'Welcome',
        onMenuItemTap: _onDrawerMenuItemTap,
      ),
      body: _buildMainContent(),
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
                  _buildModernSpecialOffers(),
                  _buildCategoriesSection(),
                  _buildHotDealsSection(),
                  _buildSubscriptionPlansSection(),
                  _buildMarketplaceSection(),
                  const SizedBox(height: 40),
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
      expandedHeight: 80,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                children: [
                  // Top row with menu and action buttons
                  Row(
                    children: [
                      // Menu button
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A202C),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onMenuTap,
                            borderRadius: BorderRadius.circular(12),
                            child: const Center(
                              child: Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Action buttons
                      _buildActionButton(
                        icon: Icons.favorite_outline,
                        onTap: _onFavoriteTap,
                      ),
                      const SizedBox(width: 12),
                      _buildActionButton(
                        icon: Icons.notifications_none,
                        onTap: _onNotificationTap,
                        hasBadge: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Icon(icon, size: 20, color: const Color(0xFF1A202C)),
              ),
            ),
          ),
          if (hasBadge)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModernSpecialOffers() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const SpecialOffersSection(),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: CategoriesSection(onSeeAllTap: _onCategoriesSeeAllTap),
    );
  }

  Widget _buildSubscriptionPlansSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const SubscriptionPlansSection(),
    );
  }

  Widget _buildHotDealsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const HotDealsSection(),
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
          const MarketplaceSection(),
        ],
      ),
    );
  }

  // Event handlers
  void _onFavoriteTap() {
    HapticFeedback.lightImpact();
    debugPrint('Favorite tap');
  }

  void _onNotificationTap() {
    HapticFeedback.lightImpact();
    debugPrint('Notification tap');
  }

  void _onCategoriesSeeAllTap() {
    HapticFeedback.lightImpact();
    debugPrint('Categories see all tap');
  }

  void _onMarketplaceSeeAllTap() {
    HapticFeedback.lightImpact();
    debugPrint('Marketplace see all tap');
  }

  void _onMenuTap() {
    HapticFeedback.lightImpact();
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onDrawerMenuItemTap(String menuTitle) {
    HapticFeedback.lightImpact();
    debugPrint('Drawer menu item tapped: $menuTitle');
    // Navigation is handled in the drawer itself now
  }
}
