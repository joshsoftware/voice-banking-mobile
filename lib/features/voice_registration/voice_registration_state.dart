/// State for voice registration flow (3 images, record, upload).
class VoiceRegistrationState {
  final int currentImageIndex;
  final bool isRecording;
  final bool isTTSPlaying;
  final bool isUploading;
  final List<String> recordedFilePaths;
  final List<String> selectedImagePaths;
  final List<String> selectedImageDescriptions;
  final String? errorMessage;
  final bool uploadSuccess;
  final DateTime? recordingStartedAt;

  const VoiceRegistrationState({
    required this.currentImageIndex,
    required this.isRecording,
    required this.isTTSPlaying,
    required this.isUploading,
    required this.recordedFilePaths,
    required this.selectedImagePaths,
    required this.selectedImageDescriptions,
    this.errorMessage,
    this.uploadSuccess = false,
    this.recordingStartedAt,
  });

  bool get hasCurrentRecording =>
      currentImageIndex < recordedFilePaths.length &&
      recordedFilePaths[currentImageIndex].isNotEmpty;

  bool get allRecordingsComplete =>
      recordedFilePaths.length == 3 &&
      recordedFilePaths.every((path) => path.isNotEmpty);

  bool get canProceedToNext =>
      hasCurrentRecording && !isRecording && !isTTSPlaying;

  VoiceRegistrationState copyWith({
    int? currentImageIndex,
    bool? isRecording,
    bool? isTTSPlaying,
    bool? isUploading,
    List<String>? recordedFilePaths,
    List<String>? selectedImagePaths,
    List<String>? selectedImageDescriptions,
    String? errorMessage,
    bool? uploadSuccess,
    DateTime? recordingStartedAt,
  }) {
    return VoiceRegistrationState(
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      isRecording: isRecording ?? this.isRecording,
      isTTSPlaying: isTTSPlaying ?? this.isTTSPlaying,
      isUploading: isUploading ?? this.isUploading,
      recordedFilePaths: recordedFilePaths ?? this.recordedFilePaths,
      selectedImagePaths: selectedImagePaths ?? this.selectedImagePaths,
      selectedImageDescriptions:
          selectedImageDescriptions ?? this.selectedImageDescriptions,
      errorMessage: errorMessage,
      uploadSuccess: uploadSuccess ?? this.uploadSuccess,
      recordingStartedAt: recordingStartedAt ?? this.recordingStartedAt,
    );
  }
}
