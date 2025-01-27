import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bloc_pattern_firebase_tut/Models/User_Model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/auth_repository.dart';
import 'package:bloc_pattern_firebase_tut/Repository/user_repository.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthBlocBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<VerifyOtp>(_onVerifyOtp);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthBlocState> emit) async {
    try {
      final currentUser = _authRepository.currentUser;
      if (currentUser != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: "Failed to get current user: ${e.toString()}"));
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());

    final completer = Completer<void>();

    try {
      await _authRepository.verifyPhoneNumber(
        PhoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential, event.phoneNumber, emit);
          if (!completer.isCompleted) completer.complete();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (!emit.isDone) {
            emit(AuthError(message: e.message ?? "Authentication Error"));
          }
          if (!completer.isCompleted) completer.complete();
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification ID and inform the UI to show OTP input
          if (!emit.isDone) {
            emit(AuthOTP(phoneNumber: verificationId));
          }
          if (!completer.isCompleted) completer.complete();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!emit.isDone) {
            emit(AuthError(message: "Code retrieval timeout for ID: $verificationId"));
          }
          if (!completer.isCompleted) completer.complete();
        },
      );

      await completer.future;
    } catch (e) {
      if (!emit.isDone) {
        emit(AuthError(message: "Phone number verification failed: ${e.toString()}"));
      }
    }
  }

  void _onVerifyOtp(VerifyOtp event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.phoneNumber,
        smsCode: event.otp,
      );
      await _signInWithCredential(credential, event.phoneNumber, emit);
    } catch (e) {
      emit(AuthError(message: "OTP Verification failed: ${e.toString()}"));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthBlocState> emit) async {
    try {
      await _authRepository.singOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: "Logout failed: ${e.toString()}"));
    }
  }

  Future<void> _signInWithCredential(
    PhoneAuthCredential credential,
    String phoneNumber,
    Emitter<AuthBlocState> emit,
  ) async {
    try {
      UserCredential userCredential = await _authRepository.singInWithCredential(credential);
      String userName = _generateRandomUsername();
      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        fullName: "",
        userName: userName,
        userEmail: "",
        phoneNumber: phoneNumber,
        userPicture: "",
        country: "",
        language: "",
        premium: false,
        createDate: Timestamp.now(),
        pricingDate: Timestamp.now(),
        crateChats: [],
        attendChats: [],
        tokens: [],
      );
      await _userRepository.addUser(user: userModel);
      if (!emit.isDone) {
        emit(AuthAuthenticated());
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(AuthError(message: "Sign in failed: ${e.toString()}"));
      }
    }
  }

  String _generateRandomUsername() {
    final random = Random();
    final randomNumber = random.nextInt(9999999).toString().padLeft(7, '0');
    return 'user$randomNumber';
  }
}
