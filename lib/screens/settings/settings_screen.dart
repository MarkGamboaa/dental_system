import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/bottom_navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4; // Settings tab
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _backupEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildClinicSection(),
            const SizedBox(height: 24),
            _buildPreferencesSection(),
            const SizedBox(height: 24),
            _buildDataSection(),
            const SizedBox(height: 24),
            _buildSupportSection(),
            const SizedBox(height: 24),
            _buildLogoutSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          
          switch (index) {
            case 0:
              context.go(AppConstants.dashboardRoute);
              break;
            case 1:
              context.go(AppConstants.patientsRoute);
              break;
            case 2:
              context.go(AppConstants.appointmentsRoute);
              break;
            case 3:
              context.go(AppConstants.treatmentsRoute);
              break;
            case 4:
              // Already on settings screen
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryBlue,
                  child: Text(
                    'DS',
                    style: AppTextStyles.h4.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. John Smith',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'General Dentist',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.mediumGray,
                        ),
                      ),
                      Text(
                        'john.smith@toothwise.com',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditProfileDialog();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clinic Information',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),
            _buildSettingsItem(
              'Clinic Name',
              'SmileCare Dental Clinic Manila',
              Icons.business,
              () => _showEditClinicDialog(),
            ),
            _buildSettingsItem(
              'Address',
              '123 Ayala Avenue, Makati City, Metro Manila 1226',
              Icons.location_on,
              () => _showEditClinicDialog(),
            ),
            _buildSettingsItem(
              'Phone Number',
              '+63 2 8123 4567',
              Icons.phone,
              () => _showEditClinicDialog(),
            ),
            _buildSettingsItem(
              'Business Hours',
              'Mon-Fri: 9:00 AM - 6:00 PM, Sat: 9:00 AM - 2:00 PM',
              Icons.access_time,
              () => _showBusinessHoursDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),
            _buildSwitchItem(
              'Notifications',
              'Receive appointment reminders and updates',
              Icons.notifications,
              _notificationsEnabled,
              (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildSwitchItem(
              'Dark Mode',
              'Use dark theme for the app',
              Icons.dark_mode,
              _darkModeEnabled,
              (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                _showFeatureComingSoonDialog('Dark Mode');
              },
            ),
            _buildSwitchItem(
              'Auto Backup',
              'Automatically backup data daily',
              Icons.backup,
              _backupEnabled,
              (value) {
                setState(() {
                  _backupEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Management',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),
            _buildSettingsItem(
              'Export Data',
              'Export patient and appointment data',
              Icons.download,
              () => _showFeatureComingSoonDialog('Data Export'),
            ),
            _buildSettingsItem(
              'Import Data',
              'Import data from other systems',
              Icons.upload,
              () => _showFeatureComingSoonDialog('Data Import'),
            ),
            _buildSettingsItem(
              'Backup & Restore',
              'Manage data backups and restore points',
              Icons.backup,
              () => _showBackupDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support & Help',
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 16),
            _buildSettingsItem(
              'Help Center',
              'Get help and support',
              Icons.help,
              () => _showFeatureComingSoonDialog('Help Center'),
            ),
            _buildSettingsItem(
              'Contact Support',
              'Contact our support team',
              Icons.support_agent,
              () => _showContactSupportDialog(),
            ),
            _buildSettingsItem(
              'Privacy Policy',
              'View our privacy policy',
              Icons.privacy_tip,
              () => _showFeatureComingSoonDialog('Privacy Policy'),
            ),
            _buildSettingsItem(
              'About',
              'Version ${AppConstants.appVersion}',
              Icons.info,
              () => _showAboutDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _showLogoutDialog,
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(title, style: AppTextStyles.bodyMedium),
      subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primaryBlue,
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: const Text('Profile editing form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditClinicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Clinic Information'),
          content: const Text('Clinic information editing form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showBusinessHoursDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Business Hours'),
          content: const Text('Business hours configuration would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Backup & Restore'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Last backup: Yesterday at 11:30 PM'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showFeatureComingSoonDialog('Manual Backup');
                      },
                      child: const Text('Backup Now'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showFeatureComingSoonDialog('Restore');
                      },
                      child: const Text('Restore'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showContactSupportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Support'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: support@toothwise.com'),
              SizedBox(height: 8),
              Text('Phone: +63 2 8800 1234'),
              SizedBox(height: 8),
              Text('Hours: Monday - Friday, 9:00 AM - 5:00 PM'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About ToothWise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version: ${AppConstants.appVersion}'),
              const SizedBox(height: 8),
              const Text('Professional Dental Clinic Management System'),
              const SizedBox(height: 16),
              const Text('Built with Flutter for modern dental practices.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showFeatureComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: Text('$feature feature will be available in a future update.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppConstants.loginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}