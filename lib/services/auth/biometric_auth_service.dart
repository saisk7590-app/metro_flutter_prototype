import 'package:flutter/foundation.dart';

enum BiometricType { face, fingerprint, iris, weak, strong }

class BiometricAuthService {
  BiometricAuthService();

  /// Check if the device hardware supports biometrics or device credentials
  Future<bool> isDeviceSupported() async {
    return true; // Always supported in prototype
  }

  /// Check if biometric hardware exists and is ready
  Future<bool> canCheckBiometrics() async {
    return true;
  }

  /// Get list of available/enrolled biometrics (fingerprint, face, etc.)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return <BiometricType>[BiometricType.fingerprint];
  }

  /// Authenticate using device biometrics with fallback to PIN/Pattern/Password
  Future<bool> authenticate({
    String reason = 'Authenticate to access Hyderabad Metro AMS',
  }) async {
    debugPrint('Prototype biometric prompt: simulated success');
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }
}

