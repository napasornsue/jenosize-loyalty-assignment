import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign_repository.dart';

class GetAllCampaignsUseCase {
  final CampaignRepository repository;

  GetAllCampaignsUseCase(this.repository);

  Future<List<Campaign>> call() {
    return repository.getAllCampaigns();
  }
}