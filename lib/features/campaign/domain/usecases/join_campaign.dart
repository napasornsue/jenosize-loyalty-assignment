import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_status.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_type.dart';
import 'package:uuid/uuid.dart';

class JoinCampaignUseCase {
  final CampaignRepository campaignRepo;
  final PointTransactionRepository pointRepo;

  JoinCampaignUseCase(this.campaignRepo, this.pointRepo);

  Future<void> call(String campaignId) async {
    // 1. Join the campaign
    await campaignRepo.joinCampaign(campaignId);

    // 2. Add a point transaction for joining the campaign
    final earned = PointTransactionType.joinCampaign.points;
    await pointRepo.addPointTransaction(
      PointTransaction(
        id: const Uuid().v4(),
        description: PointTransactionType.joinCampaign.description,
        type: PointTransactionType.joinCampaign,
        points: earned,
        status: PointTransactionStatus.completed,
        updatedAt: DateTime.now(),
      ),
    );
  }
}