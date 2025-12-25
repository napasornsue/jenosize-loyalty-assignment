import 'package:jenosize_loyalty_assignment/core/services/local_storage_service.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';
import 'package:uuid/uuid.dart';

class MembershipRepositoryImpl implements MembershipRepository{

  final _storage = LocalStorageService();

  @override
  Future<Membership?> getMembership() async {
    final joined = _storage.prefs.getBool('membership_joined') ?? false;
    if (!joined) return null;

    final id = _storage.prefs.getString('membership_id');
    final name = _storage.prefs.getString('membership_name');
    final points = _storage.prefs.getInt('membership_points') ?? 0;
    final referralCode = _storage.prefs.getString('membership_referral_code') ?? '';
    final joinedAtString = _storage.prefs.getString('membership_joined_at');

    if (id == null || name == null) return null;

    return Membership(
      id: id,
      name: name,
      points: points,
      referralCode: referralCode,
      joinedAt: joinedAtString != null
          ? DateTime.parse(joinedAtString)
          : null,
    );
  }

  @override
  Future<void> joinMembership(String name) async {
    final id = const Uuid().v4();
    final joinedAt = DateTime.now().toIso8601String();

    await _storage.prefs.setBool('membership_joined', true);
    await _storage.prefs.setString('membership_id', id);
    await _storage.prefs.setString('membership_name', name);
    await _storage.prefs.setString('membership_joined_at', joinedAt);
  }

}