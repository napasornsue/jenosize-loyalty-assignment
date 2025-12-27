import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jenosize_loyalty_assignment/core/presentation/status.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/data/campaign_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/campaign_repository.dart';
import 'package:jenosize_loyalty_assignment/features/campaign/domain/usecases/join_campaign_use_case.dart';
import 'package:jenosize_loyalty_assignment/features/points/data/point_transaction_repository_impl.dart';
import 'package:jenosize_loyalty_assignment/features/points/domain/point_transaction_repository.dart';

final campaignRepositoryProvider = Provider<CampaignRepository>((ref) {
  return CampaignRepositoryImpl();
});

final pointTransactionRepositoryProvider = Provider<PointTransactionRepository>((ref) {
  return PointTransactionRepositoryImpl();
});

final campaignProvider = NotifierProvider<CampaignNotifier, CampaignState>(CampaignNotifier.new);

final joinCampaignUseCaseProvider = Provider<JoinCampaignUseCase>((ref) {
  final campaignRepo = ref.read(campaignRepositoryProvider);
  final pointRepo = ref.read(pointTransactionRepositoryProvider);
  return JoinCampaignUseCase(campaignRepo, pointRepo);
});


class CampaignState {
  final Status status;
  final List<Campaign> campaigns;
  final String? error;

  const CampaignState({
    this.status = Status.initial,
    this.campaigns = const [],
    this.error,
  });

  CampaignState copyWith({
    Status? status,
    List<Campaign>? campaigns,
    String? error,
  }) {
    return CampaignState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
      error: error ?? this.error,
    );
  }
}

class CampaignNotifier extends Notifier<CampaignState> {

  late final CampaignRepository _repository;
  late final JoinCampaignUseCase _joinCampaignUseCase;

  @override
  CampaignState build() {
    _repository = ref.read(campaignRepositoryProvider);
    _joinCampaignUseCase = ref.read(joinCampaignUseCaseProvider);
    getAllCampaigns();
    return const CampaignState();
  }

  Future<void> getAllCampaigns() async {
    state = const CampaignState(status: Status.loading);
    try {
      final campaigns = await _repository.getAllCampaigns();
      state = CampaignState(status: Status.success, campaigns: campaigns);
    } catch (e) {
      state = CampaignState(status: Status.error, error: e.toString());
    }
  }

  Future<void> joinCampaign(String campaignId) async {
    try {
      await _joinCampaignUseCase.call(campaignId);
      await getAllCampaigns();
    } catch (e) {
      state = CampaignState(status: Status.error, error: e.toString());
    }
  }
}