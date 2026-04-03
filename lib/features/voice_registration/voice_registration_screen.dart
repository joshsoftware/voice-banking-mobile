import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import 'voice_registration_state.dart';
import 'voice_registration_view_model.dart'
    show
        voiceRegistrationViewModelProvider,
        VoiceRegistrationViewModel,
        kMaxRecordingSeconds,
        kMinRecordingSeconds;

class _VRColors {
  static const bgGradientTop = Color(0xFFF4F9FF);
  static const bgGradientBottom = Color(0xFFF8FAFC);
  static const titleBlue = Color(0xFF2072B2);
  static const titleDark = Color(0xFF1A1F36);
  static const subtextGrey = Color(0xFF6B7C93);
  static const cardBorder = Color(0xFFE1E8ED);
  static const progressActive = Color(0xFF2072B2);
  static const progressInactive = Color(0xFFE2E8F0);
  static const micButtonGradientStart = Color(0xFF2072B2);
  static const micButtonGradientEnd = Color(0xFF13324A);
  static const reRecordBorder = Color(0xFF1F6FAD);
  static const reRecordText = Color(0xFF1F6FAD);
  static const submitGradientStart = Color(0xFF76A862);
  static const submitGradientEnd = Color(0xFF21550D);
  static const progressTrack = Color(0xFFD9D9D9);
  static const progressFill = Color(0xFF205A88);
  static const bottomSheetShadow = Color(0xFFAEAEAE);
  static const recordingTextBlue = Color(0xFF2072B2);
}

class VoiceRegistrationScreen extends ConsumerStatefulWidget {
  const VoiceRegistrationScreen({super.key});

  @override
  ConsumerState<VoiceRegistrationScreen> createState() =>
      _VoiceRegistrationScreenState();
}

