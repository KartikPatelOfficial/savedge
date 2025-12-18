import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object?> get props => [];
}

/// Load list of available cities
class LoadCities extends CityEvent {
  const LoadCities();
}

/// Select a city (including "Other" option)
class SelectCity extends CityEvent {
  const SelectCity({
    required this.cityId,
    required this.cityName,
  });

  final int cityId;
  final String cityName;

  @override
  List<Object?> get props => [cityId, cityName];
}

/// Load saved city selection from storage
class LoadSavedCitySelection extends CityEvent {
  const LoadSavedCitySelection();
}

/// Clear city selection
class ClearCitySelection extends CityEvent {
  const ClearCitySelection();
}
