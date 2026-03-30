import AVFoundation
import Flutter
import Foundation
import PipecatClientIOS
import PipecatClientIOSSmallWebrtc

private let kTag = "PipecatBridge"

// MARK: - PipecatBridge

/// iOS-side implementation of the Pigeon-generated `PipecatHostApi` protocol
/// and `StreamEventsStreamHandler` base class.
///
/// Uses **SmallWebRTC** transport — `POST {baseUrl}/start`, then SDP at
/// `{baseUrl}/sessions/{sessionId}/api/offer` (handled inside `SmallWebRTCTransport`).
///
/// Threading: All event sink pushes are dispatched on `DispatchQueue.main`.
/// `PipecatClient` is `@MainActor`; entry points hop to the main actor for SDK calls.
class PipecatBridge: StreamEventsStreamHandler, PipecatHostApi, PipecatClientDelegate {

    private var client: PipecatClient?
    private var startBotRequest: APIRequest?
    private var eventSink: PigeonEventSink<PipecatEventData>?
    private var sessionConfig: SessionConfig?
    private var audioSessionConfigured = false
    private var interruptionObserver: NSObjectProtocol?

    // MARK: StreamEventsStreamHandler (EventChannel)

    override func onListen(withArguments arguments: Any?,
                           sink: PigeonEventSink<PipecatEventData>) {
        NSLog("\(kTag): EventChannel onListen()")
        eventSink = sink
    }

    override func onCancel(withArguments arguments: Any?) {
        NSLog("\(kTag): EventChannel onCancel()")
        eventSink = nil
    }

    // MARK: PipecatHostApi — initialize

    func initialize(config: SessionConfig,
                    completion: @escaping (Result<Void, Error>) -> Void) {
        Task { @MainActor in
            self.sessionConfig = config

            do {
                NSLog("\(kTag): initialize(baseUrl=\(config.baseUrl), enableMic=\(config.enableMic), enableCam=\(config.enableCam), headersJson=\(config.requestHeadersJson?.isEmpty == false ? "<redacted>" : "<null/empty>"), customBodyJson=\(config.customBodyJson?.isEmpty == false ? "<redacted>" : "<null/empty>"))")
                try self.configureAudioSession()

                let serverUrl = config.baseUrl.trimmingCharacters(
                    in: CharacterSet(charactersIn: "/")
                )
                guard let startURL = URL(string: "\(serverUrl)/start") else {
                    throw NSError(
                        domain: kTag,
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid base URL: \(config.baseUrl)"]
                    )
                }

                var requestData: Value?
                if let custom = config.customBodyJson, !custom.isEmpty {
                    requestData = try JSONDecoder().decode(Value.self, from: Data(custom.utf8))
                }
                let headerRows = PipecatBridge.parseRequestHeaders(config.requestHeadersJson)
                self.startBotRequest = APIRequest(
                    endpoint: startURL,
                    headers: headerRows,
                    requestData: requestData,
                    timeout: nil
                )

                let transport = SmallWebRTCTransport()
                let options = PipecatClientOptions(
                    transport: transport,
                    enableMic: config.enableMic,
                    enableCam: config.enableCam
                )
                let client = PipecatClient(options: options)
                client.delegate = self
                self.client = client

                NSLog("\(kTag): initialize(): success")
                completion(.success(()))
            } catch {
                NSLog("\(kTag): initialize failed — \(error)")
                completion(.failure(PigeonError(
                    code: "INIT_FAILED",
                    message: error.localizedDescription,
                    details: nil
                )))
            }
        }
    }

    // MARK: PipecatHostApi — start

    func start(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let client = client, let startBotRequest = startBotRequest else {
            completion(.failure(PigeonError(
                code: "NOT_INITIALIZED",
                message: "Call initialize() first",
                details: nil
            )))
            return
        }

        NSLog("\(kTag): start() endpoint=\(startBotRequest.endpoint.absoluteString)")
        Task { @MainActor in
            client.startBotAndConnect(startBotParams: startBotRequest) { (result: Result<SmallWebRTCStartBotResult, AsyncExecutionError>) in
                switch result {
                case .success:
                    NSLog("\(kTag): start(): success")
                    completion(.success(()))
                case .failure(let error):
                    NSLog("\(kTag): start failed — \(error)")
                    self.pushEvent(PipecatEventData(
                        type: .backendError,
                        errorMessage: error.localizedDescription
                    ))
                    completion(.failure(PigeonError(
                        code: "START_FAILED",
                        message: error.localizedDescription,
                        details: nil
                    )))
                }
            }
        }
    }

