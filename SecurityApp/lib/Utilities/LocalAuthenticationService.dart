import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  final _auth = LocalAuthentication();
  bool _isProtectionEnabled = false;

  bool get isProtectionEnabled => _isProtectionEnabled;

  set isProtectionEnabled(bool enabled) => _isProtectionEnabled = enabled;

  bool isAuthenticated = false;

  Future<void> authenticate() async {
    const andStrings = const AndroidAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'Go to set',
      fingerprintNotRecognized: 'Fingerprint recognition failed',
      goToSettingsDescription: 'Please set the fingerprint.',
      fingerprintHint: 'fingerprint',
      fingerprintSuccess: 'fingerprint recognition succeeded',
      signInTitle: 'fingerprint verification',
      fingerprintRequiredTitle: 'Please enter the fingerprint first!',
    );


    bool authenticated = false;
    try {
      authenticated = await _auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          androidAuthStrings :andStrings,
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    isAuthenticated = authenticated;

  }
}