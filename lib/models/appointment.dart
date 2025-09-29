import 'patient.dart';

class Appointment {
  final String id;
  final String patientId;
  final Patient? patient; // For populated data
  final DateTime dateTime;
  final int durationMinutes;
  final String type; // Consultation, Check-up, Treatment, etc.
  final String status; // Scheduled, Confirmed, Completed, etc.
  final String reason;
  final String notes;
  final String doctorId;
  final String doctorName;
  final String roomNumber;
  final double? cost;
  final bool isEmergency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> treatments;
  final String? reminderSent;
  
  Appointment({
    required this.id,
    required this.patientId,
    this.patient,
    required this.dateTime,
    required this.durationMinutes,
    required this.type,
    required this.status,
    required this.reason,
    required this.notes,
    required this.doctorId,
    required this.doctorName,
    required this.roomNumber,
    this.cost,
    this.isEmergency = false,
    required this.createdAt,
    required this.updatedAt,
    this.treatments = const [],
    this.reminderSent,
  });
  
  DateTime get endTime => dateTime.add(Duration(minutes: durationMinutes));
  
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
           dateTime.month == now.month &&
           dateTime.day == now.day;
  }
  
  bool get isUpcoming => dateTime.isAfter(DateTime.now());
  bool get isPast => dateTime.isBefore(DateTime.now());
  bool get isCompleted => status == 'Completed';
  bool get isCancelled => status == 'Cancelled' || status == 'No Show';
  bool get canReschedule => status == 'Scheduled' || status == 'Confirmed';
  
  String get timeRange {
    final start = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    final end = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$start - $end';
  }
  
  Appointment copyWith({
    String? id,
    String? patientId,
    Patient? patient,
    DateTime? dateTime,
    int? durationMinutes,
    String? type,
    String? status,
    String? reason,
    String? notes,
    String? doctorId,
    String? doctorName,
    String? roomNumber,
    double? cost,
    bool? isEmergency,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? treatments,
    String? reminderSent,
  }) {
    return Appointment(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patient: patient ?? this.patient,
      dateTime: dateTime ?? this.dateTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      type: type ?? this.type,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      roomNumber: roomNumber ?? this.roomNumber,
      cost: cost ?? this.cost,
      isEmergency: isEmergency ?? this.isEmergency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      treatments: treatments ?? this.treatments,
      reminderSent: reminderSent ?? this.reminderSent,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patient': patient?.toJson(),
      'dateTime': dateTime.toIso8601String(),
      'durationMinutes': durationMinutes,
      'type': type,
      'status': status,
      'reason': reason,
      'notes': notes,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'roomNumber': roomNumber,
      'cost': cost,
      'isEmergency': isEmergency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'treatments': treatments,
      'reminderSent': reminderSent,
    };
  }
  
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
      dateTime: DateTime.parse(json['dateTime']),
      durationMinutes: json['durationMinutes'],
      type: json['type'],
      status: json['status'],
      reason: json['reason'],
      notes: json['notes'] ?? '',
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      roomNumber: json['roomNumber'],
      cost: json['cost']?.toDouble(),
      isEmergency: json['isEmergency'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      treatments: List<String>.from(json['treatments'] ?? []),
      reminderSent: json['reminderSent'],
    );
  }
}