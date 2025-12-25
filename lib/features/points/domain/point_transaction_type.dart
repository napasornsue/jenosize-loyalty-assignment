enum PointTransactionType {
  joinCampaign,
  referral,
}

extension PointTransactionTypeExtension on PointTransactionType {
  String get description {
    switch (this) {
      case PointTransactionType.joinCampaign:
        return 'Join Campaign';
      case PointTransactionType.referral:
        return 'Referral';
    }
  }
  int get points {
    switch (this) {
      case PointTransactionType.joinCampaign:
        return 50;
      case PointTransactionType.referral:
        return 100;
    }
  }
}