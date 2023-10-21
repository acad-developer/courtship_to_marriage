import 'dart:convert';

class Recommendation {
  Recommendation({
    required this.image,
    required this.review,
    required this.name,
    required this.address
  });

  String image;
  String review;
  String name;
  String address;

  factory Recommendation.fromJson(String str) => Recommendation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recommendation.fromMap(Map<String, dynamic> json) => Recommendation(
        image: json["image"],
        review: json["review"],
        name: json["name"],
        address: json["address"]
      );

  Map<String, dynamic> toMap() {
    final map = {
      "image" : image,
      "review" : review,
      "name" : name,
      "address" : address
    };

    return map;
  }
}