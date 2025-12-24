import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_type.dart';

class PointTransaction {
  final String id;
  final PointTransactionType type;
  final PointTransactionStatus status;
  final int points;
  final DateTime updatedAt;

  PointTransaction({
    required this.id,
    required this.type,
    required this.status,
    required this.points,
    required this.updatedAt,
  });
}