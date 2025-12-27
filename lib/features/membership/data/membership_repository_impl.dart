import 'package:jenosize_loyalty_assignment/core/constants/shared_preferences_keys.dart';
import 'package:jenosize_loyalty_assignment/core/services/local_storage_service.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership.dart';
import 'package:jenosize_loyalty_assignment/features/membership/domain/membership_repository.dart';
import 'package:uuid/uuid.dart';

class MembershipRepositoryImpl implements MembershipRepository{

  final _storage = LocalStorageService();

  @override
  Future<Membership?> getMembership() async {
    final joined = _storage.prefs.getBool(SharedPreferencesKeys.membershipJoined) ?? false;
    if (!joined) return null;

    final id = _storage.prefs.getString(SharedPreferencesKeys.membershipId);
    final name = _storage.prefs.getString(SharedPreferencesKeys.membershipName);
    final points = _storage.prefs.getInt(SharedPreferencesKeys.membershipPoints) ?? 0;
    final joinedAtString = _storage.prefs.getString(SharedPreferencesKeys.membershipJoinedAt);

    if (id == null || name == null) return null;

    return Membership(
      id: id,
      name: name,
      points: points,
      joinedAt: joinedAtString != null
          ? DateTime.parse(joinedAtString)
          : null,
    );
  }

  @override
  Future<void> joinMembership(String name) async {
    final id = const Uuid().v4();
    final joinedAt = DateTime.now().toIso8601String();

    await _storage.prefs.setBool(SharedPreferencesKeys.membershipJoined, true);
    await _storage.prefs.setString(SharedPreferencesKeys.membershipId, id);
    await _storage.prefs.setString(SharedPreferencesKeys.membershipName, name);
    await _storage.prefs.setString(SharedPreferencesKeys.membershipJoinedAt, joinedAt);
  }

}