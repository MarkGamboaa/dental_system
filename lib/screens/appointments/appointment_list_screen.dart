import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/bottom_navigation_bar.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  int _selectedIndex = 2; // Appointments tab
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showNewAppointmentDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: _buildAppointmentsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewAppointmentDialog,
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
              // Already on appointments screen
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

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: TableCalendar<Map<String, dynamic>>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
        ),
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final appointments = _getAppointmentsForSelectedDay();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildAppointmentCard(appointment),
        );
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getStatusColor(appointment['status']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getAppointmentIcon(appointment['type']),
            color: _getStatusColor(appointment['status']),
          ),
        ),
        title: Text(
          appointment['patientName'],
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${appointment['time']} • ${appointment['type']}',
              style: AppTextStyles.bodySmall,
            ),
            Text(
              'Room ${appointment['room']}',
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
                color: _getStatusColor(appointment['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                appointment['status'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: _getStatusColor(appointment['status']),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _showAppointmentDetails(appointment);
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    // Return events for the given day
    return _getDemoAppointments()
        .where((appointment) => isSameDay(appointment['date'], day))
        .toList();
  }

  List<Map<String, dynamic>> _getAppointmentsForSelectedDay() {
    if (_selectedDay == null) {
      return _getDemoAppointments()
          .where((appointment) => isSameDay(appointment['date'], DateTime.now()))
          .toList();
    }
    return _getEventsForDay(_selectedDay!);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'scheduled':
      case 'confirmed':
        return AppColors.primaryBlue;
      case 'cancelled':
      case 'no show':
        return AppColors.error;
      case 'in progress':
        return AppColors.warning;
      default:
        return AppColors.mediumGray;
    }
  }

  IconData _getAppointmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cleaning':
        return Icons.cleaning_services;
      case 'check-up':
        return Icons.health_and_safety;
      case 'root canal':
        return Icons.medical_services;
      case 'consultation':
        return Icons.chat;
      case 'filling':
        return Icons.build;
      default:
        return Icons.calendar_today;
    }
  }

  void _showNewAppointmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Appointment'),
          content: const Text('Appointment scheduling form would open here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Schedule'),
            ),
          ],
        );
      },
    );
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appointment['patientName']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time: ${appointment['time']}'),
              Text('Type: ${appointment['type']}'),
              Text('Room: ${appointment['room']}'),
              Text('Status: ${appointment['status']}'),
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

  List<Map<String, dynamic>> _getDemoAppointments() {
    final today = DateTime.now();
    return [
      {
        'patientName': 'Maria Santos',
        'time': '9:00 AM',
        'type': 'Cleaning',
        'room': '101',
        'status': 'Scheduled',
        'date': today,
      },
      {
        'patientName': 'Juan dela Cruz',
        'time': '10:30 AM',
        'type': 'Check-up',
        'room': '102',
        'status': 'Confirmed',
        'date': today,
      },
      {
        'patientName': 'Ana Reyes',
        'time': '2:00 PM',
        'type': 'Root Canal',
        'room': '103',
        'status': 'In Progress',
        'date': today,
      },
      {
        'patientName': 'Jose Garcia',
        'time': '3:30 PM',
        'type': 'Consultation',
        'room': '101',
        'status': 'Scheduled',
        'date': today,
      },
      {
        'patientName': 'Carmen Lopez',
        'time': '4:45 PM',
        'type': 'Filling',
        'room': '102',
        'status': 'Completed',
        'date': today.subtract(const Duration(days: 1)),
      },
    ];
  }
}