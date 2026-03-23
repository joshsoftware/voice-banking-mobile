import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_assets.dart';
import '../../core/router/app_router.dart';
import '../../l10n/app_localizations.dart';
import 'landing_view_model.dart';

/// Landing / Login screen – mobile number entry. Matches Figma design node 132-2638.
class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  late final TextEditingController _mobileController;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(landingViewModelProvider);
    final vm = ref.read(landingViewModelProvider.notifier);
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: isSmallScreen ? 20 : 28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: isSmallScreen ? 24 : 40),
                      Center(
                        child: SizedBox(
                          width: isSmallScreen ? 140 : 180,
                          height: isSmallScreen ? 140 : 180,
                          child: SvgPicture.asset(
                            AppAssets.loginScreenLogo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 28 : 40),
                      Text(
                        l10n.voiceBank,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.11,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.bankWithYourVoice,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.56,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 40 : 50),
                      Text(
                        l10n.mobileNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.43,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _MobileNumberInput(
                        controller: _mobileController,
                        onChanged: vm.setMobileNumber,
                        enabled: !state.isLoading,
                      ),
                      if (state.errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          state.errorMessage!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFF87171),
                          ),
                        ),
                      ],
                      SizedBox(height: isSmallScreen ? 24 : 28),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () => vm.submit(
                                    onSuccess: (mobile, otp) => context.push(
                                      '/otp',
                                      extra: OtpRouteParams(
                                        mobileNumber: mobile,
                                        otp: otp,
                                      ),
                                    ),
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4F9FF),
                            foregroundColor: const Color(0xFF1A1F36),
                            disabledBackgroundColor: Colors.white.withValues(alpha: 0.5),
                            elevation: 2,
                            shadowColor: Colors.black.withValues(alpha: 0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1A1F36)),
                                  ),
                                )
                              : Text(
                                  l10n.sendOtp,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 24 : 32),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 24),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool enabled;

  const _MobileNumberInput({
    required this.controller,
    required this.onChanged,
    required this.enabled,
  });

  static const _inputDecoration = BoxDecoration(
    color: Color(0x33FFFFFF),
    borderRadius: BorderRadius.all(Radius.circular(14)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0x4DFFFFFF), width: 0.54),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          width: 80,
          height: 52,
          decoration: _inputDecoration,
          alignment: Alignment.center,
          child: const Text(
            '+91',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
                        height: 52,
            decoration: _inputDecoration,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              enabled: enabled,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: l10n.mobileNumberPlaceholder,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
