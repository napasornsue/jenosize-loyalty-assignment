import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';

abstract class MembershipRepository {
  Future<Membership?> getMembership();
  Future<void> joinMembership(String name);
}