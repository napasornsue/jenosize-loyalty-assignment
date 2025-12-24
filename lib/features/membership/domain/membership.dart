class Membership {
  final String id;
  final String name;
  final int points;
  final DateTime joinedAt;
  final List<String> joinedCampaigns;
  final String referralCode;

  Membership({
    required this.id,
    required this.name,
    required this.points,
    required this.referralCode,
    DateTime? joinedAt,
    List<String>? joinedCampaigns,
  }) :  joinedAt = joinedAt ?? DateTime.now(),
        joinedCampaigns = joinedCampaigns ?? [];
}