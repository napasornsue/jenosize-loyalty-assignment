import 'package:jenosize_loyalty_assignment/core/constants/shared_preferences_keys.dart';
import 'package:jenosize_loyalty_assignment/core/services/local_storage_service.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository{

  final _storage = LocalStorageService();

  final List<Campaign> _campaigns = [
    Campaign(id: '1', title: 'Summer Sale', description: 'Get 20% off on all items during our Summer Sale!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/53a0effe-a441-461b-8a91-cd0a1185a014/outputs/output.jpg', isJoined: false),
    Campaign(id: '2', title: 'Winter Wonderland', description: 'Enjoy exclusive deals this winter season!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/8e3f8d18-6585-44e0-b80e-bdb6ac39385b/outputs/output.jpg', isJoined: false),
    Campaign(id: '3', title: 'Spring Fling', description: 'Celebrate spring with special discounts!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/fb8c6e7f-825f-4ca9-b6e8-e397998f5356/outputs/output.jpg', isJoined: false),
    Campaign(id: '4', title: 'Holiday Specials', description: 'Unwrap amazing offers this holiday season!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/3933f403-8d68-497c-ba8a-d6f410a274c5/outputs/output.jpg', isJoined: false),
    Campaign(id: '5', title: 'Back to School', description: 'Prepare for the new school year with great deals!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/be229edf-3681-401c-bafa-0704a98f7a42/outputs/output.jpg', isJoined: false),
    Campaign(id: '6', title: 'Black Friday Bonanza', description: 'Don\'t miss out on our Black Friday extravaganza!', ctaText: 'Join Now', imageUrl: 'https://api.deepai.org/job-view-file/7584f1ce-0fc4-4d95-92a6-453a221b7841/outputs/output.jpg', isJoined: false),
  ];

  @override
  Future<List<Campaign>> getAllCampaigns() async {
    final joinedCampaigns =
        _storage.prefs.getStringList('joined_campaigns') ?? [];

    return _campaigns.map((campaign) {
      final joined = joinedCampaigns.contains(campaign.id);
      return campaign.copyWith(isJoined: joined);
    }).toList();
  }

  @override
  Future<void> joinCampaign(String campaignId) async {
    final prefs = _storage.prefs;

    final joinedCampaigns =
        prefs.getStringList(SharedPreferencesKeys.joinedCampaigns) ?? [];

    if (!joinedCampaigns.contains(campaignId)) {
      joinedCampaigns.add(campaignId);

      await prefs.setStringList(
        SharedPreferencesKeys.joinedCampaigns,
        joinedCampaigns,
      );
    }
  }

}