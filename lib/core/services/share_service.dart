import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareServiceProvider = Provider<ShareService>((ref) {
  return ShareService();
});

class ShareService {
  Future<void> shareReferral(String membershipId) async {
    final referralLink = Uri(
      scheme: 'jenosize',
      host: 'assignment',
      path: '/referral',
      queryParameters: {
        'id': membershipId,
      },
    );

    await SharePlus.instance.share(
      ShareParams(uri: referralLink),
    );
  }
}
