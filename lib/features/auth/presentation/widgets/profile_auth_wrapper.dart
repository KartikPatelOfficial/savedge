import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/presentation/pages/phone_auth_page.dart';
import 'package:savedge/features/app/presentation/navigation/main_navigation_page.dart';
import 'package:savedge/features/auth/presentation/pages/register_individual_page.dart';
import 'package:savedge/features/auth/presentation/pages/register_employee_page.dart';

/// Enhanced auth wrapper that checks full user profile from /api/users/profile
class ProfileAuthWrapper extends StatefulWidget {
  const ProfileAuthWrapper({super.key});

  @override
  State<ProfileAuthWrapper> createState() => _ProfileAuthWrapperState();

  /// Global key to access the ProfileAuthWrapper state from anywhere
  static final GlobalKey globalKey = GlobalKey<State<ProfileAuthWrapper>>();

  /// Static method to trigger a recheck of auth status
  static void recheckAuthStatus() {
    final state = globalKey.currentState;
    if (state is _ProfileAuthWrapperState) {
      state._checkAuthStatus();
    }
  }
}

class _ProfileAuthWrapperState extends State<ProfileAuthWrapper> {
  bool _isLoading = true;
  String? _error;
  ProfileAuthStatus? _authStatus;
  StreamSubscription<User?>? _authSubscription;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
    _checkAuthStatus();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  void _setupAuthListener() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
      User? user,
    ) {
      // When auth state changes, recheck the status
      if (mounted) {
        _checkAuthStatus();
      }
    });
  }

  Future<void> _checkAuthStatus() async {
    print('ProfileAuthWrapper: Starting auth status check');
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
          _error = null;
        });
      }

      final firebaseUser = FirebaseAuth.instance.currentUser;
      print(
        'ProfileAuthWrapper: Firebase user: ${firebaseUser?.email ?? "null"}',
      );

      if (firebaseUser == null) {
        print('ProfileAuthWrapper: No Firebase user, showing phone auth');
        if (mounted) {
          setState(() {
            _authStatus = ProfileAuthStatus.unauthenticated;
            _isLoading = false;
          });
        }
        return;
      }

      // User is authenticated with Firebase, now check if user exists in backend
      try {
        print('ProfileAuthWrapper: Checking if user exists in backend...');
        final userExistsResponse = await _authRepository.checkUserExists(
          firebaseUser.uid,
        );

        if (userExistsResponse.exists &&
            userExistsResponse.userProfile != null) {
          // User exists, determine status based on profile completeness
          final profile = userExistsResponse.userProfile!;
          print('ProfileAuthWrapper: User exists: ${profile.email}');
          final extendedProfile = _mapToExtendedProfile(profile);
          final status = _determineAuthStatus(extendedProfile);
          print('ProfileAuthWrapper: Determined status: $status');

          if (mounted) {
            setState(() {
              _authStatus = status;
              _isLoading = false;
            });
          }
        } else {
          // User doesn't exist in backend, check if they're an employee
          print(
            'ProfileAuthWrapper: User not found, checking employee status...',
          );
          final phoneNumber = firebaseUser.phoneNumber;

          if (phoneNumber != null) {
            final employeeInfo = await _authRepository.checkEmployeeByPhone(
              phoneNumber,
            );

            if (employeeInfo != null) {
              print(
                'ProfileAuthWrapper: Found employee, showing employee registration',
              );
              if (mounted) {
                setState(() {
                  _authStatus = ProfileAuthStatus.employeeFound;
                  _isLoading = false;
                });
              }
            } else {
              print(
                'ProfileAuthWrapper: No employee found, showing individual registration',
              );
              if (mounted) {
                setState(() {
                  _authStatus = ProfileAuthStatus.needsRegistration;
                  _isLoading = false;
                });
              }
            }
          } else {
            print(
              'ProfileAuthWrapper: No phone number, showing individual registration',
            );
            if (mounted) {
              setState(() {
                _authStatus = ProfileAuthStatus.needsRegistration;
                _isLoading = false;
              });
            }
          }
        }
      } catch (e) {
        print('ProfileAuthWrapper: Error checking user status: $e');
        if (mounted) {
          setState(() {
            _authStatus = ProfileAuthStatus.error;
            _isLoading = false;
            _error = 'Failed to check user status: $e';
          });
        }
      }
    } catch (e) {
      print('ProfileAuthWrapper: General error: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
          _authStatus = ProfileAuthStatus.error;
          _isLoading = false;
        });
      }
    }
  }

  ExtendedUserProfile _mapToExtendedProfile(UserProfileResponse2 profile) {
    return ExtendedUserProfile(
      id: profile.id,
      email: profile.email,
      firstName: profile.firstName,
      lastName: profile.lastName,
      firebaseUid: profile.firebaseUid,
      organizationId: profile.organizationId,
      organizationName: profile.organizationName,
      pointsBalance: profile.pointsBalance,
      pointsExpiry: profile.pointsExpiry,
      isActive: profile.isActive,
      createdAt: profile.createdAt,
      roles: profile.roles,
      isEmployee: profile.isEmployee,
      employeeCode: profile.employeeCode,
      department: profile.department,
      position: profile.position,
      joinDate: profile.joinDate,
    );
  }

  ProfileAuthStatus _determineAuthStatus(dynamic profile) {
    // Determine status based on full profile data structure
    final hasNames =
        (profile.firstName?.isNotEmpty == true) &&
        (profile.lastName?.isNotEmpty == true);
    final hasOrganization = profile.organizationId != null;
    final isEmployee = profile.isEmployee == true;
    final isActive = profile.isActive == true;

    if (!isActive) {
      return ProfileAuthStatus.inactive;
    }

    if (hasNames) {
      // User has completed basic profile
      return ProfileAuthStatus.authenticated;
    } else if (hasOrganization && isEmployee) {
      // Employee found but profile incomplete
      return ProfileAuthStatus.employeeIncomplete;
    } else if (hasOrganization && !isEmployee) {
      // Organization assigned but not employee - treat as individual
      return ProfileAuthStatus.needsRegistration;
    } else {
      // New user needs registration
      return ProfileAuthStatus.needsRegistration;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking authentication...'),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Authentication Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _checkAuthStatus,
                    child: const Text('Retry'),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      _checkAuthStatus();
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Route based on auth status
    switch (_authStatus) {
      case ProfileAuthStatus.unauthenticated:
        return const PhoneAuthPage();

      case ProfileAuthStatus.authenticated:
        return const MainNavigationPage();

      case ProfileAuthStatus.needsRegistration:
        return const RegisterIndividualPage();

      case ProfileAuthStatus.employeeFound:
        return const RegisterEmployeePage();

      case ProfileAuthStatus.employeeIncomplete:
        return const RegisterEmployeePage();

      case ProfileAuthStatus.inactive:
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.block, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Account Inactive',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your account has been deactivated. Please contact support.',
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    _checkAuthStatus();
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        );

      default:
        return const PhoneAuthPage();
    }
  }
}

enum ProfileAuthStatus {
  unauthenticated,
  authenticated,
  needsRegistration,
  employeeIncomplete,
  employeeFound,
  inactive,
  error,
}
