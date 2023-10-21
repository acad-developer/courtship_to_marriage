// To parse this JSON data, do
//
//     final getCourse = getCourseFromJson(jsonString);

import 'dart:convert';

GetCourse getCourseFromJson(String str) => GetCourse.fromJson(json.decode(str));

String getCourseToJson(GetCourse data) => json.encode(data.toJson());

class GetCourse {
    final String? statusCode;
    final String? message;
    final Data? data;

    GetCourse({
        this.statusCode,
        this.message,
        this.data,
    });

    factory GetCourse.fromJson(Map<String, dynamic> json) => GetCourse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final List<Course>? courses;
    final int? totalCourses;
    final int? totalPage;

    Data({
        this.courses,
        this.totalCourses,
        this.totalPage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        totalCourses: json["total_courses"],
        totalPage: json["total_page"],
    );

    Map<String, dynamic> toJson() => {
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "total_courses": totalCourses,
        "total_page": totalPage,
    };
}

class Course {
    final int? id;
    final String? postTitle;
    final PostStatus? postStatus;
    final dynamic featuredImage;
    final TutorCourseSettings? tutorCourseSettings;
    final String? tutorCourseLevel;
    final String? tutorIsPublicCourse;
    final String? tutorEnableQa;
    final String? tutorCoursePriceType;
    final List<Topic>? topics;
    final ProductData? productData;

    Course({
        this.id,
        this.postTitle,
        this.postStatus,
        this.featuredImage,
        this.tutorCourseSettings,
        this.tutorCourseLevel,
        this.tutorIsPublicCourse,
        this.tutorEnableQa,
        this.tutorCoursePriceType,
        this.topics,
        this.productData,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["ID"],
        postTitle: json["post_title"],
        postStatus: postStatusValues.map[json["post_status"]]!,
        featuredImage: json["featured_image"],
        tutorCourseSettings: json["_tutor_course_settings"] == null ? null : TutorCourseSettings.fromJson(json["_tutor_course_settings"]),
        tutorCourseLevel: json["_tutor_course_level"],
        tutorIsPublicCourse: json["_tutor_is_public_course"],
        tutorEnableQa: json["_tutor_enable_qa"],
        tutorCoursePriceType: json["_tutor_course_price_type"],
        topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
        productData: json["product_data"] == null ? null : ProductData.fromJson(json["product_data"]),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "post_title": postTitle,
        "post_status": postStatusValues.reverse[postStatus],
        "featured_image": featuredImage,
        "_tutor_course_settings": tutorCourseSettings?.toJson(),
        "_tutor_course_level": tutorCourseLevel,
        "_tutor_is_public_course": tutorIsPublicCourse,
        "_tutor_enable_qa": tutorEnableQa,
        "_tutor_course_price_type": tutorCoursePriceType,
        "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
        "product_data": productData?.toJson(),
    };
}

enum PostStatus {
    PUBLISH
}

final postStatusValues = EnumValues({
    "publish": PostStatus.PUBLISH
});

class ProductData {
    final String? salePrice;
    final String? regularPrice;
    final String? indianZonePriceMethod;
    final String? indianZoneRegularPrice;
    final String? indianZonePrice;
    final String? indianZoneSalePrice;
    final int? thumbnailId;
    final String? thumbnailUrl;

    ProductData({
        this.salePrice,
        this.regularPrice,
        this.indianZonePriceMethod,
        this.indianZoneRegularPrice,
        this.indianZonePrice,
        this.indianZoneSalePrice,
        this.thumbnailId,
        this.thumbnailUrl,
    });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        salePrice: json["sale_price"],
        regularPrice: json["regular_price"],
        indianZonePriceMethod: json["_indian_zone_price_method"],
        indianZoneRegularPrice: json["_indian_zone_regular_price"],
        indianZonePrice: json["_indian_zone_price"],
        indianZoneSalePrice: json["_indian_zone_sale_price"],
        thumbnailId: json["thumbnail_id"],
        thumbnailUrl: json["thumbnail_url"],
    );

    Map<String, dynamic> toJson() => {
        "sale_price": salePrice,
        "regular_price": regularPrice,
        "_indian_zone_price_method": indianZonePriceMethod,
        "_indian_zone_regular_price": indianZoneRegularPrice,
        "_indian_zone_price": indianZonePrice,
        "_indian_zone_sale_price": indianZoneSalePrice,
        "thumbnail_id": thumbnailId,
        "thumbnail_url": thumbnailUrl,
    };
}

class Topic {
    final int? id;
    final String? postTitle;
    final String? postContent;
    final PostStatus? postStatus;
    final List<Lesson>? lessons;

