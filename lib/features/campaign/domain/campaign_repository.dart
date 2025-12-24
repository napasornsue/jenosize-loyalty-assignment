import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign.dart';

abstract class CampaignRepository {
  Future<List<Campaign>> getAllCampaigns();
  Future<void> joinCampaign(String campaignId);
}