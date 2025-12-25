import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_type.dart';

class PointTransaction {
  final String id;
  final String description;
  final PointTransactionType type;
  final PointTransactionStatus status;
  final int points;
  final DateTime updatedAt;

  PointTransaction({
    required this.id,
    required this.description,
    required this.type,
    required this.status,
    required this.points,
    required this.updatedAt,
  });

  PointTransaction copyWith({
    String? id,
    String? description,
    int? points,
    PointTransactionType? type,
    PointTransactionStatus? status,
    DateTime? updatedAt,
  }) {
    return PointTransaction(
      id: id ?? this.id,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      points: points ?? this.points,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PointTransaction.fromJson(Map<String, dynamic> json) {
    return PointTransaction(
      id: json['id'],
      description: json['description'],
      type: PointTransactionType.values.firstWhere((e) => e.toString() == 'PointTransactionType.${json['type']}'),
      status: PointTransactionStatus.values.firstWhere((e) => e.toString() == 'PointTransactionStatus.${json['status']}'),
      points: json['points'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'type': type.name,
      'status': status.name,
      'points': points,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}