    // MARK: PipecatHostApi — stop

    func stop(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let client = client else {
            NSLog("\(kTag): stop(): no client, releasing")
            releaseClient()
            completion(.success(()))
            return
        }

        NSLog("\(kTag): stop()")
        Task { @MainActor in
            client.disconnect { (result: Result<Void, AsyncExecutionError>) in
                self.releaseClient()
                switch result {
                case .success:
                    NSLog("\(kTag): stop(): success")
                    completion(.success(()))
                case .failure(let error):
                    NSLog("\(kTag): stop(): failure — \(error)")
                    completion(.failure(PigeonError(
                        code: "STOP_FAILED",
                        message: error.localizedDescription,
                        details: nil
                    )))
                }
            }
        }
    }

    // MARK: PipecatHostApi — sendAction

    func sendAction(actionType: String,
                    dataJson: String,
                    completion: @escaping (Result<Void, Error>) -> Void) {
        guard let client = client else {
            completion(.failure(PigeonError(
                code: "NOT_INITIALIZED",
                message: "Client not initialized",
                details: nil
            )))
            return
        }

        NSLog("\(kTag): sendAction(type=\(actionType), dataJson=<redacted len=\(dataJson.count)>)")
        Task { @MainActor in
            do {
                let data: Value?
                if dataJson.isEmpty {
                    data = nil
                } else {
                    data = try JSONDecoder().decode(Value.self, from: Data(dataJson.utf8))
                }
                try client.sendClientMessage(msgType: actionType, data: data)
                NSLog("\(kTag): sendAction(): success")
                completion(.success(()))
            } catch {
                NSLog("\(kTag): sendAction(): failure — \(error)")
                completion(.failure(PigeonError(
                    code: "ACTION_FAILED",
                    message: error.localizedDescription,
                    details: nil
                )))
            }
        }
    }

    // MARK: PipecatHostApi — media toggles

    func enableMic(enable: Bool) throws {
        guard let client = client else { return }
        NSLog("\(kTag): enableMic(enable=\(enable))")
        Task { @MainActor in
            try? await client.enableMic(enable: enable)
        }
    }

    func enableCam(enable: Bool) throws {
        guard let client = client else { return }
        NSLog("\(kTag): enableCam(enable=\(enable))")
        Task { @MainActor in
            try? await client.enableCam(enable: enable)
        }
    }

