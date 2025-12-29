import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareServiceProvider = Provider<ShareService>((ref) {
  return ShareService();
});

class ShareService {
  final SharePlus sharePlus;

  ShareService({SharePlus? sharePlus})
      : sharePlus = sharePlus ?? SharePlus.instance;

  Uri buildReferralUri(String membershipId) {
    return Uri(
      scheme: 'jenosize',
      host: 'assignment',
      path: '/referral',
      queryParameters: {'id': membershipId},
    );
  }

  Future<void> shareReferral(String membershipId) async {
    final referralLink = buildReferralUri(membershipId);

    await sharePlus.share(
      ShareParams(uri: referralLink),
    );
  }
}
