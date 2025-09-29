import 'patient.dart';

class Treatment {
  final String id;
  final String patientId;
  final Patient? patient; // For populated data
  final String name;
  final String description;
  final List<int> toothNumbers; // Affected teeth
  final String category; // Restorative, Preventive, Surgical, etc.
  final String status; // Planned, In Progress, Completed, Cancelled
  final double cost;
  final String doctorId;
  final String doctorName;
  final DateTime plannedDate;
  final DateTime? completedDate;
  final int sessionsRequired;
  final int sessionsCompleted;
  final String notes;
  final List<String> beforeImages;
  final List<String> afterImages;
  final String priority; // Low, Medium, High, Urgent
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? appointmentId; // Associated appointment
  
  Treatment({
    required this.id,
    required this.patientId,
    this.patient,
    required this.name,
    required this.description,
    required this.toothNumbers,
    required this.category,
    required this.status,
    required this.cost,
    required this.doctorId,
    required this.doctorName,
    required this.plannedDate,
    this.completedDate,
    required this.sessionsRequired,
    this.sessionsCompleted = 0,
    required this.notes,
    this.beforeImages = const [],
    this.afterImages = const [],
    this.priority = 'Medium',
    required this.createdAt,
    required this.updatedAt,
    this.appointmentId,
  });
  
  bool get isCompleted => status == 'Completed';
  bool get isInProgress => status == 'In Progress';
  bool get isPlanned => status == 'Planned';
  bool get isCancelled => status == 'Cancelled';
  
  double get progress {
    if (sessionsRequired == 0) return 0.0;
    return sessionsCompleted / sessionsRequired;
  }
  
  String get progressText => '$sessionsCompleted/$sessionsRequired sessions';
  
  bool get isOverdue {
    return plannedDate.isBefore(DateTime.now()) && !isCompleted;
  }
  
  bool get isHighPriority => priority == 'High' || priority == 'Urgent';
  
  String get toothNumbersText {
    if (toothNumbers.isEmpty) return 'General';
    if (toothNumbers.length == 1) return 'Tooth ${toothNumbers.first}';
    return 'Teeth ${toothNumbers.join(', ')}';
  }
  
  Treatment copyWith({
    String? id,
    String? patientId,
    Patient? patient,
    String? name,
    String? description,
    List<int>? toothNumbers,
    String? category,
    String? status,
    double? cost,
    String? doctorId,
    String? doctorName,
    DateTime? plannedDate,
    DateTime? completedDate,
    int? sessionsRequired,
    int? sessionsCompleted,
    String? notes,
    List<String>? beforeImages,
    List<String>? afterImages,
    String? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? appointmentId,
  }) {
    return Treatment(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patient: patient ?? this.patient,
      name: name ?? this.name,
      description: description ?? this.description,
      toothNumbers: toothNumbers ?? this.toothNumbers,
      category: category ?? this.category,
      status: status ?? this.status,
      cost: cost ?? this.cost,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      plannedDate: plannedDate ?? this.plannedDate,
      completedDate: completedDate ?? this.completedDate,
      sessionsRequired: sessionsRequired ?? this.sessionsRequired,
      sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
      notes: notes ?? this.notes,
      beforeImages: beforeImages ?? this.beforeImages,
      afterImages: afterImages ?? this.afterImages,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      appointmentId: appointmentId ?? this.appointmentId,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patient': patient?.toJson(),
      'name': name,
      'description': description,
      'toothNumbers': toothNumbers,
      'category': category,
      'status': status,
      'cost': cost,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'plannedDate': plannedDate.toIso8601String(),
      'completedDate': completedDate?.toIso8601String(),
      'sessionsRequired': sessionsRequired,
      'sessionsCompleted': sessionsCompleted,
      'notes': notes,
      'beforeImages': beforeImages,
      'afterImages': afterImages,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'appointmentId': appointmentId,
    };
  }
  
  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      patientId: json['patientId'],
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
      name: json['name'],
      description: json['description'],
      toothNumbers: List<int>.from(json['toothNumbers'] ?? []),
      category: json['category'],
      status: json['status'],
      cost: json['cost']?.toDouble() ?? 0.0,
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      plannedDate: DateTime.parse(json['plannedDate']),
      completedDate: json['completedDate'] != null 
          ? DateTime.parse(json['completedDate']) 
          : null,
      sessionsRequired: json['sessionsRequired'] ?? 1,
      sessionsCompleted: json['sessionsCompleted'] ?? 0,
      notes: json['notes'] ?? '',
      beforeImages: List<String>.from(json['beforeImages'] ?? []),
      afterImages: List<String>.from(json['afterImages'] ?? []),
      priority: json['priority'] ?? 'Medium',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      appointmentId: json['appointmentId'],
    );
  }
}