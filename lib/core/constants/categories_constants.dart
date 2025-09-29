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
    'Consultancy',
    'Service centre',
    'Opticals',
    'Gym',
    'Mobile shop',
    'Clothing store',
    'Photography',
    'Designer',
    'Footwear',
    'Ice Cream',
    'Boutique',
    'Stationary',
    'Innerwear',
    'Spa',
    'Skin clinic',
    'Bag shop',
    'Handloom',
    'Tattoo',
    'Financial services',
    'Jewellers',
    'Belt and accessories',
    'Cosmetic shop',
    'Kitchen utensils',
    'salads and more',
    'Cafe',
    'Grocery',
    'Health and wellness',
    'indoor games',
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
    'Consultancy': 'assets/icons/categories/Consultancy.png',
    'Service centre': 'assets/icons/categories/ServiceCenter.png',
    'Opticals': 'assets/icons/categories/Opticals.png',
    'Gym': 'assets/icons/categories/Gym.png',
    'Mobile shop': 'assets/icons/categories/MobileShop.png',
    'Clothing store': 'assets/icons/categories/ClothingStore.png',
    'Photography': 'assets/icons/categories/Photography.png',
    'Designer': 'assets/icons/categories/Designer.png',
    'Footwear': 'assets/icons/categories/Footwear.png',
    'Ice Cream': 'assets/icons/categories/IceCream.png',
    'Boutique': 'assets/icons/categories/Boutique.png',
    'Stationary': 'assets/icons/categories/Stationary.png',
    'Innerwear': 'assets/icons/categories/Innerwear.png',
    'Spa': 'assets/icons/categories/Spa.png',
    'Skin clinic': 'assets/icons/categories/SkinClinic.png',
    'Bag shop': 'assets/icons/categories/BagShop.png',
    'Handloom': 'assets/icons/categories/Handloom.png',
    'Tattoo': 'assets/icons/categories/Tattoo.png',
    'Financial services': 'assets/icons/categories/FinancialServices.png',
    'Jewellers': 'assets/icons/categories/Jewellers.png',
    'Belt and accessories': 'assets/icons/categories/BeltAndAccessories.png',
    'Cosmetic shop': 'assets/icons/categories/CosmeticShop.png',
    'Kitchen utensils': 'assets/icons/categories/KitchenUtensils.png',
    'salads and more': 'assets/icons/categories/SaladsAndMore.png',
    'Cafe': 'assets/icons/categories/Cafe.png',
    'Grocery': 'assets/icons/categories/Grocery.png',
    'Health and wellness': 'assets/icons/categories/HealthAndWellness.png',
    'indoor games': 'assets/icons/categories/IndoorGames.png',
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
