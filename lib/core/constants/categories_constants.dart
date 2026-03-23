/// Categories constants with icon mappings
class CategoriesConstants {
  CategoriesConstants._();

  /// List of all available categories
  static const List<String> categories = [
    'Fast food',
    'Dessert',
    'Restaurant',
    'Tours and travels',
    'Salon',
    'Resort and Gateways',
    'Opticals',
    'Gym',
    'Hotels',
    'Multiplex',
    'Mobile shop',
    'Clothing store',
    'Photography',
    'Designer',
    'Footwear',
    'Ice Cream',
    'Boutique',
    'Innerwear',
    'Spa',
    'Skin clinic',
    'Tattoo',
    'Jewellers',
    'Belt and accessories',
    'Cosmetic shop',
    'Kitchen utensils',
    'Salads and More',
    'Cafe',
    'Health and wellness',
    'Indoor Games',
    'Others',
  ];

  /// Map category names to icon asset paths
  static const Map<String, String> categoryIcons = {
    'Fast food': 'assets/icons/categories/FastFood.png',
    'Dessert': 'assets/icons/categories/Dessert.png',
    'Restaurant': 'assets/icons/categories/Restaurant.png',
    'Tours and travels': 'assets/icons/categories/ToursAndTravels.png',
    'Salon': 'assets/icons/categories/Salon.png',
    'Resort and Gateways': 'assets/icons/categories/ResortAndGateways.png',
    'Multiplex': 'assets/icons/categories/Multiplex.png',
    'Opticals': 'assets/icons/categories/Opticals.png',
    'Gym': 'assets/icons/categories/Gym.png',
    'Hotels': 'assets/icons/categories/Hotels.png',
    'Mobile shop': 'assets/icons/categories/MobileShop.png',
    'Clothing store': 'assets/icons/categories/ClothingStore.png',
    'Photography': 'assets/icons/categories/Photography.png',
    'Designer': 'assets/icons/categories/Designer.png',
    'Footwear': 'assets/icons/categories/Footwear.png',
    'Ice Cream': 'assets/icons/categories/IceCream.png',
    'Boutique': 'assets/icons/categories/Boutique.png',
    'Innerwear': 'assets/icons/categories/Innerwear.png',
    'Spa': 'assets/icons/categories/Spa.png',
    'Skin clinic': 'assets/icons/categories/SkinClinic.png',
    'Tattoo': 'assets/icons/categories/Tattoo.png',
    'Jewellers': 'assets/icons/categories/Jewellers.png',
    'Belt and accessories': 'assets/icons/categories/BeltAndAccessories.png',
    'Cosmetic shop': 'assets/icons/categories/CosmeticShop.png',
    'Kitchen utensils': 'assets/icons/categories/KitchenUtensils.png',
    'Salads and More': 'assets/icons/categories/SaladsAndMore.png',
    'Cafe': 'assets/icons/categories/Cafe.png',
    'Health and wellness': 'assets/icons/categories/HealthAndWellness.png',
    'Indoor Games': 'assets/icons/categories/IndoorGames.png',
    'Others': 'assets/icons/categories/Others.png',
  };

  /// Get icon asset path for a category
  /// Returns default icon if category not found
  static String getCategoryIcon(String category) {
    return categoryIcons[category] ?? categoryIcons['Others']!;
  }

  /// Get normalized category name for icon lookup
  static String normalizeCategoryName(String category) {
    return category.toLowerCase().trim();
  }

  /// Check if category exists
  static bool isValidCategory(String category) {
    return categories.contains(category);
  }
}
