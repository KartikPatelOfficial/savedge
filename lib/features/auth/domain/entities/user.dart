import 'package:equatable/equatable.dart';

import 'package:savedge/features/auth/data/models/user_model.dart';

/// User entity representing authenticated user
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.firebaseUid,
    this.firstName,
    this.lastName,
    this.organizationId,
    this.organizationName,
    this.pointsBalance = 0,
    this.pointsExpiry,
    this.isActive = true,
    this.createdAt,
    this.isEmployee = false,
    this.employeeCode,
    this.department,
    this.position,
    this.joinDate,
  });

  final String id;
  final String email;
  final String firebaseUid;
  final String? firstName;
  final String? lastName;
  final int? organizationId;
  final String? organizationName;
  final int pointsBalance;
  final DateTime? pointsExpiry;
  final bool isActive;
  final DateTime? createdAt;
  
  // Employee specific fields
  final bool isEmployee;
  final String? employeeCode;
  final String? department;
  final String? position;
  final DateTime? joinDate;

  /// Gets the full name of the user
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    if (firstName != null) return firstName!;
    if (lastName != null) return lastName!;
    return email.split('@').first;
  }

  /// Checks if user is part of an organization
  bool get isOrganizationMember => organizationId != null;

  /// Creates a copy of this user with updated fields
  User copyWith({
    String? id,
    String? email,
    String? firebaseUid,
    String? firstName,
    String? lastName,
    int? organizationId,
    String? organizationName,
    int? pointsBalance,
    DateTime? pointsExpiry,
    bool? isActive,
    DateTime? createdAt,
    bool? isEmployee,
    String? employeeCode,
    String? department,
    String? position,
    DateTime? joinDate,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      pointsBalance: pointsBalance ?? this.pointsBalance,
      pointsExpiry: pointsExpiry ?? this.pointsExpiry,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      isEmployee: isEmployee ?? this.isEmployee,
      employeeCode: employeeCode ?? this.employeeCode,
      department: department ?? this.department,
      position: position ?? this.position,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firebaseUid,
        firstName,
        lastName,
        organizationId,
        organizationName,
        pointsBalance,
        pointsExpiry,
        isActive,
        createdAt,
        isEmployee,
        employeeCode,
        department,
        position,
        joinDate,
      ];
}

/// Extension to convert User entity to UserModel
extension UserModelExtension on User {
  /// Converts entity to data model
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      firebaseUid: firebaseUid,
      firstName: firstName,
      lastName: lastName,
      organizationId: organizationId,
      organizationName: organizationName,
      pointsBalance: pointsBalance,
      pointsExpiry: pointsExpiry,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
