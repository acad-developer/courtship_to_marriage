import 'dart:convert';

List<Blog> blogFromJson(String str) => List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
    final String? title;
    final String? content;
    final String? excerpt;
    final Author? author;
    final String? thumbnail;

    Blog({
        this.title,
        this.content,
        this.excerpt,
        this.author,
        this.thumbnail,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        title: json["title"],
        content: json["content"],
        excerpt: json["excerpt"],
        author: authorValues.map[json["author"]]!,
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "excerpt": excerpt,
        "author": authorValues.reverse[author],
        "thumbnail": thumbnail,
    };
}

enum Author {
    EVANS_FRANCIS
}

final authorValues = EnumValues({
    "Evans Francis": Author.EVANS_FRANCIS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
