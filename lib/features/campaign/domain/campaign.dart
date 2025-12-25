class Campaign {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String ctaText;
  final bool isJoined;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ctaText,
    this.isJoined = false,
  });

  Campaign copyWith({
    bool? isJoined,
  }) {
    return Campaign(
      id: id,
      title: title,
      description: description,
      ctaText: ctaText,
      imageUrl: imageUrl,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}