import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'voice_consent_view_model.dart';

class _VCColors {
  static const bgGradientTop = Color(0xFFEDF2F8);
  static const bgGradientBottom = Color(0xFFF8FAFC);
  static const micCircle = Color(0xFF2072B2);
  static const cardBg = Color(0xFFF5F8FC);
  static const iconBg = Color(0xFFEBF2FA);
  static const featureTitle = Color(0xFF1E3A5F);
  static const featureDesc = Color(0xFF64748B);
  static const consentText = Color(0xFF475569);
  static const buttonActive = Color(0xFF2072B2);
  static const buttonInactive = Color(0xFFB0BEC5);
  static const skipText = Color(0xFF475569);
  static const muteChipBg = Color(0xFFFFFFFF);
  static const muteChipText = Color(0xFF64748B);
}

class VoiceConsentScreen extends ConsumerWidget {
  const VoiceConsentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceConsentViewModelProvider);
    final vm = ref.read(voiceConsentViewModelProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: _VCColors.bgGradientBottom,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_VCColors.bgGradientTop, _VCColors.bgGradientBottom],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                _SpeakChip(
                  isSpeaking: state.isSpeaking,
                  onTap: () => vm.toggleSpeak(
                    enableVoiceBanking: l10n.enableVoiceBanking,
                    secureAccountWithVoice: l10n.secureAccountWithVoice,
                    enhancedSecurity: l10n.enhancedSecurity,
                    enhancedSecurityDesc: l10n.enhancedSecurityDesc,
                    quickCommands: l10n.quickCommands,
                    quickCommandsDesc: l10n.quickCommandsDesc,
                    threeSimpleSteps: l10n.threeSimpleSteps,
                    threeSimpleStepsDesc: l10n.threeSimpleStepsDesc,
                  ),
                  l10n: l10n,
                ),
                const SizedBox(height: 32),
                _MicIcon(),
                const SizedBox(height: 24),
                Text(
                  l10n.enableVoiceBanking,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.secureAccountWithVoice,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: _VCColors.featureDesc,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                if (state.isSpeaking)
                  Lottie.asset(
                    AppAssets.voiceRecordingAnimation,
                    width: 200,
                    height: 200,
                  )
                else
                  _FeaturesCard(l10n: l10n),
                const SizedBox(height: 28),
                _ConsentRow(
                  isChecked: state.isConsentGiven,
                  onChanged: (_) => vm.toggleConsent(),
                  l10n: l10n,
                ),
                const SizedBox(height: 28),
                _StartRegistrationButton(
                  enabled: state.isConsentGiven,
                  label: l10n.startRegistration,
                  onTap: () => context.pushReplacement('/voice-registration'),
                ),
                const SizedBox(height: 16),
                _SkipButton(
                  label: l10n.skipForNow,
                  onTap: () => context.pop(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpeakChip extends StatelessWidget {
  final bool isSpeaking;
  final VoidCallback onTap;
  final AppLocalizations l10n;

  const _SpeakChip({
    required this.isSpeaking,
    required this.onTap,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _VCColors.muteChipBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isSpeaking ? l10n.tapToStop : l10n.tapToSpeak,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _VCColors.muteChipText,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                isSpeaking
                    ? Icons.stop_circle_rounded
                    : Icons.volume_up_rounded,
                size: 18,
                color: _VCColors.muteChipText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MicIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: _VCColors.micCircle,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _VCColors.micCircle.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.mic, color: Colors.white, size: 36),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  final AppLocalizations l10n;

  const _FeaturesCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: _VCColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          _FeatureRow(
            icon: Icons.shield_outlined,
            title: l10n.enhancedSecurity,
            description: l10n.enhancedSecurityDesc,
          ),
          const SizedBox(height: 20),
          _FeatureRow(
            icon: Icons.bolt_rounded,
            title: l10n.quickCommands,
            description: l10n.quickCommandsDesc,
          ),
          const SizedBox(height: 20),
          _FeatureRow(
            icon: Icons.check_circle_outline_rounded,
            title: l10n.threeSimpleSteps,
            description: l10n.threeSimpleStepsDesc,
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _VCColors.iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: _VCColors.micCircle, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _VCColors.featureTitle,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: _VCColors.featureDesc,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConsentRow extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final AppLocalizations l10n;

  const _ConsentRow({
    required this.isChecked,
    required this.onChanged,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: _VCColors.buttonActive,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildConsentRichText(l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentRichText(AppLocalizations l10n) {
    return Text(
      l10n.voiceConsentText,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: _VCColors.consentText,
        height: 1.5,
      ),
    );
  }
}

class _StartRegistrationButton extends StatelessWidget {
  final bool enabled;
  final String label;
  final VoidCallback onTap;

  const _StartRegistrationButton({
    required this.enabled,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? _VCColors.buttonActive : _VCColors.buttonInactive,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _VCColors.buttonInactive,
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: enabled ? 2 : 0,
          shadowColor: _VCColors.buttonActive.withValues(alpha: 0.3),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SkipButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _VCColors.skipText,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
