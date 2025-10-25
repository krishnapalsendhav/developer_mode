library;

import 'dart:async';
import 'package:flutter/services.dart';

/// A Flutter plugin to detect jailbreak/root status and developer mode/emulator.
///
/// This plugin provides methods to check if a device is jailbroken/rooted
/// and if developer mode is enabled or if the app is running in an emulator.
class DeveloperMode {
  static const MethodChannel _channel = MethodChannel('flutter_jailbreak_detection');

  /// Checks if the device is jailbroken (iOS) or rooted (Android).
  ///
  /// Returns `true` if the device is jailbroken/rooted, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// bool isJailbroken = await DeveloperMode.isJailbroken;
  /// if (isJailbroken) {
  ///   print('Device is jailbroken or rooted');
  /// }
  /// ```
  static Future<bool> get isJailbroken async {
    try {
      final bool result = await _channel.invokeMethod('jailbroken');
      return result;
    } on PlatformException {
      return false;
    }
  }

  /// Checks if developer mode is enabled (Android) or if running in emulator (iOS).
  ///
  /// Returns `true` if developer mode is enabled or running in emulator, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// bool isDeveloperMode = await DeveloperMode.isDeveloperMode;
  /// if (isDeveloperMode) {
  ///   print('Developer mode is enabled or running in emulator');
  /// }
  /// ```
  static Future<bool> get isDeveloperMode async {
    try {
      final bool result = await _channel.invokeMethod('developerMode');
      return result;
    } on PlatformException {
      return false;
    }
  }
}
