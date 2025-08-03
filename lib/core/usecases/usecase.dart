import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:savedge/core/error/failures.dart';

/// Base class for all use cases in the application
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters
  Future<Either<Failure, Type>> call(Params params);
}

/// Base class for use cases that don't require parameters
abstract class NoParamsUseCase<Type> {
  /// Executes the use case without parameters
  Future<Either<Failure, Type>> call();
}

/// No parameters class for use cases that don't need any input
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
