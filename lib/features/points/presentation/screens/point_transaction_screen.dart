import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';
import 'package:jenosize_loyalty_assignment/features/points/presentation/providers/point_transaction_provider.dart';

class PointTransactionScreen extends ConsumerWidget {
  const PointTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pointTransactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Point Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(PointTransactionState state) {
    switch (state.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());

      case Status.error:
        return Center(child: Text(state.error ?? 'Something went wrong'));

      case Status.success:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsCard(state.points ?? 0),
            const SizedBox(height: 16),
            const Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: (state.transactions?.isEmpty ?? true)
                  ? const Center(child: Text('No transactions yet'))
                  : ListView.separated(
                itemCount: state.transactions!.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) =>
                    _buildTransactionTile(state.transactions![index]),
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPointsCard(int points) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFEDE7FF),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.star, color: Colors.deepPurple, size: 32),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Points',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '$points pts',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(PointTransaction tx) {
    final date = DateFormat('dd MMM yyyy • HH:mm').format(tx.updatedAt);
    final isPending = tx.status == PointTransactionStatus.pending;
    final color = isPending ? Colors.grey : Colors.black;
    final pointsColor = isPending
        ? Colors.grey
        : (tx.points >= 0 ? Colors.green : Colors.red);

    return ListTile(
      leading: Icon(
        tx.points >= 0 ? Icons.add_circle : Icons.remove_circle,
        color: pointsColor,
      ),
      title: Text(
        isPending ? '${tx.description} (Pending)' : tx.description,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ),
      subtitle: Text(date),
      trailing: Text(
        '${tx.points > 0 ? '+' : ''}${tx.points}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: pointsColor,
        ),
      ),
    );
  }
}