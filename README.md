# developer_mode

A Flutter plugin to detect jailbreak/root status and developer mode/emulator on Android and iOS devices.

## Features

- ✅ Detect if the device is **jailbroken** (iOS) or **rooted** (Android)
- ✅ Detect if **developer mode** is enabled (Android) or if running in an **emulator** (iOS)
- ✅ Easy-to-use API with simple async methods
- ✅ Supports both Android (API 21+) and iOS (12.0+)
- ✅ Uses [RootBeer](https://github.com/scottyab/rootbeer) for Android root detection
- ✅ Uses [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite) for iOS jailbreak detection

## Platform Support

| Platform | Supported | Minimum Version |
|----------|-----------|----------------|
| Android  | ✅        | API 21 (Android 5.0) |
| iOS      | ✅        | iOS 12.0       |

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  developer_mode: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### Android Setup

No additional setup required. The plugin uses Android API 36 and Java 17.

### iOS Setup

No additional setup required. The plugin uses IOSSecuritySuite which will be automatically installed via CocoaPods.

## Usage

Import the package:

```dart
import 'package:developer_mode/developer_mode.dart';
```

### Check if device is jailbroken or rooted

```dart
bool isJailbroken = await DeveloperMode.isJailbroken;
if (isJailbroken) {
  print('Warning: Device is jailbroken or rooted!');
  // Take appropriate action (e.g., restrict features, show warning)
} else {
  print('Device is secure');
}
```

### Check if developer mode is enabled or running in emulator

```dart
bool isDeveloperMode = await DeveloperMode.isDeveloperMode;
if (isDeveloperMode) {
  print('Developer mode is enabled or running in emulator');
  // You might want to disable certain features in production
} else {
  print('Running in normal mode on a real device');
}
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:developer_mode/developer_mode.dart';

class SecurityCheckScreen extends StatefulWidget {
  @override
  _SecurityCheckScreenState createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  bool? _isJailbroken;
  bool? _isDeveloperMode;

  @override
  void initState() {
    super.initState();
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    final isJailbroken = await DeveloperMode.isJailbroken;
    final isDeveloperMode = await DeveloperMode.isDeveloperMode;

    setState(() {
      _isJailbroken = isJailbroken;
      _isDeveloperMode = isDeveloperMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Check'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Jailbroken/Rooted: ${_isJailbroken ?? "Checking..."}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Developer Mode/Emulator: ${_isDeveloperMode ?? "Checking..."}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _checkSecurity,
              child: Text('Re-check'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Use Cases

- **Security-sensitive apps**: Banking, payment, or enterprise apps that need to restrict functionality on compromised devices
- **DRM protection**: Apps with digital rights management requirements
- **Anti-cheat**: Gaming apps that want to prevent cheating on rooted/jailbroken devices
- **Development/Testing**: Detect if running in emulator or with developer mode enabled

## API Reference

### `DeveloperMode.isJailbroken`

Returns a `Future<bool>` indicating whether the device is jailbroken (iOS) or rooted (Android).

- **Android**: Uses RootBeer library to perform comprehensive root detection
- **iOS**: Uses IOSSecuritySuite to detect jailbreak

### `DeveloperMode.isDeveloperMode`

Returns a `Future<bool>` indicating whether developer mode is enabled (Android) or if running in an emulator (iOS).

- **Android**: Checks if developer mode settings are enabled
- **iOS**: Checks if the app is running in an emulator/simulator

## Important Notes

- Root/jailbreak detection is not 100% foolproof. Determined attackers can bypass these checks.
- Use this as part of a defense-in-depth strategy, not as the sole security measure.
- Always handle the security checks gracefully to avoid false positives affecting legitimate users.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Issues

If you encounter any issues, please report them on [GitHub Issues](https://github.com/krishnapal/developer_mode/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

- [RootBeer](https://github.com/scottyab/rootbeer) - Android root detection
- [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite) - iOS security checks
