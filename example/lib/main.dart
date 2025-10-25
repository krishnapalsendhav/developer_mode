import 'package:flutter/material.dart';
import 'package:developer_mode/developer_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Mode Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SecurityCheckScreen(),
    );
  }
}

class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  bool? _isJailbroken;
  bool? _isDeveloperMode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final isJailbroken = await DeveloperMode.isJailbroken;
      final isDeveloperMode = await DeveloperMode.isDeveloperMode;

      setState(() {
        _isJailbroken = isJailbroken;
        _isDeveloperMode = isDeveloperMode;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error checking security: $e')));
      }
    }
  }

  Color _getStatusColor(bool? status) {
    if (status == null) return Colors.grey;
    return status ? Colors.red : Colors.green;
  }

  IconData _getStatusIcon(bool? status) {
    if (status == null) return Icons.help_outline;
    return status ? Icons.warning : Icons.check_circle;
  }

  String _getStatusText(bool? status) {
    if (status == null) return 'Checking...';
    return status ? 'Yes' : 'No';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Check'), elevation: 2),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSecurityCard(title: 'Jailbroken/Rooted', description: 'Is this device jailbroken or rooted?', status: _isJailbroken),
                  const SizedBox(height: 24),
                  _buildSecurityCard(title: 'Developer Mode/Emulator', description: 'Is developer mode enabled or running in emulator?', status: _isDeveloperMode),
                  const SizedBox(height: 48),
                  ElevatedButton.icon(
                    onPressed: _checkSecurity,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Re-check'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildSecurityCard({required String title, required String description, required bool? status}) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getStatusIcon(status), color: _getStatusColor(status), size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(description, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getStatusColor(status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getStatusColor(status), width: 2),
              ),
              child: Text(
                _getStatusText(status),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _getStatusColor(status)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'This plugin helps detect if your device is compromised or in development mode. '
              'Use this for security-sensitive applications.',
              style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
            ),
          ],
        ),
      ),
    );
  }
}
