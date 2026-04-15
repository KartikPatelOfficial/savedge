import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/city/presentation/widgets/city_selection_sheet.dart';

/// Page shown when user selects "Other" city (not available region)
///
/// Displays a friendly message and provides access to:
/// - Option to change city selection
class RegionUnavailablePage extends StatelessWidget {
  const RegionUnavailablePage({
    super.key,
  });

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
