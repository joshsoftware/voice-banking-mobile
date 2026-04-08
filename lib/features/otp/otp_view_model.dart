import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for the OTP verification screen.
class OtpState {
  final String otp;
  final bool isLoading;
  final int resendSecondsRemaining;
  final String? errorMessage;

  const OtpState({
    this.otp = '',
    this.isLoading = false,
    this.resendSecondsRemaining = 0,
    this.errorMessage,
  });

  bool get canResend => resendSecondsRemaining <= 0;

  OtpState copyWith({
    String? otp,
    bool? isLoading,
    int? resendSecondsRemaining,
    String? errorMessage,
  }) =>
      OtpState(
        otp: otp ?? this.otp,
        isLoading: isLoading ?? this.isLoading,
        resendSecondsRemaining: resendSecondsRemaining ?? this.resendSecondsRemaining,
        errorMessage: errorMessage,
      );
}

/// Notifier for OTP verification screen logic.
class OtpViewModel extends AutoDisposeNotifier<OtpState> {
  Timer? _resendTimer;

  @override
  OtpState build() {
    ref.onDispose(() {
      _resendTimer?.cancel();
    });
    return const OtpState();
  }

  void setOtp(String value) {
    state = state.copyWith(otp: value, errorMessage: null);
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    state = state.copyWith(resendSecondsRemaining: 30);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.resendSecondsRemaining <= 0) {
        _resendTimer?.cancel();
        return;
      }
      state = state.copyWith(resendSecondsRemaining: state.resendSecondsRemaining - 1);
    });
  }

  String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length != 4) {
      return 'Please enter a valid 4-digit code';
    }
    return null;
  }

  Future<void> verify({
    required String expectedOtp,
    required Future<void> Function() onSuccess,
  }) async {
    final otp = state.otp.trim();
    final error = validateOtp(otp);
    if (error != null) {
      state = state.copyWith(errorMessage: error);
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate API delay; replace with real BankingAPI when integrated
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (otp == expectedOtp) {
      try {
        await onSuccess();
      } finally {
        state = state.copyWith(isLoading: false);
      }
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Please enter a valid 4-digit code',
      );
    }
  }

  Future<void> resendOtp({required void Function() onResent}) async {
    if (!state.canResend) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate API delay
    await Future<void>.delayed(const Duration(milliseconds: 600));

    state = state.copyWith(isLoading: false);
    startResendTimer();
    onResent();
  }
}

final otpViewModelProvider =
    NotifierProvider.autoDispose<OtpViewModel, OtpState>(OtpViewModel.new);
