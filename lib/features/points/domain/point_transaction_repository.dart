import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';

abstract class PointTransactionRepository {
  Future<List<PointTransaction>> getPointTransactions();
  Future<void> addPointTransaction(PointTransaction transaction);
  Future<void> updatePointTransactionStatus(String transactionId, PointTransactionStatus status);
  Future<int> getPoints();
}