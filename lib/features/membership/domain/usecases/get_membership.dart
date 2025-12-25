import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';

class GetMembershipUseCase {
  final MembershipRepository repository;

  GetMembershipUseCase(this.repository);

  Future<Membership?> call() {
    return repository.getMembership();
  }
}