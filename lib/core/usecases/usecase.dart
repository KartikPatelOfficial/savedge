import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';

/// Base class for use cases
abstract class UseCase<Type, Params> {
  const UseCase();

  /// Executes the use case with the given parameters
  Future<Either<Failure, Type>> call(Params params);
}

/// Empty parameters for use cases that don't need parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
