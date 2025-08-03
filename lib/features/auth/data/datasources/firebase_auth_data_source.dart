import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/features/auth/domain/entities/phone_auth.dart';

/// Firebase authentication data source
abstract class FirebaseAuthDataSource {
  /// Sends OTP to phone number
  Future<PhoneAuth> sendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Verifies OTP and signs in user
  Future<User> verifyOtp({
    required String verificationId,
    required String otp,
  });

  /// Resends OTP
  Future<PhoneAuth> resendOtp({
    required String phoneNumber,
    required String countryCode,
    int? forceResendingToken,
  });

  /// Signs out user
  Future<void> signOut();

  /// Gets current user
  User? get currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges;

  /// Gets ID token for current user
  Future<String?> getIdToken();
}

/// Implementation of Firebase authentication data source
@LazySingleton(as: FirebaseAuthDataSource)
class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  FirebaseAuthDataSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<PhoneAuth> sendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      final completer = Completer<PhoneAuth>();
      final completePhoneNumber = '$countryCode$phoneNumber';

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: completePhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(
            AuthException(
              message: e.message ?? 'Phone verification failed',
              statusCode: int.tryParse(e.code) ?? 0,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(
            PhoneAuth(
              phoneNumber: phoneNumber,
              countryCode: countryCode,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(
              PhoneAuth(
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                verificationId: verificationId,
              ),
            );
          }
        },
        timeout: const Duration(seconds: 60),
      );

      return completer.future;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Failed to send OTP',
        statusCode: int.tryParse(e.code) ?? 0,
      );
    } catch (e) {
      throw const AuthException(message: 'Failed to send OTP');
    }
  }

  @override
  Future<User> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) {
        throw const AuthException(message: 'Failed to verify OTP');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Failed to verify OTP',
        statusCode: int.tryParse(e.code) ?? 0,
      );
    } catch (e) {
      throw const AuthException(message: 'Failed to verify OTP');
    }
  }

  @override
  Future<PhoneAuth> resendOtp({
    required String phoneNumber,
    required String countryCode,
    int? forceResendingToken,
  }) async {
    try {
      final completer = Completer<PhoneAuth>();
      final completePhoneNumber = '$countryCode$phoneNumber';

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: completePhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(
            AuthException(
              message: e.message ?? 'Phone verification failed',
              statusCode: int.tryParse(e.code) ?? 0,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(
            PhoneAuth(
              phoneNumber: phoneNumber,
              countryCode: countryCode,
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(
              PhoneAuth(
                phoneNumber: phoneNumber,
                countryCode: countryCode,
                verificationId: verificationId,
              ),
            );
          }
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: forceResendingToken,
      );

      return completer.future;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Failed to resend OTP',
        statusCode: int.tryParse(e.code) ?? 0,
      );
    } catch (e) {
      throw const AuthException(message: 'Failed to resend OTP');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw const AuthException(message: 'Failed to sign out');
    }
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<String?> getIdToken() async {
    try {
      return await _firebaseAuth.currentUser?.getIdToken();
    } catch (e) {
      throw const AuthException(message: 'Failed to get ID token');
    }
  }
}
