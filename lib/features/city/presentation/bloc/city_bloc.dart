import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/core/utils/failure_message_mapper.dart';
import 'package:savedge/features/city/domain/entities/city.dart';
import 'package:savedge/features/city/domain/usecases/get_cities_usecase.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/city/presentation/bloc/city_state.dart';

/// BLoC for managing city selection state
///
/// Handles loading cities from API, persisting selection to storage,
/// and providing city-based access control for the app.
@injectable
class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc({
    required this.getCitiesUseCase,
    required this.storageService,
  }) : super(CityInitial()) {
    on<LoadCities>(_onLoadCities);
    on<SelectCity>(_onSelectCity);
    on<LoadSavedCitySelection>(_onLoadSavedCitySelection);
    on<ClearCitySelection>(_onClearCitySelection);
  }

  final GetCitiesUseCase getCitiesUseCase;
  final SecureStorageService storageService;

  Future<void> _onLoadCities(
    LoadCities event,
    Emitter<CityState> emit,
  ) async {
    emit(CityLoading());

    // First, get saved selection
    final savedCityId = await storageService.getSelectedCityId();
    final savedCityName = await storageService.getSelectedCityName();

    // Then fetch cities from API
    final result = await getCitiesUseCase(const NoParams());

    result.fold(
      (failure) => emit(
        CityError(FailureMessageMapper.mapFailureToMessage(failure)),
      ),
      (cities) => emit(
        CitiesLoaded(
          cities: cities,
          selectedCityId: savedCityId,
          selectedCityName: savedCityName,
        ),
      ),
    );
  }

  Future<void> _onSelectCity(
    SelectCity event,
    Emitter<CityState> emit,
  ) async {
    // Save to storage
    await storageService.saveSelectedCity(
      cityId: event.cityId,
      cityName: event.cityName,
    );

    // Update state
    if (state is CitiesLoaded) {
      emit((state as CitiesLoaded).copyWith(
        selectedCityId: event.cityId,
        selectedCityName: event.cityName,
      ));
    } else {
      emit(CitySelected(
        cityId: event.cityId,
        cityName: event.cityName,
      ));
    }
  }

  Future<void> _onLoadSavedCitySelection(
    LoadSavedCitySelection event,
    Emitter<CityState> emit,
  ) async {
    final savedCityId = await storageService.getSelectedCityId();
    final savedCityName = await storageService.getSelectedCityName();

    if (savedCityId != null && savedCityName != null) {
      emit(CitySelected(
        cityId: savedCityId,
        cityName: savedCityName,
      ));
    } else {
      // No city selected, stay in initial state
      emit(CityInitial());
    }
  }

  Future<void> _onClearCitySelection(
    ClearCitySelection event,
    Emitter<CityState> emit,
  ) async {
    await storageService.clearSelectedCity();

    if (state is CitiesLoaded) {
      emit((state as CitiesLoaded).copyWith(clearSelection: true));
    } else {
      emit(CityInitial());
    }
  }
}
