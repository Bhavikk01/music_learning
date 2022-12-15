import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums/payment_method.dart';
import 'enums/payment_status.dart';
import 'enums/payment_use_case.dart';

class Payment extends Equatable {
  final int? amountInPaise;
  final String? createUserId;
  final int? createdAt;
  final String? id;
  final int? lastUpdated;
  final String? lastUpdatedBy;
  final Map<String, String>? metadata;
  final PaymentMethod? paymentMethod;
  final int? paymentTime;
  final PaymentUseCase? paymentUseCase;
  final String? pricingPlanId;
  final String? razorpayKey;
  final String? razorpayOrderId;
  final String? recieptNo;
  final PaymentStatus? status;
  final String? userId;

  const Payment({
    this.amountInPaise,
    this.createUserId,
    this.createdAt,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.metadata,
    this.paymentMethod,
    this.paymentTime,
    this.paymentUseCase,
    this.pricingPlanId,
    this.razorpayKey,
    this.razorpayOrderId,
    this.recieptNo,
    this.status,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'amountInPaise': amountInPaise,
      'createUserId': createUserId,
      'createdAt': createdAt,
      'id': id,
      'lastUpdated': lastUpdated,
      'lastUpdatedBy': lastUpdatedBy,
      'metadata': metadata,
      'paymentTime': paymentTime,
      'paymentMethod': paymentMethodToString(paymentMethod!),
      'paymentUseCase': paymentUseCaseToString(paymentUseCase!),
      'pricingPlanId': pricingPlanId,
      'razorpayKey': razorpayKey,
      'razorpayOrderId': razorpayOrderId,
      'recieptNo': recieptNo,
      'status': paymentStatusToString(status!),
      'userId': userId,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      amountInPaise: map['amountInPaise']?.toInt(),
      createUserId: map['createUserId'],
      createdAt: map['createdAt']?.toInt(),
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      metadata: Map<String, String>.from(map['metadata']),
      paymentTime: map['paymentTime']?.toInt(),
      paymentMethod: map['paymentMethod'] == null
          ? null
          : getPaymentMethodFromString(map['paymentMethod']),
      paymentUseCase: map['paymentUseCase'] == null
          ? null
          : getPaymentUseCaseFromString(map['paymentUseCase']),
      status: map['status'] == null
          ? null
          : getPaymentStatusFromString(map['status']),
      pricingPlanId: map['pricingPlanId'],
      razorpayKey: map['razorpayKey'],
      razorpayOrderId: map['razorpayOrderId'],
      recieptNo: map['recieptNo'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payment(amountInPaise: $amountInPaise, createUserId: $createUserId, createdAt: $createdAt, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, metadata: $metadata, paymentTime: $paymentTime, paymentUseCase: $paymentUseCase, pricingPlanId: $pricingPlanId, razorpayKey: $razorpayKey, razorpayOrderId: $razorpayOrderId, recieptNo: $recieptNo, userId: $userId)';
  }

  @override
  List<Object?> get props => [
        amountInPaise,
        createUserId,
        createdAt,
        id,
        lastUpdated,
        lastUpdatedBy,
        metadata,
        paymentTime,
        paymentUseCase,
        pricingPlanId,
        razorpayKey,
        razorpayOrderId,
        recieptNo,
        userId,
      ];
}