class _VoiceRegistrationScreenState
    extends ConsumerState<VoiceRegistrationScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final l10n = AppLocalizations.of(context)!;
      final descriptions = [
        l10n.imageDescriptionBoardMeeting,
        l10n.imageDescriptionBoyWithDog,
        l10n.imageDescriptionChildrenPainting,
        l10n.imageDescriptionChildrenWithDog,
        l10n.imageDescriptionConstructionSite,
        l10n.imageDescriptionFamilyDinner,
        l10n.imageDescriptionHoliCelebration,
        l10n.imageDescriptionLadyPainting,
        l10n.imageDescriptionMomAndSon,
        l10n.imageDescriptionPeopleDiwaliCelebration,
        l10n.imageDescriptionTajMahal,
        l10n.imageDescriptionVillageScene,
        l10n.imageDescriptionWomenDiwaliCelebration,
      ];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(voiceRegistrationViewModelProvider.notifier)
            .initialize(descriptions);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(voiceRegistrationViewModelProvider);
    final vm = ref.read(voiceRegistrationViewModelProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return asyncState.when(
      loading: () => _buildScaffold(
        context,
        appBar: _buildAppBar(context, l10n, isUploading: false),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => _buildScaffold(
        context,
        appBar: _buildAppBar(context, l10n, isUploading: false),
        body: Center(child: Text('${l10n.unknownState}: $e')),
      ),
      data: (state) {
        final isUploading = state.isUploading;
        return PopScope(
          canPop: !isUploading,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop && isUploading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.pleaseWaitForUpload),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: _buildScaffold(
            context,
            appBar: _buildAppBar(context, l10n, isUploading: isUploading),
            body: _buildBody(context, state, vm, l10n, locale),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isUploading,
  }) {
    return AppBar(
      title: Text(l10n.voiceRegistration),
      centerTitle: true,
      backgroundColor: _VRColors.titleBlue,
      foregroundColor: Colors.white,
      leading: isUploading
          ? const SizedBox.shrink()
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    required PreferredSizeWidget appBar,
    required Widget body,
  }) {
    return Scaffold(
      backgroundColor: _VRColors.bgGradientBottom,
      appBar: appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_VRColors.bgGradientTop, _VRColors.bgGradientBottom],
            stops: [0.0, 0.4],
          ),
        ),
        child: body,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    VoiceRegistrationState state,
    VoiceRegistrationViewModel vm,
    AppLocalizations l10n,
    String localeCode,
  ) {
    ref.listen<AsyncValue<VoiceRegistrationState>>(
      voiceRegistrationViewModelProvider,
      (prev, next) {
        next.whenData((s) {
          if (s.errorMessage != null && s.errorMessage!.isNotEmpty) {
            final msg = _translateErrorMessage(s.errorMessage!, l10n);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
            vm.clearErrorMessage();
          }
          if (s.uploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.voiceRegistrationCompleted),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) context.pop(true);
            });
          }
        });
      },
    );

    final content = SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 260),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // _ProgressIndicator(currentIndex: state.currentImageIndex),
          const SizedBox(height: 16),
          _Header(l10n: l10n),
          const SizedBox(height: 30),
          _ImageCard(
            currentIndex: state.currentImageIndex,
            imagePaths: state.selectedImagePaths,
            isRecording: state.isRecording,
            isTTSPlaying: state.isTTSPlaying,
            isUploading: state.isUploading,
            localizedDescriptions: state.selectedImageDescriptions,
            localeCode: localeCode,
            onPlayTTS: () => vm.playTTS(localeCode),
            onStopTTS: () => vm.stopTTS(),
            l10n: l10n,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );

    final bottomSheet = _BottomPanel(
      state: state,
      vm: vm,
      l10n: l10n,
    );

    if (state.isUploading) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(child: content),
              bottomSheet,
            ],
          ),
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    l10n.uploadingVoiceRecordings,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Expanded(child: content),
        bottomSheet,
      ],
    );
  }

  String _translateErrorMessage(String errorMessage, AppLocalizations loc) {
    if (errorMessage.contains('Please wait for the description to finish playing')) {
      return loc.pleaseWaitForDescription;
    }
    if (errorMessage.contains('Microphone permission is required')) {
      return loc.microphonePermissionRequired;
    }
    if (errorMessage.contains('Failed to start recording')) {
      final parts = errorMessage.split(':');
      return loc.failedToStartRecording(parts.length > 1 ? parts.sublist(1).join(':').trim() : errorMessage);
    }
    if (errorMessage.contains('Recording failed')) return loc.recordingFailed;
    if (errorMessage.contains('Recording file not found')) return loc.recordingFileNotFound;
    if (errorMessage.contains('Recording is empty')) return loc.recordingEmpty;
    if (errorMessage.contains('Please speak for at least')) {
      return loc.pleaseSpeakAtLeastSeconds(kMinRecordingSeconds);
    }
    if (errorMessage.contains('Please speak something')) return loc.pleaseSaySomething;
    if (errorMessage.contains('Failed to stop recording')) {
      final parts = errorMessage.split(':');
      return loc.failedToStopRecording(parts.length > 1 ? parts.sublist(1).join(':').trim() : errorMessage);
    }
    if (errorMessage.contains('Please stop recording before playing')) {
      return loc.pleaseStopRecordingBeforePlay;
    }
    if (errorMessage.contains('Failed to play description')) {
      final parts = errorMessage.split(':');
      return loc.failedToPlayDescription(parts.length > 1 ? parts.sublist(1).join(':').trim() : errorMessage);
    }
    if (errorMessage.contains('Failed to stop description')) {
      final parts = errorMessage.split(':');
      return loc.failedToStopDescription(parts.length > 1 ? parts.sublist(1).join(':').trim() : errorMessage);
    }
    if (errorMessage.contains('Please record your voice before proceeding')) {
      return loc.pleaseRecordBeforeProceeding;
    }
    if (errorMessage.contains('Please wait for recording or description to complete')) {
      return loc.pleaseWaitForRecordingOrDescription;
    }
    if (errorMessage.contains('Please complete all 3 recordings')) {
      return loc.pleaseCompleteAllRecordings;
    }
    if (errorMessage.contains('User ID not found')) return loc.userIdNotFound;
    if (errorMessage.contains('recording files are missing') || errorMessage.contains('files are missing')) {
      return loc.recordingFilesMissing;
    }
    return errorMessage;
  }
}

class _Header extends StatelessWidget {
  final AppLocalizations l10n;

