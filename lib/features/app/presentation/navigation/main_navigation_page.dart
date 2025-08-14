import 'package:flutter/material.dart';
import 'package:savedge/features/user_profile/presentation/pages/profile_page.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';
import 'package:savedge/features/coupons/presentation/pages/user_coupons_page.dart';

/// Main navigation wrapper that handles bottom navigation
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContentPage(), // Home page content without bottom nav
    const CartPage(), // Placeholder for cart page
    const GiftPage(), // Placeholder for gift page
    const UserCouponsPage(), // User coupons page
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

/// Cart page placeholder
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF6F3FCC),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gift page placeholder
class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Cards'),
        backgroundColor: const Color(0xFF6F3FCC),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No gift cards available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Home page content without bottom navigation bar
class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: HomeDrawer(
        userName: 'Jacob David',
        onMenuItemTap: _onDrawerMenuItemTap,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom Header
            SliverToBoxAdapter(
              child: HomeHeader(
                onLocationTap: _onLocationTap,
                onFavoriteTap: _onFavoriteTap,
                onNotificationTap: _onNotificationTap,
                onMenuTap: _onMenuTap,
              ),
            ),
            // Search Bar
            SliverToBoxAdapter(child: HomeSearchBar(onTap: _onSearchTap)),
            // Special Offers
            SliverToBoxAdapter(
              child: SpecialOffersSection(offers: _getSpecialOffers()),
            ),
            // Categories
            SliverToBoxAdapter(
              child: CategoriesSection(
                categories: _getCategories(),
                onSeeAllTap: _onCategoriesSeeAllTap,
              ),
            ),
            // Hot Deals
            SliverToBoxAdapter(child: HotDealsSection(deals: _getHotDeals())),
            // Membership Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SubscriptionPlansWidget(
                  plans: const [],
                  onPlanTap: (_) => debugPrint('Plan tapped'),
                  height: 200,
                ),
              ),
            ),
            // Marketplace
            SliverToBoxAdapter(
              child: MarketplaceSection(
                items: _getMarketplaceItems(),
                onSeeAllTap: _onMarketplaceSeeAllTap,
              ),
            ),
            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  // Event handlers
  void _onLocationTap() => debugPrint('Location tap');
  void _onFavoriteTap() => debugPrint('Favorite tap');
  void _onNotificationTap() => debugPrint('Notification tap');
  void _onSearchTap() => debugPrint('Search tap');
  void _onCategoriesSeeAllTap() => debugPrint('Categories see all tap');
  void _onMarketplaceSeeAllTap() => debugPrint('Marketplace see all tap');

  void _onMenuTap() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _onDrawerMenuItemTap(String menuTitle) {
    debugPrint('Drawer menu item tapped: $menuTitle');
    // TODO: Handle navigation based on menu item
    switch (menuTitle) {
      case 'Current Offers':
        // Navigate to offers page
        break;
      case 'Stores':
        // Navigate to stores page
        break;
      case 'About Us':
        // Navigate to about page
        break;
      case 'Feedback':
        // Navigate to feedback page
        break;
      case 'Contact Us':
        // Navigate to contact page
        break;
      case 'Follow Us':
        // Navigate to social media page
        break;
      case 'Brand Vouchers':
        // Navigate to vouchers page
        break;
    }
  }

  // Data providers matching the screenshot
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