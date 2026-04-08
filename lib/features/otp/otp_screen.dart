import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../core/constants/app_assets.dart';
import '../../core/providers/providers.dart';
import '../../core/router/app_router.dart';
import '../../core/services/auth_session_repository.dart';
import '../../l10n/app_localizations.dart';
import 'otp_view_model.dart';

/// OTP verification screen – matches Figma design node 119-1745.
class OtpScreen extends ConsumerStatefulWidget {
  final OtpRouteParams params;

  const OtpScreen({super.key, required this.params});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late final TextEditingController _otpController;
  late final FocusNode _otpFocusNode;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _otpFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpViewModelProvider.notifier).startResendTimer();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otpViewModelProvider);
    final vm = ref.read(otpViewModelProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2072B2),
                Color(0xFF18405F),
                Color(0xFF163955),
              ],
              stops: [0.065, 0.456, 0.773],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Back button: arrow + "Back" text (Figma 119:1747)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, top: 8),
                    child: InkWell(
                      onTap: () => context.pop(),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.back,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: isSmallScreen ? 16 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo – Figma 119:1754, 210x210
                        SizedBox(height: isSmallScreen ? 12 : 24),
                        Center(
                          child: SizedBox(
                            width: isSmallScreen ? 180 : 210,
                            height: isSmallScreen ? 180 : 210,
                            child: SvgPicture.asset(
                              AppAssets.loginScreenLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 32),
                        // Title "Verify OTP" – Figma 119:1779, 30px bold
                        Text(
                          l10n.verifyOtp,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtitle – Figma 119:1781
                        Text(
                          l10n.enterFourDigitCode,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 28 : 36),
                        // Label "Enter OTP" – Figma 119:1785
                        Center(
                          child: Text(
                            l10n.enterOtp,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.43,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 4-digit OTP input – Figma slots 64x64, rounded 14px
                        _OtpInput(
                          controller: _otpController,
                          focusNode: _otpFocusNode,
                          onChanged: vm.setOtp,
                          onCompleted: (_) => vm.verify(
                            expectedOtp: widget.params.otp,
                            onSuccess: () async {
                              final prefs =
                                  await ref.read(sharedPreferencesProvider.future);
                              await AuthSessionRepository(prefs).saveSession(
                                mobileNumber: widget.params.mobileNumber,
                                otp: widget.params.otp,
                              );
                              if (context.mounted) context.go('/home');
                            },
                          ),
                          enabled: !state.isLoading,
                        ),
                        if (state.errorMessage != null) ...[
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              state.errorMessage!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFFF87171),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: isSmallScreen ? 24 : 32),
                        // Resend – Figma 119:1795 "Resend OTP in 27s"
                        _ResendSection(
                          resendSecondsRemaining: state.resendSecondsRemaining,
                          onResend: () => vm.resendOtp(onResent: () {}),
                          isLoading: state.isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer – Figma 119:1796 Terms & Conditions
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          l10n.termsDisclaimer,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to Terms & Conditions
                          },
                          child: Text(
                            l10n.termsAndConditions,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final bool enabled;

  const _OtpInput({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onCompleted,
    required this.enabled,
  });

  // Figma: bg rgba(255,255,255,0.2), border 0.542px rgba(255,255,255,0.3), rounded 14px
  static const _inputBg = Color(0x33FFFFFF);
  static const _inputBorder = Color(0x4DFFFFFF);

  @override
  Widget build(BuildContext context) {
    // Figma: InputOTPSlot 64x64
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: _inputBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _inputBorder, width: 0.54),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1),
      borderRadius: BorderRadius.circular(14),
    );

    return Pinput(
      controller: controller,
      focusNode: focusNode,
      length: 4,
      onChanged: onChanged,
      onCompleted: onCompleted,
      enabled: enabled,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

class _ResendSection extends StatelessWidget {
  final int resendSecondsRemaining;
  final VoidCallback onResend;
  final bool isLoading;

  const _ResendSection({
    required this.resendSecondsRemaining,
    required this.onResend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: resendSecondsRemaining > 0
          ? Text(
              l10n.otpResendIn(resendSecondsRemaining),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            )
          : TextButton(
              onPressed: isLoading ? null : onResend,
              child: Text(
                l10n.resendOtp,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
    );
  }
}
