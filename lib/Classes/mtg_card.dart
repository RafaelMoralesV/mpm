class MtgCard {
  final String name;

  MtgCard({
    required this.name,
  });

  factory MtgCard.fromJson(Map<String, dynamic> json) {
    return MtgCard(
      name: json['name'],
    );
  }
}
