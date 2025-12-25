import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';

class GetPointTransactionsUseCase {
  final PointTransactionRepository repository;

  GetPointTransactionsUseCase(this.repository);

  Future<List<PointTransaction>> call() {
    return repository.getPointTransactions();
  }
}