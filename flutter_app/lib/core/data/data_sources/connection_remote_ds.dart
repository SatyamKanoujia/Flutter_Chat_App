import 'package:askless/index.dart';

class ConnectionRemoteDS {
  final String serverUrl = "ws://10.203.170.163:3000"; 

  void start({required OnAutoReauthenticationFails onAutoReauthenticationFails}) {
    AsklessClient.instance.start(
      serverUrl: serverUrl,
      debugLogs: false,
      getWebRTCParams: (userId) => Future.value(
          WebRTCParams(configuration: {
            'iceServers': [
              {
                "urls":   [
                  'stun:stun1.l.google.com:19302',
                  'stun:stun2.l.google.com:19302'
                ],
              }
            ]
          })
      ),
      onAutoReauthenticationFails: (String credentialErrorCode, void Function() clearAuthentication) {
        print("Credential failed with credentialErrorCode = $credentialErrorCode");
        onAutoReauthenticationFails(credentialErrorCode, clearAuthentication);
      },
    );
  }


  Stream<ConnectionDetails> streamConnectionChanges({bool immediately = false}) {
    // Converting Askless Connection status (Connection enum) to this App connection status (ConnectionStatus enum)
    // This separation is good so the upper layers (repository, use cases, widgets) don't rely on the
    // data source implementation

    return AsklessClient.instance.streamConnectionChanges(immediately: immediately);
  }
}
