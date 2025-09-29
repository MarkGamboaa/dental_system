import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/bottom_navigation_bar.dart';

class TreatmentListScreen extends StatefulWidget {
  const TreatmentListScreen({super.key});

  @override
  State<TreatmentListScreen> createState() => _TreatmentListScreenState();
}

class _TreatmentListScreenState extends State<TreatmentListScreen> {
  int _selectedIndex = 3; // Treatments tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treatment Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showNewTreatmentDialog();
            },
          ),
        ],
      ),
      body: _buildTreatmentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewTreatmentDialog,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: AppColors.white),
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
              // Already on treatments screen
              break;
            case 4:
              context.go(AppConstants.settingsRoute);
              break;
          }
        },
      ),
    );
  }

  Widget _buildTreatmentsList() {
    final treatments = _getDemoTreatments();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: treatments.length,
      itemBuilder: (context, index) {
        final treatment = treatments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildTreatmentCard(treatment),
        );
      },
    );
  }

  Widget _buildTreatmentCard(Map<String, dynamic> treatment) {
    return Card(
      child: ExpansionTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getStatusColor(treatment['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getTreatmentIcon(treatment['type']),
            color: _getStatusColor(treatment['status']),
          ),
        ),
        title: Text(
          treatment['name'],
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient: ${treatment['patientName']}',
              style: AppTextStyles.bodySmall,
            ),
            Text(
              'Estimated Cost: ₱${treatment['cost']}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.mediumGray,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(treatment['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            treatment['status'],
            style: AppTextStyles.bodySmall.copyWith(
              color: _getStatusColor(treatment['status']),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  treatment['description'],
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Planned Date:',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            treatment['plannedDate'],
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sessions:',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${treatment['completedSessions']}/${treatment['totalSessions']}',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: treatment['completedSessions'] / treatment['totalSessions'],
                  backgroundColor: AppColors.borderLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStatusColor(treatment['status']),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _showTreatmentDetails(treatment),
                      child: const Text('View Details'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _showEditTreatment(treatment),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'in progress':
        return AppColors.warning;
      case 'planned':
        return AppColors.primaryBlue;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.mediumGray;
    }
  }

  IconData _getTreatmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cleaning':
        return Icons.cleaning_services;
      case 'filling':
        return Icons.build;
      case 'crown':
        return Icons.diamond;
      case 'root canal':
        return Icons.medical_services;
      case 'extraction':
        return Icons.content_cut;
      case 'implant':
        return Icons.precision_manufacturing;
      default:
        return Icons.medical_services;
    }
  }

  void _showNewTreatmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Treatment Plan'),
          content: const Text('Treatment planning form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Create Plan'),
            ),
          ],
        );
      },
    );
  }

  void _showTreatmentDetails(Map<String, dynamic> treatment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(treatment['name']),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Patient: ${treatment['patientName']}'),
                const SizedBox(height: 8),
                Text('Status: ${treatment['status']}'),
                const SizedBox(height: 8),
                Text('Cost: ₱${treatment['cost']}'),
                const SizedBox(height: 8),
                Text('Planned Date: ${treatment['plannedDate']}'),
                const SizedBox(height: 8),
                Text('Sessions: ${treatment['completedSessions']}/${treatment['totalSessions']}'),
                const SizedBox(height: 8),
                Text('Description: ${treatment['description']}'),
              ],
            ),
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

  void _showEditTreatment(Map<String, dynamic> treatment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${treatment['name']}'),
          content: const Text('Treatment editing form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getDemoTreatments() {
    return [
      {
        'name': 'Root Canal Treatment',
        'patientName': 'Sarah Johnson',
        'type': 'Root Canal',
        'status': 'In Progress',
        'cost': '25,000',
        'plannedDate': 'Dec 15, 2024',
        'completedSessions': 2,
        'totalSessions': 3,
        'description': 'Root canal therapy for tooth #14 with crown placement.',
      },
      {
        'name': 'Dental Crown',
        'patientName': 'Michael Chen',
        'type': 'Crown',
        'status': 'Planned',
        'cost': '15,000',
        'plannedDate': 'Dec 20, 2024',
        'completedSessions': 0,
        'totalSessions': 2,
        'description': 'Porcelain crown for damaged molar tooth #19.',
      },
      {
        'name': 'Tooth Extraction',
        'patientName': 'Emily Davis',
        'type': 'Extraction',
        'status': 'Completed',
        'cost': '3,500',
        'plannedDate': 'Dec 1, 2024',
        'completedSessions': 1,
        'totalSessions': 1,
        'description': 'Simple extraction of wisdom tooth #32.',
      },
      {
        'name': 'Dental Implant',
        'patientName': 'David Wilson',
        'type': 'Implant',
        'status': 'Planned',
        'cost': '80,000',
        'plannedDate': 'Jan 10, 2025',
        'completedSessions': 0,
        'totalSessions': 4,
        'description': 'Single implant placement with crown for missing tooth #11.',
      },
    ];
  }
}