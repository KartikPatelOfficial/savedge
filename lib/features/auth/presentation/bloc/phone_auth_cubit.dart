import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit(this._firebaseAuth) : super(const PhoneAuthInitial());
  final FirebaseAuth _firebaseAuth;
  String? _verificationId;

  Future<void> startPhoneVerification(String phoneNumber) async {
    emit(const PhoneAuthLoading());
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        try {
          final cred = await _firebaseAuth.signInWithCredential(credential);
          emit(PhoneAuthVerified(cred.user!));
        } catch (e) {
          emit(PhoneAuthError(e.toString()));
        }
      },
      verificationFailed: (e) => emit(PhoneAuthError(e.message ?? 'Verification failed')),
      codeSent: (verificationId, _) {
        _verificationId = verificationId;
        emit(const PhoneAuthCodeSent());
      },
      codeAutoRetrievalTimeout: (verificationId) => _verificationId = verificationId,
    );
  }

  Future<void> submitOtp(String smsCode) async {
    if (_verificationId == null) {
      emit(const PhoneAuthError('No verification in progress'));
      return;
    }
    emit(const PhoneAuthLoading());
    try {
      final credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode);
      final userCred = await _firebaseAuth.signInWithCredential(credential);
      emit(PhoneAuthVerified(userCred.user!));
    } catch (e) {
      emit(PhoneAuthError(e.toString()));
    }
  }
}