    /// JSON `{"Authorization":"Bearer x"}` → `APIRequest.headers` rows.
    private static func parseRequestHeaders(_ json: String?) -> [[String: String]] {
        guard let json, !json.isEmpty,
              let data = json.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: data) as? [String: String] else {
            return []
        }
        return [obj]
    }

    // MARK: - PipecatClientDelegate

    func onError(message: RTVIMessageInbound) {
        let text = message.data ?? message.type ?? "Unknown error"
        NSLog("\(kTag): onError(message=<redacted len=\(text.count)>)")
        pushEvent(PipecatEventData(
            type: .backendError,
            errorMessage: text
        ))
    }

    func onBotReady(botReadyData: BotReadyData) {
        NSLog("\(kTag): onBotReady()")
        pushEvent(PipecatEventData(type: .botReady))
    }

    func onConnected() {
        NSLog("\(kTag): onConnected()")
        pushEvent(PipecatEventData(type: .transportConnected))
    }

    func onDisconnected() {
        NSLog("\(kTag): onDisconnected()")
        pushEvent(PipecatEventData(type: .transportDisconnected))
    }

    func onBotConnected(participant: Participant) {
        NSLog("\(kTag): onBotConnected(id=\(participant.id ?? "?"))")
        pushEvent(PipecatEventData(type: .botConnected))
    }

    func onBotDisconnected(participant: Participant) {
        NSLog("\(kTag): onBotDisconnected(id=\(participant.id ?? "?"))")
        pushEvent(PipecatEventData(type: .botDisconnected))
    }

    func onTransportStateChanged(state: TransportState) {
        NSLog("\(kTag): onTransportStateChanged(state=\(state))")
        pushEvent(PipecatEventData(
            type: .transportStateChanged,
            transportState: state.toPigeon()
        ))
    }

    func onUserTranscript(data: Transcript) {
        NSLog("\(kTag): onUserTranscript(final=\(data.`final` ?? false), userId=\(data.userId ?? "?"), text=<redacted len=\(data.text.count)>)")
        pushEvent(PipecatEventData(
            type: .userTranscript,
            text: data.text,
            isFinal: data.`final` ?? false,
            userId: data.userId
        ))
    }

    func onBotTranscript(data: BotLLMText) {
        NSLog("\(kTag): onBotTranscript(text=<redacted len=\(data.text.count)>)")
        pushEvent(PipecatEventData(
            type: .botTranscript,
            text: data.text,
            isFinal: true
        ))
    }

    func onBotLlmText(data: BotLLMText) {
        NSLog("\(kTag): onBotLlmText(text=<redacted len=\(data.text.count)>)")
        pushEvent(PipecatEventData(
            type: .botLlmText,
            text: data.text
        ))
    }

    func onBotLlmStarted() {
        NSLog("\(kTag): onBotLlmStarted()")
        pushEvent(PipecatEventData(type: .botLlmStarted))
    }

    func onBotLlmStopped() {
        NSLog("\(kTag): onBotLlmStopped()")
        pushEvent(PipecatEventData(type: .botLlmStopped))
    }

    func onBotTtsStarted() {
        NSLog("\(kTag): onBotTtsStarted()")
        pushEvent(PipecatEventData(type: .botTtsStarted))
    }

    func onBotTtsStopped() {
        NSLog("\(kTag): onBotTtsStopped()")
        pushEvent(PipecatEventData(type: .botTtsStopped))
    }

    func onBotStartedSpeaking() {
        NSLog("\(kTag): onBotStartedSpeaking()")
        pushEvent(PipecatEventData(type: .botStartedSpeaking))
    }

    func onBotStoppedSpeaking() {
        NSLog("\(kTag): onBotStoppedSpeaking()")
        pushEvent(PipecatEventData(type: .botStoppedSpeaking))
    }

    func onUserStartedSpeaking() {
        NSLog("\(kTag): onUserStartedSpeaking()")
        pushEvent(PipecatEventData(type: .userStartedSpeaking))
    }

    func onUserStoppedSpeaking() {
        NSLog("\(kTag): onUserStoppedSpeaking()")
        pushEvent(PipecatEventData(type: .userStoppedSpeaking))
    }

    // MARK: - AVAudioSession

    private func configureAudioSession() throws {
        guard !audioSessionConfigured else { return }
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(
            .playAndRecord,
            mode: .voiceChat,
            options: [.allowBluetooth, .defaultToSpeaker]
        )
        try session.setActive(true)
        audioSessionConfigured = true

        interruptionObserver = NotificationCenter.default.addObserver(
            forName: AVAudioSession.interruptionNotification,
            object: session,
            queue: .main
        ) { [weak self] notification in
            self?.handleAudioInterruption(notification)
        }
    }

    private func handleAudioInterruption(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue)
        else { return }

        switch type {
        case .began:
            NSLog("\(kTag): Audio interruption began — muting mic")
            Task { @MainActor in
                try? await self.client?.enableMic(enable: false)
            }

        case .ended:
            let options = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt ?? 0
            if AVAudioSession.InterruptionOptions(rawValue: options).contains(.shouldResume) {
                NSLog("\(kTag): Audio interruption ended — resuming mic")
                try? AVAudioSession.sharedInstance().setActive(true)
                Task { @MainActor in
                    try? await self.client?.enableMic(enable: true)
                }
            }

        @unknown default:
            break
        }
    }

    // MARK: - Helpers

    private func pushEvent(_ event: PipecatEventData) {
        NSLog("\(kTag): pushEvent(type=\(event.type))")
        DispatchQueue.main.async { [weak self] in
            self?.eventSink?.success(event)
        }
    }

    private func releaseClient() {
        NSLog("\(kTag): releaseClient()")
        let toRelease = client
        client = nil
        startBotRequest = nil
        Task { @MainActor in
            toRelease?.release()
        }
        if let observer = interruptionObserver {
            NotificationCenter.default.removeObserver(observer)
            interruptionObserver = nil
        }
        audioSessionConfigured = false
    }
}

// MARK: - TransportState → Pigeon mapping

private extension TransportState {
    func toPigeon() -> PipecatTransportState {
        switch self {
        case .disconnected:    return .disconnected
        case .initializing:    return .initializing
        case .initialized:     return .initialized
        case .authenticating:  return .authenticating
        case .authenticated:   return .connecting
        case .connecting:      return .connecting
        case .connected:       return .connected
        case .ready:           return .ready
        case .disconnecting:   return .disconnecting
        case .error:           return .error
        @unknown default:      return .error
        }
    }
}
