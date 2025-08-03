import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:savedge/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User data model for API communication
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String firebaseUid,
    String? firstName,
    String? lastName,
    int? organizationId,
    String? organizationName,
    @Default(0) int pointsBalance,
    DateTime? pointsExpiry,
    @Default(true) bool isActive,
    DateTime? createdAt,
    @Default(false) bool isEmployee,
    String? employeeCode,
    String? department,
    String? position,
    DateTime? joinDate,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts model to domain entity
  User toEntity() {
    return User(
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
      isEmployee: isEmployee,
      employeeCode: employeeCode,
      department: department,
      position: position,
      joinDate: joinDate,
    );
  }

  /// Creates model from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      firebaseUid: user.firebaseUid,
      firstName: user.firstName,
      lastName: user.lastName,
      organizationId: user.organizationId,
      organizationName: user.organizationName,
      pointsBalance: user.pointsBalance,
      pointsExpiry: user.pointsExpiry,
      isActive: user.isActive,
      createdAt: user.createdAt,
      isEmployee: user.isEmployee,
      employeeCode: user.employeeCode,
      department: user.department,
      position: user.position,
      joinDate: user.joinDate,
    );
  }
}
