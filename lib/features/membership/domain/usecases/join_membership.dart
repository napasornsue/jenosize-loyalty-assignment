import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';

class JoinMembershipUseCase {
  final MembershipRepository repository;

  JoinMembershipUseCase(this.repository);

  Future<void> call(String name) {
    return repository.joinMembership(name);
  }
}