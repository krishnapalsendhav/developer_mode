## 0.0.2

* **Added 16KB page size compatibility support**
  - Configured NDK architecture filters for optimal compatibility
  - Updated Gradle properties for proper resource handling
  - Ensured native libraries work correctly on 16KB page size devices
* **Upgraded dependencies**
  - Updated RootBeer library to 0.1.1 for better compatibility
  - Updated Java compatibility to version 21
  - Updated Gradle to 8.7 for improved build performance
* **Improved build configuration**
  - Enhanced buildFeatures configuration
  - Better optimization for all ARM architectures
  - Improved support for x86 and x86_64 emulators
* **Better example app**
  - Enabled Android example app support
  - Enabled iOS example app support
  - Fixed deprecated API warnings

## 0.0.1

* Initial release
* Added jailbreak/root detection for iOS and Android
* Added developer mode detection for Android
* Added emulator detection for iOS
* Android support with API level 36 and Java 17
* iOS support with iOS 12.0+
* Uses RootBeer library for Android root detection
* Uses IOSSecuritySuite for iOS jailbreak detection
