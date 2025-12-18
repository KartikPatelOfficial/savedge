import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/city/presentation/widgets/city_selection_sheet.dart';

/// Page shown when user selects "Other" city (not available region)
///
/// Displays a friendly message and provides access to:
/// - Gift Vouchers feature
/// - Brand Vouchers feature
/// - Option to change city selection
class RegionUnavailablePage extends StatelessWidget {
  const RegionUnavailablePage({
    super.key,
    this.onNavigateToGiftVouchers,
    this.onNavigateToBrandVouchers,
  });

  final VoidCallback? onNavigateToGiftVouchers;
  final VoidCallback? onNavigateToBrandVouchers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                // Illustration
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_off_outlined,
                    size: 80,
                    color: Colors.orange[400],
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  'We\'re Not in Your Area Yet',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Description
                Text(
                  'We\'re sorry, but SavEdge vendor services are not available in your region yet. We\'re expanding rapidly and hope to be in your city soon!',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Available features section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[600],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Features Still Available',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'You can still enjoy our Gift Vouchers and Brand Vouchers features while we work on expanding to your area.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Action buttons
                _FeatureButton(
                  icon: Icons.card_giftcard,
                  title: 'Gift Vouchers',
                  subtitle: 'Send digital gift cards to friends and family',
                  color: Colors.purple,
                  onTap: onNavigateToGiftVouchers,
                ),
                const SizedBox(height: 12),
                _FeatureButton(
                  icon: Icons.loyalty,
                  title: 'Brand Vouchers',
                  subtitle: 'Purchase vouchers from popular brands',
                  color: Colors.blue,
                  onTap: onNavigateToBrandVouchers,
                ),
                const SizedBox(height: 32),
                // Change city button
                TextButton.icon(
                  onPressed: () => _changeCity(context),
                  icon: const Icon(Icons.edit_location_alt),
                  label: const Text('Change City'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeCity(BuildContext context) {
    // Clear current selection first
    context.read<CityBloc>().add(const ClearCitySelection());
    // Then show city selection sheet
    CitySelectionSheet.show(
      context,
      showCloseButton: false,
      isDismissible: false,
    );
  }
}

class _FeatureButton extends StatelessWidget {
  const _FeatureButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
