import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_assignment/core/services/share_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';

class MockSharePlus extends Mock implements SharePlus {}
class FakeShareParams extends Fake implements ShareParams {}

void main() {
  late MockSharePlus mockSharePlus;
  late ShareService service;

  setUpAll(() {
    registerFallbackValue(FakeShareParams());
  });

  setUp(() {
    mockSharePlus = MockSharePlus();
    service = ShareService(sharePlus: mockSharePlus);
  });

  group('buildReferralUri', () {
    test('Should build correct referral uri', () {
      final membershipId = '12345';
      final uri = service.buildReferralUri(membershipId);

      expect(uri.scheme, 'jenosize');
      expect(uri.host, 'assignment');
      expect(uri.path, '/referral');
      expect(uri.queryParameters['id'], membershipId);
      expect(
        uri.toString(),
        'jenosize://assignment/referral?id=12345',
      );
    });
  });

  group('shareReferral', () {
    test('Should call SharePlus.share with correct ShareParams', () async {
      final membershipId = 'abcde';
      final expectedUri = service.buildReferralUri(membershipId);

      when(() => mockSharePlus.share(any())).thenAnswer(
            (_) async => ShareResult(
          'success',
          ShareResultStatus.success,
        ),
      );

      await service.shareReferral(membershipId);

      verify(() => mockSharePlus.share(
        any(
          that: isA<ShareParams>().having(
                (p) => p.uri,
            'uri',
            expectedUri,
          ),
        ),
      )).called(1);
    });
  });

}