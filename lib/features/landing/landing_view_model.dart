import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_config.dart';

/// State for the landing / login screen.
class LandingState {
  final String mobileNumber;
  final bool isLoading;
  final String? errorMessage;

  const LandingState({
    this.mobileNumber = '',
    this.isLoading = false,
    this.errorMessage,
  });

  LandingState copyWith({
    String? mobileNumber,
    bool? isLoading,
    String? errorMessage,
  }) =>
      LandingState(
        mobileNumber: mobileNumber ?? this.mobileNumber,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );
}

/// Notifier for landing screen logic.
class LandingViewModel extends Notifier<LandingState> {
  @override
  LandingState build() => const LandingState();

  void setMobileNumber(String value) {
    state = state.copyWith(mobileNumber: value, errorMessage: null);
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid mobile number';
    }
    if (value.length < 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  Future<void> submit({required void Function(String mobile, String otp) onSuccess}) async {
    final mobile = state.mobileNumber.trim();
    final error = validateMobile(mobile);
    if (error != null) {
      state = state.copyWith(errorMessage: error);
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate API delay; replace with real BankingAPI when integrated
    await Future<void>.delayed(const Duration(milliseconds: 800));

    state = state.copyWith(isLoading: false);
    onSuccess(mobile, AppConfig.mockLoginOtp);
  }
}

final landingViewModelProvider =
    NotifierProvider<LandingViewModel, LandingState>(LandingViewModel.new);
