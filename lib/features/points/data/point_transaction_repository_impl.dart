import 'dart:convert';
import 'dart:math';

import 'package:jenosize_loyalty_assignment/core/constants/shared_preferences_keys.dart';
import 'package:jenosize_loyalty_assignment/core/services/local_storage_service.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';

class PointTransactionRepositoryImpl implements PointTransactionRepository{

  final _storage = LocalStorageService();

  @override
  Future<List<PointTransaction>> getPointTransactions() async {
    final list = _storage.prefs.getStringList(SharedPreferencesKeys.pointTransactions) ?? [];
    return list.map((e) => PointTransaction.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> addPointTransaction(PointTransaction transaction) async {
    final list = _storage.prefs.getStringList(SharedPreferencesKeys.pointTransactions) ?? [];
    list.add(jsonEncode(transaction.toJson()));
    await _storage.prefs.setStringList(SharedPreferencesKeys.pointTransactions, list);
  }

  @override
  Future<void> updatePointTransactionStatus(String transactionId, PointTransactionStatus status) async {
    final transactions = await getPointTransactions();
    final index = transactions.indexWhere((t) => t.id == transactionId);
    if (index != -1) return;
    final updated = transactions[index].copyWith(status: status);
    transactions[index] = updated;
    await _storage.prefs.setStringList(
      SharedPreferencesKeys.pointTransactions,
      transactions.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

}