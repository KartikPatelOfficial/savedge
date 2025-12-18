import 'package:equatable/equatable.dart';
import 'package:savedge/features/city/domain/entities/city.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CityInitial extends CityState {}

/// Loading cities from API
class CityLoading extends CityState {}

/// Cities loaded successfully
class CitiesLoaded extends CityState {
  const CitiesLoaded({
    required this.cities,
    this.selectedCityId,
    this.selectedCityName,
  });

  final List<City> cities;
  final int? selectedCityId;
  final String? selectedCityName;

  /// Check if a city is selected
  bool get hasCitySelected => selectedCityId != null;

  /// Check if "Other" city is selected (user not in available regions)
  bool get isOtherCitySelected => selectedCityId == City.otherCityId;

  /// Check if user can access full vendor functionality
  bool get canAccessVendors => hasCitySelected && !isOtherCitySelected;

  CitiesLoaded copyWith({
    List<City>? cities,
    int? selectedCityId,
    String? selectedCityName,
    bool clearSelection = false,
  }) {
    return CitiesLoaded(
      cities: cities ?? this.cities,
      selectedCityId: clearSelection ? null : (selectedCityId ?? this.selectedCityId),
      selectedCityName: clearSelection ? null : (selectedCityName ?? this.selectedCityName),
    );
  }

  @override
  List<Object?> get props => [cities, selectedCityId, selectedCityName];
}

/// City selection state - used when user has selected a city but cities list may not be loaded
class CitySelected extends CityState {
  const CitySelected({
    required this.cityId,
    required this.cityName,
  });

  final int cityId;
  final String cityName;

  /// Check if "Other" city is selected
  bool get isOtherCity => cityId == City.otherCityId;

  /// Check if user can access full vendor functionality
  bool get canAccessVendors => !isOtherCity;

  @override
  List<Object?> get props => [cityId, cityName];
}

/// Error state
class CityError extends CityState {
  const CityError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
