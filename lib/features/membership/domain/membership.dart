class Membership {
  final String id;
  final String name;
  final int points;
  final DateTime joinedAt;
  final List<String> joinedCampaigns;

  Membership({
    required this.id,
    required this.name,
    int? points,
    DateTime? joinedAt,
    List<String>? joinedCampaigns,
  }) : points = points ?? 0,
       joinedAt = joinedAt ?? DateTime.now(),
       joinedCampaigns = joinedCampaigns ?? [];

}