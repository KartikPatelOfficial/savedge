import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.organizationId,
    required this.pointsBalance,
    this.pointsExpiry,
    this.isActive,
    this.createdAt,
  });

  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final int? organizationId;
  final int pointsBalance;
  final DateTime? pointsExpiry;
  final bool? isActive;
  final DateTime? createdAt;

  bool get hasCompletedProfile =>
      (firstName?.isNotEmpty ?? false) || (lastName?.isNotEmpty ?? false);

  @override
  List<Object?> get props => [
    id,
    email,
    firstName,
    lastName,
    organizationId,
    pointsBalance,
    pointsExpiry,
    isActive,
    createdAt,
  ];
}
