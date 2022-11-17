class RawSari {
  String title;
  String? buyingPrice;
  String? details;
  String color;
  bool? tercell;

  List<String>? images;
  String? source;

  RawSari({
    required this.title,
    this.buyingPrice,
    this.details,
    required this.color,
    this.tercell = true,
    this.images,
    this.source,
  });

  factory RawSari.fromJson({required Map<String, dynamic> json}) {
    return RawSari(
      title: json['title'],
      color: json['color'],
      buyingPrice: json['buyingPrice'],
      buyingPrice: json['buyingPrice'],
    );
  }
}