    Topic({
        this.id,
        this.postTitle,
        this.postContent,
        this.postStatus,
        this.lessons,
    });

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["ID"],
        postTitle: json["post_title"],
        postContent: json["post_content"],
        postStatus: postStatusValues.map[json["post_status"]]!,
        lessons: json["lessons"] == null ? [] : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "post_title": postTitle,
        "post_content": postContent,
        "post_status": postStatusValues.reverse[postStatus],
        "lessons": lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
    };
}

class Lesson {
    final int? id;
    final String? postTitle;
    final String? postContent;
    final PostStatus? postStatus;
    final CommentStatus? commentStatus;
    final String? postName;
    final DateTime? postModified;
    final int? postParent;
    final String? guid;
    final Video? video;
    final dynamic featuredImage;

    Lesson({
        this.id,
        this.postTitle,
        this.postContent,
        this.postStatus,
        this.commentStatus,
        this.postName,
        this.postModified,
        this.postParent,
        this.guid,
        this.video,
        this.featuredImage,
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["ID"],
        postTitle: json["post_title"],
        postContent: json["post_content"],
        postStatus: postStatusValues.map[json["post_status"]]!,
        commentStatus: commentStatusValues.map[json["comment_status"]]!,
        postName: json["post_name"],
        postModified: json["post_modified"] == null ? null : DateTime.parse(json["post_modified"]),
        postParent: json["post_parent"],
        guid: json["guid"],
        video: json["_video"] == null ? null : Video.fromJson(json["_video"]),
        featuredImage: json["featured_image"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "post_title": postTitle,
        "post_content": postContent,
        "post_status": postStatusValues.reverse[postStatus],
        "comment_status": commentStatusValues.reverse[commentStatus],
        "post_name": postName,
        "post_modified": postModified?.toIso8601String(),
        "post_parent": postParent,
        "guid": guid,
        "_video": video?.toJson(),
        "featured_image": featuredImage,
    };
}

enum CommentStatus {
    OPEN
}

final commentStatusValues = EnumValues({
    "open": CommentStatus.OPEN
});

class Video {
    final Source? source;
    final String? sourceVideoId;
    final String? poster;
    final String? sourceExternalUrl;
    final String? sourceShortcode;
    final String? sourceYoutube;
    final String? sourceVimeo;
    final String? sourceEmbedded;
    final String? sourceBunnynet;
    final Runtime? runtime;

    Video({
        this.source,
        this.sourceVideoId,
        this.poster,
        this.sourceExternalUrl,
        this.sourceShortcode,
        this.sourceYoutube,
        this.sourceVimeo,
        this.sourceEmbedded,
        this.sourceBunnynet,
        this.runtime,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        source: sourceValues.map[json["source"]]!,
        sourceVideoId: json["source_video_id"],
        poster: json["poster"],
        sourceExternalUrl: json["source_external_url"],
        sourceShortcode: json["source_shortcode"],
        sourceYoutube: json["source_youtube"],
        sourceVimeo: json["source_vimeo"],
        sourceEmbedded: json["source_embedded"],
        sourceBunnynet: json["source_bunnynet"],
        runtime: json["runtime"] == null ? null : Runtime.fromJson(json["runtime"]),
    );

    Map<String, dynamic> toJson() => {
        "source": sourceValues.reverse[source],
        "source_video_id": sourceVideoId,
        "poster": poster,
        "source_external_url": sourceExternalUrl,
        "source_shortcode": sourceShortcode,
        "source_youtube": sourceYoutube,
        "source_vimeo": sourceVimeo,
        "source_embedded": sourceEmbedded,
        "source_bunnynet": sourceBunnynet,
        "runtime": runtime?.toJson(),
    };
}

class Runtime {
    final String? hours;
    final String? minutes;
    final String? seconds;

    Runtime({
        this.hours,
        this.minutes,
        this.seconds,
    });

    factory Runtime.fromJson(Map<String, dynamic> json) => Runtime(
        hours: json["hours"],
        minutes: json["minutes"],
        seconds: json["seconds"],
    );

    Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
    };
}

enum Source {
    BUNNYNET,
    HTML5
}

final sourceValues = EnumValues({
    "bunnynet": Source.BUNNYNET,
    "html5": Source.HTML5
});

class TutorCourseSettings {
    final int? maximumStudents;

    TutorCourseSettings({
        this.maximumStudents,
    });

    factory TutorCourseSettings.fromJson(Map<String, dynamic> json) => TutorCourseSettings(
        maximumStudents: json["maximum_students"],
    );

    Map<String, dynamic> toJson() => {
        "maximum_students": maximumStudents,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
