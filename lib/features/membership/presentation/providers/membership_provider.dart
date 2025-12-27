import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/features/membership/data/membership_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';

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

  late final MembershipRepository _repository;

  @override
  MembershipState build() {
    _repository = ref.read(membershipRepositoryProvider);
    _init();
    return const MembershipState();
  }

  Future<void> _init() async {
    await getMembership();
  }

  Future<void> getMembership() async {
    state = const MembershipState(status: Status.loading);
    try {
      final membership = await _repository.getMembership();
      state = MembershipState(status: Status.success, membership: membership);
    } catch (e) {
      state = MembershipState(status: Status.error, error: e.toString());
    }
  }

  Future<void> joinMembership(String name) async {
    state = const MembershipState(status: Status.loading);
    try {
      await _repository.joinMembership(name);
      final membership = await _repository.getMembership();
      state = MembershipState(status: Status.success, membership: membership);
    } catch (e) {
      state = MembershipState(status: Status.error, error: e.toString());
    }
  }
}