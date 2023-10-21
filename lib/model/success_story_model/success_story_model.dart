import 'dart:convert';

class SuccessStory {
  SuccessStory({
    required this.review,
    required this.name,
  });

  String review;
  String name;

  factory SuccessStory.fromJson(String str) => SuccessStory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuccessStory.fromMap(Map<String, dynamic> json) => SuccessStory(
        review: json["review"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() {
    final map = {
      "review" : review,
      "name" : name,
    };

    return map;
  }
}