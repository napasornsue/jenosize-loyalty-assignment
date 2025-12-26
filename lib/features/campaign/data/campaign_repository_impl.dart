import 'package:jenosize_loyalty_assignment/core/constants/shared_preferences_keys.dart';
import 'package:jenosize_loyalty_assignment/core/services/local_storage_service.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository{

  final _storage = LocalStorageService();

  final List<Campaign> _campaigns = [
    Campaign(id: '1', title: 'Summer Sale', description: 'Get 20% off on all items during our Summer Sale!', ctaText: 'Join Now', imageUrl: 'https://community.thriveglobal.com/wp-content/uploads/2020/06/summer.jpg', isJoined: false),
    Campaign(id: '2', title: 'Winter Wonderland', description: 'Enjoy exclusive deals this winter season!', ctaText: 'Join Now', imageUrl: 'https://finland.fi/wp-content/uploads/2015/05/3708-talvi-6_600_400-jpg.jpg', isJoined: false),
    Campaign(id: '3', title: 'Spring Fling', description: 'Celebrate spring with special discounts!', ctaText: 'Join Now', imageUrl: 'https://cdn.shopify.com/s/files/1/0778/2679/files/spring_trees.jpg?v=1616252131', isJoined: false),
    Campaign(id: '4', title: 'Holiday Specials', description: 'Unwrap amazing offers this holiday season!', ctaText: 'Join Now', imageUrl: 'https://media.product.which.co.uk/prod/images/original/fa9a529f543e-best-and-worst-package-holiday-providerslead.jpg', isJoined: false),
    Campaign(id: '5', title: 'Back to School', description: 'Prepare for the new school year with great deals!', ctaText: 'Join Now', imageUrl: 'https://img.freepik.com/free-vector/vector-cartoon-illustration-school-building-green-lawn-road-trees-educalion-l_134830-1588.jpg?semt=ais_hybrid&w=740&q=80', isJoined: false),
    Campaign(id: '6', title: 'Black Friday Bonanza', description: 'Don\'t miss out on our Black Friday extravaganza!', ctaText: 'Join Now', imageUrl: 'https://cdn.shopify.com/s/files/1/0504/1094/6753/files/why-is-it-called-black-friday-1.jpg?v=1762762579', isJoined: false),
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