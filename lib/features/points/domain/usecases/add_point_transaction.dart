import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';

class AddPointTransactionUseCase {
  final PointTransactionRepository repository;

  AddPointTransactionUseCase(this.repository);

  Future<void> call(PointTransaction transaction) {
    return repository.addPointTransaction(transaction);
  }
}