import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BioMatricAuth extends StatefulWidget {
  @override
  _BioMatricAuthState createState() => _BioMatricAuthState();
}

class _BioMatricAuthState extends State<BioMatricAuth> {

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
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
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          androidAuthStrings :andStrings,
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Can check biometrics: $_canCheckBiometrics\n'),
                    RaisedButton(
                      child: const Text('Check biometrics'),
                      onPressed: _checkBiometrics,
                    ),
                    Text('Available biometrics: $_availableBiometrics\n'),
                    RaisedButton(
                      child: const Text('Get available biometrics'),
                      onPressed: _getAvailableBiometrics,
                    ),
                    Text('Current State: $_authorized\n'),
                    RaisedButton(
                      child: const Text('Authenticate'),
                      onPressed: _authenticate,
                    )
                  ])),
        ));
  }
}