  const _Header({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _VRColors.titleDark,
              height: 1.2,
            ),
            children: [
              TextSpan(text: l10n.setUpVoiceByDescribing),
              TextSpan(
                text: l10n.describingTheImage,
                style: const TextStyle(color: _VRColors.titleBlue),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          l10n.takesUnder15Seconds,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: _VRColors.subtextGrey,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentIndex;

  const _ProgressIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index <= currentIndex
                    ? _VRColors.progressActive
                    : _VRColors.progressInactive,
                border: Border.all(
                  color: index == currentIndex
                      ? _VRColors.progressActive
                      : _VRColors.progressInactive,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: index <= currentIndex
                        ? Colors.white
                        : _VRColors.subtextGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (index < 2)
              Container(
                width: 40,
                height: 2,
                color: index < currentIndex
                    ? _VRColors.progressActive
                    : _VRColors.progressInactive,
              ),
          ],
        );
      }),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final int currentIndex;
  final List<String> imagePaths;
  final bool isRecording;
  final bool isTTSPlaying;
  final bool isUploading;
  final List<String> localizedDescriptions;
  final String localeCode;
  final VoidCallback onPlayTTS;
  final VoidCallback onStopTTS;
  final AppLocalizations l10n;

  const _ImageCard({
    required this.currentIndex,
    required this.imagePaths,
    required this.isRecording,
    required this.isTTSPlaying,
    required this.isUploading,
    required this.localizedDescriptions,
    required this.localeCode,
    required this.onPlayTTS,
    required this.onStopTTS,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final canPlay = !isRecording && !isUploading;
    final canStop = isTTSPlaying && !isUploading;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _VRColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 70,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 320,
          child: Stack(
            fit: StackFit.expand,
            children: [
              currentIndex < imagePaths.length
                  ? Image.asset(
                      imagePaths[currentIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildErrorContent(),
                    )
                  : Center(child: Text(l10n.imageNotAvailable)),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: (canPlay || canStop)
                        ? () {
                            if (isTTSPlaying) {
                              onStopTTS();
                            } else {
                              onPlayTTS();
                            }
                          }
                        : null,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        isTTSPlaying ? Icons.stop : Icons.volume_up_rounded,
                        size: 20,
                        color: (canPlay || canStop)
                            ? (isTTSPlaying ? Colors.red : _VRColors.titleBlue)
                            : _VRColors.subtextGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image, size: 64, color: _VRColors.subtextGrey),
          const SizedBox(height: 8),
          Text(
            l10n.imageNumber(currentIndex + 1),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _VRColors.subtextGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.somethingWentWrong,
            style: const TextStyle(fontSize: 12, color: _VRColors.subtextGrey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomPanel extends StatelessWidget {
  final VoiceRegistrationState state;
  final VoiceRegistrationViewModel vm;
  final AppLocalizations l10n;

  const _BottomPanel({
    required this.state,
    required this.vm,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final showRecordingUI = state.isRecording || state.hasCurrentRecording;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: _VRColors.bottomSheetShadow.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(-0.5, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: showRecordingUI ? 28 : 20),
            if (state.isRecording) ...[
              _RecordingProgressContent(
                recordingStartedAt: state.recordingStartedAt!,
                maxDurationSeconds: kMaxRecordingSeconds,
                l10n: l10n,
                onStop: vm.stopRecording,
              ),
            ] else if (state.hasCurrentRecording) ...[
              _ActionButtons(state: state, vm: vm, l10n: l10n),
            ] else
              _TapToSpeakContent(
                onMicTap: vm.startRecording,
                disabled: state.isTTSPlaying || state.isUploading,
                l10n: l10n,
              ),
          ],
        ),
      ),
    );
  }
}

class _RecordingProgressContent extends StatefulWidget {
  final DateTime recordingStartedAt;
  final int maxDurationSeconds;
  final AppLocalizations l10n;
  final VoidCallback onStop;

  const _RecordingProgressContent({
    required this.recordingStartedAt,
    required this.maxDurationSeconds,
    required this.l10n,
    required this.onStop,
  });

  @override
  State<_RecordingProgressContent> createState() =>
      _RecordingProgressContentState();
}

class _RecordingProgressContentState extends State<_RecordingProgressContent> {
  Timer? _timer;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _updateProgress();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) _updateProgress();
    });
  }

