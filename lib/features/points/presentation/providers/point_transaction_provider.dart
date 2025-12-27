import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/features/points/data/point_transaction_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';

final pointTransactionRepositoryProvider =
Provider<PointTransactionRepository>((ref) => PointTransactionRepositoryImpl());

final pointTransactionProvider =
NotifierProvider<PointTransactionNotifier, PointTransactionState>(PointTransactionNotifier.new);

final pointsProvider = FutureProvider<int>((ref) async {
  return ref.watch(pointTransactionRepositoryProvider).getPoints();
});

class PointTransactionState{
  final Status status;
  final int points;
  final List<PointTransaction> transactions;
  final String? error;

  const PointTransactionState({
    this.status = Status.initial,
    this.points = 0,
    this.transactions = const [],
    this.error,
  });

  PointTransactionState copyWith({
    Status? status,
    int? points,
    List<PointTransaction>? transactions,
    String? error,
  }) {
    return PointTransactionState(
      status: status ?? this.status,
      points: points ?? this.points,
      transactions: transactions ?? this.transactions,
      error: error ?? this.error,
    );
  }
}

class PointTransactionNotifier extends Notifier<PointTransactionState> {
  late final PointTransactionRepository _repository;

  @override
  PointTransactionState build() {
    _repository = ref.read(pointTransactionRepositoryProvider);
    load();
    return const PointTransactionState();
  }

  Future<void> load() async {
    await getPointTransactions();
  }

  Future<void> getPointTransactions() async {
    state = const PointTransactionState(status: Status.loading);
    try {
      final points = await _repository.getPoints();
      final transactions = await _repository.getPointTransactions();
      state = PointTransactionState(
        status: Status.success,
        points: points,
        transactions: transactions,
      );
    } catch (e) {
      state = PointTransactionState(status: Status.error, error: e.toString());
    }
  }
}