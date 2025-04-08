import 'package:flutter/material.dart';
import 'package:goarogya_app/screens/auth/login_screen.dart';
import 'package:goarogya_app/utils/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 24),
              _buildProfileSection(
                context,
                title: 'Personal Information',
                items: [
                  ProfileItem(
                    icon: Icons.phone,
                    title: 'Phone Number',
                    subtitle: '+91 9876543210',
                  ),
                  ProfileItem(
                    icon: Icons.calendar_today,
                    title: 'Date of Birth',
                    subtitle: '15 May 1990',
                  ),
                  ProfileItem(
                    icon: Icons.bloodtype,
                    title: 'Blood Group',
                    subtitle: 'B+',
                  ),
                  ProfileItem(
                    icon: Icons.height,
                    title: 'Height & Weight',
                    subtitle: '165 cm, 58 kg',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildProfileSection(
                context,
                title: 'Health Information',
                items: [
                  ProfileItem(
                    icon: Icons.medical_services,
                    title: 'Medical Conditions',
                    subtitle: 'None',
                  ),
                  ProfileItem(
                    icon: Icons.medication,
                    title: 'Current Medications',
                    subtitle: 'None',
                  ),
                  ProfileItem(
                    icon: Icons.dangerous,
                    title: 'Allergies',
                    subtitle: 'None',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildProfileSection(
                context,
                title: 'App Settings',
                items: [
                  ProfileItem(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    hasAction: true,
                  ),
                  ProfileItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Enabled',
                    hasAction: true,
                  ),
                  ProfileItem(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Settings',
                    subtitle: 'Manage your data',
                    hasAction: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        const SizedBox(height: 16),
        Text(
          'Priya Sharma',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'priya.sharma@example.com',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem(context, '12', 'Appointments'),
            Container(
              height: 40,
              width: 1,
              color: Colors.grey.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            _buildStatItem(context, '4', 'Doctors'),
            Container(
              height: 40,
              width: 1,
              color: Colors.grey.withOpacity(0.3),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            _buildStatItem(context, '8', 'Reports'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
    BuildContext context, {
    required String title,
    required List<ProfileItem> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => _buildProfileItem(context, item)).toList(),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, ProfileItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (item.hasAction)
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textSecondaryColor,
              size: 16,
            ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // Logout logic
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class ProfileItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasAction;

  ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasAction = false,
  });
}