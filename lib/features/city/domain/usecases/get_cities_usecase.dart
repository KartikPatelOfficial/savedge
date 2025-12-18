import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/city/domain/entities/city.dart';
import 'package:savedge/features/city/domain/repositories/city_repository.dart';

/// Use case for retrieving the list of available cities
@injectable
class GetCitiesUseCase implements UseCase<List<City>, NoParams> {
  const GetCitiesUseCase(this.repository);

  final CityRepository repository;

  @override
  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return repository.getCities();
  }
}