  void _updateProgress() {
    final elapsed = DateTime.now().difference(widget.recordingStartedAt);
    final seconds = elapsed.inMilliseconds / 1000.0;
    final p = (seconds / widget.maxDurationSeconds).clamp(0.0, 1.0);
    if (p != _progress) {
      setState(() => _progress = p);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_progress * 100).round();
    return Column(
      children: [
        Text(
          widget.l10n.recordingPercent(percent),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _VRColors.recordingTextBlue,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 3,
            backgroundColor: _VRColors.progressTrack,
            valueColor: const AlwaysStoppedAnimation<Color>(_VRColors.progressFill),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: widget.onStop,
          child: Container(
            height: 50,
            constraints: const BoxConstraints(minWidth: 138),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.l10n.stopRecording,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TapToSpeakContent extends StatelessWidget {
  final VoidCallback onMicTap;
  final bool disabled;
  final AppLocalizations l10n;

  const _TapToSpeakContent({
    required this.onMicTap,
    required this.disabled,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 220,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(52),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFEFEFEF),
                blurRadius: 4,
                offset: Offset(0.5, -5),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: disabled ? null : onMicTap,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                gradient: disabled
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _VRColors.micButtonGradientStart,
                          _VRColors.micButtonGradientEnd,
                        ],
                      ),
                color: disabled ? _VRColors.progressInactive : null,
                borderRadius: BorderRadius.circular(999),
                boxShadow: disabled
                    ? null
                    : [
                        BoxShadow(
                          color: const Color(0xFF1A4568).withValues(alpha: 0.5),
                          blurRadius: 50,
                          offset: const Offset(0, 25),
                        ),
                      ],
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.mic_rounded,
                color: disabled ? _VRColors.subtextGrey : Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.tapToStartSpeaking,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A476A),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final VoiceRegistrationState state;
  final VoiceRegistrationViewModel vm;
  final AppLocalizations l10n;

  const _ActionButtons({
    required this.state,
    required this.vm,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isStep3 = state.currentImageIndex == 2;
    final showNext = !isStep3 && state.hasCurrentRecording;
    final showRegister = isStep3 && state.hasCurrentRecording;
    final canProceed = state.canProceedToNext && !state.isUploading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ReRecordButton(
          onPressed: () => vm.reRecord(),
          label: l10n.reRecord,
        ),
        if (showNext || showRegister) ...[
          const SizedBox(width: 35),
          if (showNext)
            _NextButton(
              onPressed: canProceed ? () => vm.nextImage() : null,
              l10n: l10n,
              enabled: canProceed,
            )
          else
            _SubmitButton(
              onPressed: () => vm.submitVoiceRegistration(),
              label: l10n.register,
              disabled: state.isUploading,
            ),
        ],
      ],
    );
  }
}

class _ReRecordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const _ReRecordButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        constraints: const BoxConstraints(minWidth: 138),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _VRColors.reRecordBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A4568).withValues(alpha: 0.6),
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _VRColors.reRecordText,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final AppLocalizations l10n;
  final bool enabled;

  const _NextButton({
    required this.onPressed,
    required this.l10n,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        height: 50,
        constraints: const BoxConstraints(minWidth: 138),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: enabled
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _VRColors.submitGradientStart,
                    _VRColors.submitGradientEnd,
                  ],
                )
              : null,
          color: enabled ? null : _VRColors.progressInactive,
          borderRadius: BorderRadius.circular(999),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: const Color(0xFF1A4568).withValues(alpha: 0.5),
                    blurRadius: 50,
                    offset: const Offset(0, 25),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          l10n.nextStep,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: enabled ? Colors.white : _VRColors.subtextGrey,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool disabled;

  const _SubmitButton({
    required this.onPressed,
    required this.label,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        height: 50,
        constraints: const BoxConstraints(minWidth: 138),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: disabled
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _VRColors.submitGradientStart,
                    _VRColors.submitGradientEnd,
                  ],
                ),
          color: disabled ? _VRColors.progressInactive : null,
          borderRadius: BorderRadius.circular(999),
          boxShadow: disabled
              ? null
              : [
                  BoxShadow(
                    color: const Color(0xFF1A4568).withValues(alpha: 0.5),
                    blurRadius: 50,
                    offset: const Offset(0, 25),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: disabled ? _VRColors.subtextGrey : Colors.white,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
