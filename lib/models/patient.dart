class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final String address;
  final String emergencyContact;
  final String emergencyPhone;
  final String insuranceProvider;
  final String insuranceNumber;
  final List<String> allergies;
  final List<String> medicalConditions;
  final List<String> medications;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String priority; // Low, Medium, High, Urgent
  final String? profileImage;
  
  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.address,
    required this.emergencyContact,
    required this.emergencyPhone,
    required this.insuranceProvider,
    required this.insuranceNumber,
    required this.allergies,
    required this.medicalConditions,
    required this.medications,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.priority = 'Medium',
    this.profileImage,
  });
  
  String get fullName => '$firstName $lastName';
  
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
  
  bool get hasAllergies => allergies.isNotEmpty;
  bool get hasMedicalConditions => medicalConditions.isNotEmpty;
  bool get isHighPriority => priority == 'High' || priority == 'Urgent';
  
  Patient copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? dateOfBirth,
    String? address,
    String? emergencyContact,
    String? emergencyPhone,
    String? insuranceProvider,
    String? insuranceNumber,
    List<String>? allergies,
    List<String>? medicalConditions,
    List<String>? medications,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? priority,
    String? profileImage,
  }) {
    return Patient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      insuranceProvider: insuranceProvider ?? this.insuranceProvider,
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      allergies: allergies ?? this.allergies,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      medications: medications ?? this.medications,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      priority: priority ?? this.priority,
      profileImage: profileImage ?? this.profileImage,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'address': address,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'insuranceProvider': insuranceProvider,
      'insuranceNumber': insuranceNumber,
      'allergies': allergies,
      'medicalConditions': medicalConditions,
      'medications': medications,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'priority': priority,
      'profileImage': profileImage,
    };
  }
  
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      address: json['address'],
      emergencyContact: json['emergencyContact'],
      emergencyPhone: json['emergencyPhone'],
      insuranceProvider: json['insuranceProvider'],
      insuranceNumber: json['insuranceNumber'],
      allergies: List<String>.from(json['allergies'] ?? []),
      medicalConditions: List<String>.from(json['medicalConditions'] ?? []),
      medications: List<String>.from(json['medications'] ?? []),
      notes: json['notes'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isActive: json['isActive'] ?? true,
      priority: json['priority'] ?? 'Medium',
      profileImage: json['profileImage'],
    );
  }
}