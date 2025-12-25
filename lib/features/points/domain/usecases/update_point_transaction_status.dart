import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';

class UpdatePointTransactionStatusUseCase {
  final PointTransactionRepository repository;

  UpdatePointTransactionStatusUseCase(this.repository);

  Future<void> call(String transactionId, PointTransactionStatus status) {
    return repository.updatePointTransactionStatus(transactionId, status);
  }
}