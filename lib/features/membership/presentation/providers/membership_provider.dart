import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/features/membership/data/membership_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_type.dart';
import 'package:jenosize_loyalty_assignment/features/points/presentation/providers/point_transaction_provider.dart';
import 'package:uuid/uuid.dart';

final membershipRepositoryProvider = Provider<MembershipRepository>((ref) => MembershipRepositoryImpl());

final membershipProvider = NotifierProvider<MembershipNotifier, MembershipState>(MembershipNotifier.new);

class MembershipState {
  final Status status;
  final Membership? membership;
  final String? error;

  const MembershipState({this.status = Status.initial, this.membership, this.error});

  MembershipState copyWith({Status? status, Membership? membership, String? error}) {
    return MembershipState(
      status: status ?? this.status,
      membership: membership ?? this.membership,
      error: error ?? this.error,
    );
  }
}

class MembershipNotifier extends Notifier<MembershipState> {

  late final MembershipRepository _memberRepo;
  late final PointTransactionRepository _pointRepo;

  @override
  MembershipState build() {
    _memberRepo = ref.read(membershipRepositoryProvider);
    _pointRepo = ref.read(pointTransactionRepositoryProvider);
    _init();
    return const MembershipState(status: Status.loading);
  }

  Future<void> _init() async {
    await getMembership();
  }

  Future<void> getMembership() async {
    try {
      final membership = await _memberRepo.getMembership();
      state = MembershipState(status: Status.success, membership: membership);
    } catch (e) {
      state = MembershipState(status: Status.error, error: e.toString());
    }
  }

  Future<void> joinMembership(String name) async {
    state = const MembershipState(status: Status.loading);
    try {
      await _memberRepo.joinMembership(name);
      final membership = await _memberRepo.getMembership();
      state = MembershipState(status: Status.success, membership: membership);
    } catch (e) {
      state = MembershipState(status: Status.error, error: e.toString());
    }
  }

  Future<void> addReferralTransaction() async {
    if (state.membership == null) return;

    final transaction = PointTransaction(
      id: const Uuid().v4(),
      description: PointTransactionType.referral.description,
      type: PointTransactionType.referral,
      points: PointTransactionType.referral.points,
      status: PointTransactionStatus.pending,
      updatedAt: DateTime.now(),
    );

    try {
      await _pointRepo.addPointTransaction(transaction);
      ref.read(pointTransactionProvider.notifier).load();
    } catch (e) {
      debugPrint('Failed to add referral transaction: $e');
    }
  }
}