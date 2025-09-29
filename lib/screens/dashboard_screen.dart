import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/dashboard_stats_card.dart';
import '../widgets/appointment_card.dart';
import '../widgets/patient_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.dashboard, color: AppColors.white),
            const SizedBox(width: 8),
            const Text('Dashboard'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              context.go(AppConstants.settingsRoute);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 20),
            _buildStatsCards(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildTodayAppointments(),
            const SizedBox(height: 24),
            _buildRecentPatients(),
            const SizedBox(height: 24),
            _buildWeeklyChart(),
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
              // Already on dashboard
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
              context.go(AppConstants.settingsRoute);
              break;
          }
        },
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting = 'Good morning';
    
    if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon';
    } else if (hour >= 17) {
      greeting = 'Good evening';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting, Dr. Smith',
            style: AppTextStyles.h3.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'You have 12 appointments today',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.white.withOpacity(0.9),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${now.day}/${now.month}/${now.year}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: DashboardStatsCard(
            title: 'Today\'s Appointments',
            value: '12',
            icon: Icons.calendar_today,
            color: AppColors.primaryBlue,
            trend: '+15%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DashboardStatsCard(
            title: 'Total Patients',
            value: '1,247',
            icon: Icons.people,
            color: AppColors.accentGreen,
            trend: '+8%',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'New Appointment',
                Icons.add_circle_outline,
                AppColors.primaryBlue,
                () => context.go(AppConstants.appointmentsRoute),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Add Patient',
                Icons.person_add_outlined,
                AppColors.accentGreen,
                () => context.go(AppConstants.patientsRoute),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Treatment Plans',
                Icons.medical_services_outlined,
                AppColors.accentTeal,
                () => context.go(AppConstants.treatmentsRoute),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Appointments',
              style: AppTextStyles.h4,
            ),
            TextButton(
              onPressed: () => context.go(AppConstants.appointmentsRoute),
              child: Text(
                'View All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index < 4 ? 12 : 0),
                child: SizedBox(
                  width: 280,
                  child: AppointmentCard(
                    patientName: _getDemoPatientNames()[index],
                    time: '${9 + index}:00 AM',
                    type: _getDemoAppointmentTypes()[index],
                    status: index < 2 ? 'Completed' : 'Scheduled',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentPatients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Patients',
              style: AppTextStyles.h4,
            ),
            TextButton(
              onPressed: () => context.go(AppConstants.patientsRoute),
              child: Text(
                'View All',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(3, (index) {
          final patients = _getDemoPatientNames();
          return Padding(
            padding: EdgeInsets.only(bottom: index < 2 ? 8 : 0),
            child: PatientCard(
              name: patients[index],
              age: 25 + (index * 5),
              lastVisit: '${index + 1} day${index > 0 ? 's' : ''} ago',
              priority: index == 0 ? 'High' : 'Medium',
            ),
          );
        }),
      ],
    );
  }

  Widget _buildWeeklyChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Overview',
          style: AppTextStyles.h4,
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      if (value.toInt() >= 0 && value.toInt() < days.length) {
                        return Text(
                          days[value.toInt()],
                          style: AppTextStyles.bodySmall,
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 8),
                    const FlSpot(1, 12),
                    const FlSpot(2, 10),
                    const FlSpot(3, 15),
                    const FlSpot(4, 13),
                    const FlSpot(5, 9),
                    const FlSpot(6, 7),
                  ],
                  isCurved: true,
                  color: AppColors.primaryBlue,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.primaryBlue.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<String> _getDemoPatientNames() {
    return [
      'Maria Santos',
      'Juan dela Cruz',
      'Ana Reyes',
      'Jose Garcia',
      'Carmen Lopez',
    ];
  }

  List<String> _getDemoAppointmentTypes() {
    return [
      'Cleaning',
      'Check-up',
      'Root Canal',
      'Consultation',
      'Filling',
    ];
  }
}