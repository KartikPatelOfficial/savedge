import 'package:equatable/equatable.dart';

/// City domain entity for regional filtering
class City extends Equatable {
  const City({
    required this.id,
    required this.name,
    required this.state,
    required this.displayName,
  });

  final int id;
  final String name;
  final String state;
  final String displayName;

  /// Special ID for "Other" city option
  static const int otherCityId = -1;

  /// Check if this is the "Other" city option
  bool get isOther => id == otherCityId;

  @override
  List<Object?> get props => [id, name, state, displayName];
}
