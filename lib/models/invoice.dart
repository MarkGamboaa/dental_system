import 'patient.dart';
import 'treatment.dart';

class Invoice {
  final String id;
  final String patientId;
  final Patient? patient;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final List<InvoiceItem> items;
  final double subtotal;
  final double taxRate;
  final double taxAmount;
  final double discountAmount;
  final double totalAmount;
  final double paidAmount;
  final double balanceAmount;
  final String status; // Draft, Sent, Paid, Overdue, Cancelled
  final String paymentMethod;
  final String notes;
  final DateTime? paidDate;
  final List<Payment> payments;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  Invoice({
    required this.id,
    required this.patientId,
    this.patient,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.dueDate,
    required this.items,
    required this.subtotal,
    this.taxRate = 0.0,
    required this.taxAmount,
    this.discountAmount = 0.0,
    required this.totalAmount,
    this.paidAmount = 0.0,
    required this.balanceAmount,
    required this.status,
    this.paymentMethod = '',
    this.notes = '',
    this.paidDate,
    this.payments = const [],
    required this.createdAt,
    required this.updatedAt,
  });
  
  bool get isPaid => status == 'Paid' && balanceAmount <= 0;
  bool get isOverdue => dueDate.isBefore(DateTime.now()) && !isPaid;
  bool get isPartiallyPaid => paidAmount > 0 && balanceAmount > 0;
  
  double get paymentProgress {
    if (totalAmount <= 0) return 0.0;
    return paidAmount / totalAmount;
  }
  
  Invoice copyWith({
    String? id,
    String? patientId,
    Patient? patient,
    String? invoiceNumber,
    DateTime? invoiceDate,
    DateTime? dueDate,
    List<InvoiceItem>? items,
    double? subtotal,
    double? taxRate,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    double? paidAmount,
    double? balanceAmount,
    String? status,
    String? paymentMethod,
    String? notes,
    DateTime? paidDate,
    List<Payment>? payments,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patient: patient ?? this.patient,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      paidDate: paidDate ?? this.paidDate,
      payments: payments ?? this.payments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patient': patient?.toJson(),
      'invoiceNumber': invoiceNumber,
      'invoiceDate': invoiceDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'discountAmount': discountAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'balanceAmount': balanceAmount,
      'status': status,
      'paymentMethod': paymentMethod,
      'notes': notes,
      'paidDate': paidDate?.toIso8601String(),
      'payments': payments.map((payment) => payment.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      patientId: json['patientId'],
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
      invoiceNumber: json['invoiceNumber'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      dueDate: DateTime.parse(json['dueDate']),
      items: (json['items'] as List? ?? [])
          .map((item) => InvoiceItem.fromJson(item))
          .toList(),
      subtotal: json['subtotal']?.toDouble() ?? 0.0,
      taxRate: json['taxRate']?.toDouble() ?? 0.0,
      taxAmount: json['taxAmount']?.toDouble() ?? 0.0,
      discountAmount: json['discountAmount']?.toDouble() ?? 0.0,
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      paidAmount: json['paidAmount']?.toDouble() ?? 0.0,
      balanceAmount: json['balanceAmount']?.toDouble() ?? 0.0,
      status: json['status'],
      paymentMethod: json['paymentMethod'] ?? '',
      notes: json['notes'] ?? '',
      paidDate: json['paidDate'] != null ? DateTime.parse(json['paidDate']) : null,
      payments: (json['payments'] as List? ?? [])
          .map((payment) => Payment.fromJson(payment))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class InvoiceItem {
  final String id;
  final String treatmentId;
  final Treatment? treatment;
  final String description;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  
  InvoiceItem({
    required this.id,
    required this.treatmentId,
    this.treatment,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'treatmentId': treatmentId,
      'treatment': treatment?.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
    };
  }
  
  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'],
      treatmentId: json['treatmentId'],
      treatment: json['treatment'] != null ? Treatment.fromJson(json['treatment']) : null,
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice']?.toDouble() ?? 0.0,
      totalPrice: json['totalPrice']?.toDouble() ?? 0.0,
    );
  }
}

class Payment {
  final String id;
  final String invoiceId;
  final double amount;
  final String method;
  final DateTime paymentDate;
  final String reference;
  final String notes;
  final DateTime createdAt;
  
  Payment({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.method,
    required this.paymentDate,
    this.reference = '',
    this.notes = '',
    required this.createdAt,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'amount': amount,
      'method': method,
      'paymentDate': paymentDate.toIso8601String(),
      'reference': reference,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      invoiceId: json['invoiceId'],
      amount: json['amount']?.toDouble() ?? 0.0,
      method: json['method'],
      paymentDate: DateTime.parse(json['paymentDate']),
      reference: json['reference'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}