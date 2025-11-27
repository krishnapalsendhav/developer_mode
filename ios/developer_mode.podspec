Pod::Spec.new do |s|
  s.name             = 'developer_mode'
  s.version          = '0.0.2'
  s.summary          = 'A Flutter plugin for developer mode and jailbreak detection.'
  s.description      = <<-DESC
A Flutter plugin for developer mode and jailbreak detection.
                       DESC
  s.homepage         = 'https://github.com/krishnapalsendhav/developer_mode'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Krishnapal Sendhav' => 'krishnapalsendhav591@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'IOSSecuritySuite', '~> 1.9.0'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
