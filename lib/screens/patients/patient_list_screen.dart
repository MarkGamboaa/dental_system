import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/bottom_navigation_bar.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1; // Patients tab

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              _showAddPatientDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: _buildPatientList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPatientDialog,
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
              // Already on patients screen
              break;
            case 2:
              context.go(AppConstants.appointmentsRoute);
              break;
            case 3:
              context.go(AppConstants.treatmentsRoute);
              break;
            case 4:
              context.go(AppConstants.settingsRoute);
              break;
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search patients...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', true),
          _buildFilterChip('High Priority', false),
          _buildFilterChip('Recent', false),
          _buildFilterChip('Overdue', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // Handle filter selection
        },
        backgroundColor: AppColors.lightGray,
        selectedColor: AppColors.primaryBlue.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primaryBlue : AppColors.darkGray,
        ),
      ),
    );
  }

  Widget _buildPatientList() {
    final patients = _getDemoPatients();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildPatientCard(patient),
        );
      },
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
          child: Text(
            patient['initials'],
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        title: Text(
          patient['name'],
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Age: ${patient['age']} • ${patient['phone']}',
              style: AppTextStyles.bodySmall,
            ),
            Text(
              'Last visit: ${patient['lastVisit']}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.mediumGray,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getPriorityColor(patient['priority']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                patient['priority'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: _getPriorityColor(patient['priority']),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          _showPatientDetails(patient);
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
      case 'urgent':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.mediumGray;
    }
  }

  void _showAddPatientDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Patient'),
          content: const Text('Patient registration form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Add Patient'),
            ),
          ],
        );
      },
    );
  }

  void _showPatientDetails(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(patient['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Age: ${patient['age']}'),
              Text('Phone: ${patient['phone']}'),
              Text('Last Visit: ${patient['lastVisit']}'),
              Text('Priority: ${patient['priority']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getDemoPatients() {
    return [
      {
        'name': 'Maria Santos',
        'initials': 'MS',
        'age': 28,
        'phone': '+63 917 123 4567',
        'lastVisit': '2 days ago',
        'priority': 'High',
      },
      {
        'name': 'Juan dela Cruz',
        'initials': 'JC',
        'age': 35,
        'phone': '+63 918 234 5678',
        'lastVisit': '1 week ago',
        'priority': 'Medium',
      },
      {
        'name': 'Ana Reyes',
        'initials': 'AR',
        'age': 42,
        'phone': '+63 919 345 6789',
        'lastVisit': '3 days ago',
        'priority': 'Low',
      },
      {
        'name': 'Jose Garcia',
        'initials': 'JG',
        'age': 31,
        'phone': '+63 920 456 7890',
        'lastVisit': '1 day ago',
        'priority': 'Urgent',
      },
      {
        'name': 'Carmen Lopez',
        'initials': 'CL',
        'age': 26,
        'phone': '+63 921 567 8901',
        'lastVisit': '5 days ago',
        'priority': 'Medium',
      },
    ];
  }
}