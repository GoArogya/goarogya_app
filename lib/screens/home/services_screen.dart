import 'package:flutter/material.dart';
import 'package:goarogya_app/utils/app_theme.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Services',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Healthcare Services',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _buildServiceCategory(
                context,
                title: 'Medical Consultations',
                icon: Icons.medical_services,
                color: AppTheme.primaryColor,
                services: [
                  'Find Doctor',
                  'Book Appointment',
                  'Video Consultation',
                  'Home Visit',
                ],
              ),
              const SizedBox(height: 16),
              _buildServiceCategory(
                context,
                title: 'Emergency Services',
                icon: Icons.emergency,
                color: Colors.red,
                services: [
                  'Ambulance',
                  'Emergency Helpline',
                  'First Aid Guide',
                  'SOS Alert',
                ],
              ),
              const SizedBox(height: 16),
              _buildServiceCategory(
                context,
                title: 'Maternal Health',
                icon: Icons.pregnant_woman,
                color: AppTheme.secondaryColor,
                services: [
                  'Pregnancy Tracker',
                  'Antenatal Care',
                  'Postnatal Care',
                  'Nutrition Guide',
                ],
              ),
              const SizedBox(height: 16),
              _buildServiceCategory(
                context,
                title: 'Medicines & Supplies',
                icon: Icons.medication,
                color: Colors.green,
                services: [
                  'Medicine Shop',
                  'Order Medicines',
                  'Medicine Reminders',
                  'Generic Alternatives',
                ],
              ),
              const SizedBox(height: 16),
              _buildServiceCategory(
                context,
                title: 'Health Records',
                icon: Icons.folder_shared,
                color: Colors.orange,
                services: [
                  'Medical History',
                  'Test Reports',
                  'Prescriptions',
                  'Share Records',
                ],
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCategory(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<String> services,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: color,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          services[index],
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}