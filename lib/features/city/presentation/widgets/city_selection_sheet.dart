import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/features/city/domain/entities/city.dart';
import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/city/presentation/bloc/city_state.dart';

/// Bottom sheet for city selection
///
/// Shows a list of available cities plus an "Other" option for users
/// not in any of the available regions.
class CitySelectionSheet extends StatelessWidget {
  const CitySelectionSheet({
    super.key,
    this.onCitySelected,
    this.showCloseButton = true,
  });

  final Function(int cityId, String cityName)? onCitySelected;
  final bool showCloseButton;

  static Future<void> show(
    BuildContext context, {
    Function(int cityId, String cityName)? onCitySelected,
    bool showCloseButton = true,
    bool isDismissible = true,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CitySelectionSheet(
        onCitySelected: onCitySelected,
        showCloseButton: showCloseButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Your City',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose your city to see available vendors and offers',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // City list
              Expanded(
                child: BlocBuilder<CityBloc, CityState>(
                  builder: (context, state) {
                    if (state is CityLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is CityError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load cities',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                context.read<CityBloc>().add(const LoadCities());
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is CitiesLoaded) {
                      return ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: state.cities.length + 1, // +1 for "Other" option
                        itemBuilder: (context, index) {
                          if (index < state.cities.length) {
                            final city = state.cities[index];
                            return _CityTile(
                              city: city,
                              isSelected: state.selectedCityId == city.id,
                              onTap: () => _selectCity(context, city.id, city.displayName),
                            );
                          } else {
                            // "Other" option
                            return _CityTile(
                              city: null,
                              isOther: true,
                              isSelected: state.selectedCityId == City.otherCityId,
                              onTap: () => _selectCity(context, City.otherCityId, 'Other'),
                            );
                          }
                        },
                      );
                    }

                    // Initial state - trigger load
                    context.read<CityBloc>().add(const LoadCities());
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectCity(BuildContext context, int cityId, String cityName) {
    context.read<CityBloc>().add(SelectCity(
      cityId: cityId,
      cityName: cityName,
    ));
    onCitySelected?.call(cityId, cityName);
    Navigator.pop(context);
  }
}

class _CityTile extends StatelessWidget {
  const _CityTile({
    this.city,
    this.isOther = false,
    required this.isSelected,
    required this.onTap,
  });

  final City? city;
  final bool isOther;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isOther
              ? Colors.grey[200]
              : (isSelected ? theme.primaryColor.withOpacity(0.1) : Colors.blue[50]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isOther ? Icons.public : Icons.location_city,
          color: isOther ? Colors.grey[600] : (isSelected ? theme.primaryColor : Colors.blue),
        ),
      ),
      title: Text(
        isOther ? 'Other' : (city?.displayName ?? city?.name ?? ''),
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.primaryColor : null,
        ),
      ),
      subtitle: Text(
        isOther
            ? "My city isn't listed"
            : '${city?.name}, ${city?.state}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.grey[600],
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.primaryColor,
            )
          : null,
    );
  }
}
